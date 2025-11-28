import 'package:howdy/features/auth/data/datasource/remote_data_source.dart';
import 'package:howdy/features/auth/domain/entities/user_entity.dart';
import 'package:howdy/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final RemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> login({required String email, required String password}) async {
    // TODO: implement login
    return await remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<UserEntity> register({required String username, required String email, required String password}) async {
    // TODO: implement register
    return await remoteDataSource.register(email: email, password: password, username: username);
  }

}