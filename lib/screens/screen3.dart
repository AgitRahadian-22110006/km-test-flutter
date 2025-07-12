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
      if (_ctrl.position.pixels >= _ctrl.position.maxScrollExtent - 100 && !_loading) {
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
        headers: {
          'x-api-key': _apiKey,
        },
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
        _showError('Failed to fetch users: ${res.statusCode}');
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
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
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
  Widget build(BuildContext ctx) {
    final st = ctx.read<UserState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade400,
        title: const Text('Choose a User'),
        centerTitle: true,
        leading: const BackButton(color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: _users.isEmpty && _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                controller: _ctrl,
                padding: const EdgeInsets.all(16),
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
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(u['avatar']),
                        backgroundColor: Colors.grey.shade200,
                      ),
                      title: Text(
                        '${u['first_name']} ${u['last_name']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(u['email']),
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
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
}
