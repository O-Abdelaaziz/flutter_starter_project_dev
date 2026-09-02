import '../models/auth_token_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveSession(AuthTokenModel tokenModel);
  Future<AuthTokenModel?> getSession();
  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthTokenModel? _session;

  @override
  Future<void> saveSession(AuthTokenModel tokenModel) async {
    _session = tokenModel;
  }

  @override
  Future<AuthTokenModel?> getSession() async {
    return _session;
  }

  @override
  Future<void> clearSession() async {
    _session = null;
  }
}
