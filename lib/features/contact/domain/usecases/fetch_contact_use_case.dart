import 'package:howdy/features/contact/domain/entities/contact_entity.dart';
import 'package:howdy/features/contact/domain/repositories/contact_repository.dart';

class FetchContactUseCase {
  final ContactRepository repository;

  FetchContactUseCase({required this.repository});

  Future<List<ContactEntity>> call() async {
    return await repository.fetchContacts();
  }
  
}