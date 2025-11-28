import 'package:howdy/features/contact/domain/repositories/contact_repository.dart';

class AddContactUseCase {
  final ContactRepository repository;

  AddContactUseCase({required this.repository});

  Future<void> call({required String email}) async {
    return await repository.addContacts(email: email);
  }

}