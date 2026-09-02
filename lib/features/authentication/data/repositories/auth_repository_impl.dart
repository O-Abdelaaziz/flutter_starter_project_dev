import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/auth_token_model.dart';
import '../models/user_dto.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final userDto = await remoteDataSource.login(
      email: email,
      password: password,
    );

    final token = AuthTokenModel(
      accessToken: 'access-token-for-$email',
      refreshToken: 'refresh-token-for-$email',
      expiresAt: DateTime.now().add(const Duration(hours: 1)),
    );

    await localDataSource.saveSession(token);
    return _toEntity(userDto);
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final userDto = await remoteDataSource.register(
      name: name,
      email: email,
      password: password,
    );

    final token = AuthTokenModel(
      accessToken: 'access-token-for-$email',
      refreshToken: 'refresh-token-for-$email',
      expiresAt: DateTime.now().add(const Duration(hours: 1)),
    );

    await localDataSource.saveSession(token);
    return _toEntity(userDto);
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final session = await localDataSource.getSession();
    if (session == null) return null;

    return const UserEntity(
      id: 'cached-user',
      email: 'demo@example.com',
      name: 'Cached User',
    );
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearSession();
  }

  UserEntity _toEntity(UserDTO dto) {
    return UserEntity(
      id: dto.id,
      email: dto.email,
      name: dto.name,
      avatarUrl: dto.avatarUrl,
    );
  }
}
