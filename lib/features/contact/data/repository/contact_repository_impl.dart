import 'package:howdy/features/contact/data/datasource/contact_remote_data_source.dart';
import 'package:howdy/features/contact/domain/entities/contact_entity.dart';
import 'package:howdy/features/contact/domain/repositories/contact_repository.dart';

class ContactRepositoryImpl extends ContactRepository{

  final ContactRemoteDataSource remoteDataSource;

  ContactRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addContacts({required String email}) async {
    await remoteDataSource.addContacts(email: email);
  }

  @override
  Future<List<ContactEntity>> fetchContacts() async {
   return await remoteDataSource.fetchContacts();
  }

  @override
  Future<List<ContactEntity>> fetchRecentContacts() async {
    // TODO: implement fetchRecentContacts
    return await remoteDataSource.fetchRecentContact();
  }

}