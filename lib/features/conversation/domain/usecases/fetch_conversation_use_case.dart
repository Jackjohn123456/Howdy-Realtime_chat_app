import 'package:howdy/features/conversation/domain/entities/conversation_entity.dart';
import 'package:howdy/features/conversation/domain/repositories/conversations_repository.dart';

class FetchConversationUseCase{
  final ConversationsRepository repository;

  FetchConversationUseCase({required this.repository});

  Future<List<ConversationEntity>>  call() async {
    return await repository.fetchConversations();
  }

}