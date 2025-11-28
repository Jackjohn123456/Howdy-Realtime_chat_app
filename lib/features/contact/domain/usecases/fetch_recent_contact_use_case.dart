import 'package:howdy/features/contact/domain/entities/contact_entity.dart';
import 'package:howdy/features/contact/domain/repositories/contact_repository.dart';

class FetchRecentContactUseCase {
  final ContactRepository repository;

  FetchRecentContactUseCase({required this.repository});

  Future<List<ContactEntity>> call() async {
    return await repository.fetchRecentContacts();
  }
}