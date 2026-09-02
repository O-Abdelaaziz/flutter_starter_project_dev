import '../models/auth_token_model.dart';
import '../models/user_dto.dart';

abstract class AuthRemoteDataSource {
  Future<UserDTO> login({
    required String email,
    required String password,
  });

  Future<UserDTO> register({
    required String name,
    required String email,
    required String password,
  });

  Future<AuthTokenModel> refreshToken({required String refreshToken});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl();

  @override
  Future<UserDTO> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));

    return UserDTO(
      id: 'auth-user-1',
      email: email,
      name: 'Demo User',
      avatarUrl: 'https://picsum.photos/200',
    );
  }

  @override
  Future<UserDTO> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    return UserDTO(
      id: 'auth-user-2',
      email: email,
      name: name,
      avatarUrl: null,
    );
  }

  @override
  Future<AuthTokenModel> refreshToken({required String refreshToken}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    return AuthTokenModel(
      accessToken: 'demo_access_token',
      refreshToken: refreshToken,
      expiresAt: DateTime.now().add(const Duration(hours: 1)),
    );
  }
}
