import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../state/user_state.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});
  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  final ScrollController _ctrl = ScrollController();
  final List _users = [];
  int _page = 1;
  bool _loading = false;
  bool _hasMore = true;

  final String _apiKey = 'reqres-free-v1';

  @override
  void initState() {
    super.initState();
    _fetchPage();
    _ctrl.addListener(() {
      if (_ctrl.position.pixels >=
              _ctrl.position.maxScrollExtent - 100 &&
          !_loading) {
        _fetchPage();
      }
    });
  }

  Future<void> _fetchPage() async {
    if (!_hasMore || _loading) return;
    setState(() => _loading = true);

    try {
      final res = await http.get(
        Uri.parse('https://reqres.in/api/users?page=$_page&per_page=6'),
        headers: {'x-api-key': _apiKey},
      );

      if (!mounted) return;

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final List pageData = data['data'];
        if (pageData.isEmpty) {
          _hasMore = false;
        } else {
          setState(() {
            _users.addAll(pageData);
            _page++;
          });
        }
      } else {
        _showError('Failed to fetch users (${res.statusCode})');
      }
    } catch (e) {
      _showError('Error: $e');
    }

    if (!mounted) return;
    setState(() => _loading = false);
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red.shade700),
    );
  }

  Future<void> _onRefresh() async {
    setState(() {
      _users.clear();
      _page = 1;
      _hasMore = true;
    });
    await _fetchPage();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final st = context.read<UserState>();
    final isWide = MediaQuery.of(context).size.width > 600;
    final padding = EdgeInsets.symmetric(
      horizontal: isWide ? 80 : 16,
      vertical: 16,
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Choose a User',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        leading: const BackButton(color: Colors.white),
      ),
      body: Padding(
        padding: padding,
        child: RefreshIndicator(
          color: Colors.teal.shade600,
          onRefresh: _onRefresh,
          child: _users.isEmpty && _loading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  controller: _ctrl,
                  itemCount: _users.length + (_hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _users.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final u = _users[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      elevation: 2,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(u['avatar']),
                          backgroundColor: Colors.grey.shade200,
                        ),
                        title: Text(
                          '${u['first_name']} ${u['last_name']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal.shade900,
                          ),
                        ),
                        subtitle: Text(
                          u['email'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        onTap: () {
                          st.setSelectedUser(
                            name: '${u['first_name']} ${u['last_name']}',
                            email: u['email'],
                            avatar: u['avatar'],
                          );
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
