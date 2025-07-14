// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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

    if (mounted) setState(() => _loading = false);
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
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
    final padding = EdgeInsets.symmetric(horizontal: isWide ? 80 : 16, vertical: 16);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4A00E0),
              Color(0xFF8E2DE2),
              Color(0xFF000428),
            ],
            stops: [0.0, 0.5, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    bottom: BorderSide(color: Colors.purpleAccent.shade100.withValues(alpha: 76), width: 1.5),
                  ),
                ),
                child: Row(
                  children: [
                    BackButton(color: Colors.purpleAccent.shade100),
                    Expanded(
                      child: Text(
                        'Choose a User',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purpleAccent.shade100,
                          shadows: [
                            Shadow(blurRadius: 4, color: Colors.black54, offset: Offset(1, 1)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  color: Colors.purpleAccent.shade100,
                  onRefresh: _onRefresh,
                  child: _users.isEmpty && _loading
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.purpleAccent.shade100),
                          ),
                        )
                      : ListView.builder(
                          controller: _ctrl,
                          padding: padding,
                          itemCount: _users.length + (_hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == _users.length) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 24),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(Colors.purpleAccent.shade100),
                                  ),
                                ),
                              );
                            }
                            final u = _users[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.purpleAccent.shade100.withValues(alpha: 76),
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 12,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(u['avatar']),
                                  backgroundColor: Colors.transparent,
                                ),
                                title: Text(
                                  '${u['first_name']} ${u['last_name']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.purpleAccent.shade100,
                                  ),
                                ),
                                subtitle: Text(
                                  u['email'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
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
            ],
          ),
        ),
      ),
    );
  }
}
