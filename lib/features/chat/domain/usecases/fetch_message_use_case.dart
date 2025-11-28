import 'package:howdy/features/chat/domain/enitities/message_entity.dart';
import 'package:howdy/features/chat/domain/repositories/message_repository.dart';

class FetchMessageUseCase {
  final MessageRepository repository;

  FetchMessageUseCase({required this.repository});

  Future<List<MessageEntity>> call({required String conversationId}) async {
    return await repository.fetchMessage(conversationId: conversationId);
  }

}