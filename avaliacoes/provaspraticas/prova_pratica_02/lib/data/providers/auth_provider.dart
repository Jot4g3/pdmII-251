import 'package:flutter/material.dart';
import 'package:bcrypt/bcrypt.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _registeredUser;
  bool _isAuthenticated = false;

  UserModel? get registeredUser => _registeredUser;
  bool get isAuthenticated => _isAuthenticated;

  void register(String email, String password) {
    // Usando bcrypt para segurança maior.
    final String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

    _registeredUser = UserModel(email: email, hashedPassword: hashedPassword);
    print('Usuário cadastrado!');
    notifyListeners();
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
    notifyListeners();
  }
}
