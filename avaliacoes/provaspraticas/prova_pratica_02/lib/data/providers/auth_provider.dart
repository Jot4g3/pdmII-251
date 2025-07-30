import 'package:flutter/material.dart';
import 'package:bcrypt/bcrypt.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _registeredUser;
  bool _isAuthenticated = false;
  UserModel? _currentUser;

  UserModel? get registeredUser => _registeredUser;
  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;

  String? register(String email, String password) {
    if (_registeredUser != null && _registeredUser!.email == email) {
      return 'Este e-mail já foi cadastrado.';
    }

    // Usando bcrypt para segurança maior.
    final String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
    _registeredUser = UserModel(email: email, hashedPassword: hashedPassword);

    print('Usuário cadastrado!');
    notifyListeners();
    return null;
  }

  bool login(String email, String password) {
    if (_registeredUser == null || _registeredUser!.email != email) {
      // Se não há usuário cadastrado ou o email não bate, falha.
      _isAuthenticated = false;
      notifyListeners();
      return false;
    }

    // Compara a senha digitada com o hash salvo.
    final bool passwordMatch = BCrypt.checkpw(
      password,
      _registeredUser!.hashedPassword,
    );

    _isAuthenticated = passwordMatch;
    notifyListeners();
    return _isAuthenticated;
  }

  void logout() {
    _isAuthenticated = false;
    _currentUser = null;
    notifyListeners();
  }
}
