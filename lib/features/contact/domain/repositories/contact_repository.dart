import 'package:howdy/features/contact/domain/entities/contact_entity.dart';

abstract class ContactRepository {
  Future<List<ContactEntity>> fetchContacts();
  Future<List<ContactEntity>> fetchRecentContacts();
  Future<void> addContacts({required String email});
}