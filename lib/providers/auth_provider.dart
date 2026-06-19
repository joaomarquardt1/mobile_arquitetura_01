import 'package:flutter/material.dart';
import '../data/datasources/auth_remote_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/entities/user.dart';
import '../session/session_manager.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRemoteDataSource _datasource = AuthRemoteDataSource();
  late final AuthRepositoryImpl _repository;
  final SessionManager _sessionManager = SessionManager();

  bool _isLoading = false;
  String? _errorMessage;
  User? _currentUser;

  AuthProvider() {
    _repository = AuthRepositoryImpl(_datasource);
    _currentUser = _sessionManager.currentUser;
  }

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await _repository.login(username, password);
      _sessionManager.login(_currentUser!);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Erro no login: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _currentUser = null;
    _sessionManager.logout();
    _errorMessage = null;
    notifyListeners();
  }
}
