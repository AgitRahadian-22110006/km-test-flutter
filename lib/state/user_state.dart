import 'package:flutter/foundation.dart';

class UserState extends ChangeNotifier {
  String _name = '';
  String _selectedUserName = '';
  String _selectedUserEmail = '';
  String _selectedUserAvatar = '';

  // Getters
  String get name => _name;
  String get selectedUserName => _selectedUserName;
  String get selectedUserEmail => _selectedUserEmail;
  String get selectedUserAvatar => _selectedUserAvatar;

  // Setters
  void setName(String value) {
    final trimmed = value.trim();
    if (trimmed != _name) {
      _name = trimmed;
      notifyListeners();
    }
  }

  void setSelectedUser({
    required String name,
    required String email,
    required String avatar,
  }) {
    if (name != _selectedUserName ||
        email != _selectedUserEmail ||
        avatar != _selectedUserAvatar) {
      _selectedUserName = name.trim();
      _selectedUserEmail = email.trim();
      _selectedUserAvatar = avatar.trim();
      notifyListeners();
    }
  }

  void reset() {
    _name = '';
    _selectedUserName = '';
    _selectedUserEmail = '';
    _selectedUserAvatar = '';
    notifyListeners();
  }
}
