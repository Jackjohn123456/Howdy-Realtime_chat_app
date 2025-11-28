import 'package:howdy/features/conversation/data/datasource/conversation_remote_data_source.dart';
import 'package:howdy/features/conversation/domain/entities/conversation_entity.dart';
import 'package:howdy/features/conversation/domain/repositories/conversations_repository.dart';

class ConversationRepositoryImpl extends ConversationsRepository{
  final ConversationRemoteDataSource remoteDataSource;

  ConversationRepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<List<ConversationEntity>> fetchConversations() async {
    // TODO: implement fetchConversations
    return await remoteDataSource.fetchConversations();
  }

  @override
  Future<String> checkOrCreateConversation({required String contactId}) async {
    // TODO: implement checkOrCreateConversation
    return await remoteDataSource.checkOrCreateConversation(contactId: contactId);
  }

}