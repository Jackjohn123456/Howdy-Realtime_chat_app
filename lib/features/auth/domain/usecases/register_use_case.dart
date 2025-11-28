import 'package:howdy/features/auth/domain/entities/user_entity.dart';
import 'package:howdy/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<UserEntity> call({required String email, required String password,required String username}) {
    return repository.register(email: email, password: password, username: username);
  }
}
