import 'package:howdy/features/chat/domain/enitities/message_entity.dart';

abstract class MessageRepository {

  Future<List<MessageEntity>> fetchMessage({required String conversationId});

  Future<void> sendMessage({required MessageEntity message});

}

