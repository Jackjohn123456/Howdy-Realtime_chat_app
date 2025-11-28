import 'package:howdy/features/conversation/domain/repositories/conversations_repository.dart';

class CheckOrCreateConversationUseCase {
  final ConversationsRepository repository;

  CheckOrCreateConversationUseCase({required this.repository});

  Future<String> call({required String contactId}) async {
    return await repository.checkOrCreateConversation(contactId: contactId);
  }

}