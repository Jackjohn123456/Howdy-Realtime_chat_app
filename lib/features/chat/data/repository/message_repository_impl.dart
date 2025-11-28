import 'package:howdy/features/chat/data/datasource/messages_remote_data_source.dart';
import 'package:howdy/features/chat/domain/enitities/message_entity.dart';
import 'package:howdy/features/chat/domain/repositories/message_repository.dart';

class MessageRepositoryImpl extends MessageRepository{
  final MessagesRemoteDataSource remoteDataSource;

  MessageRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MessageEntity>> fetchMessage({required String conversationId}) async {
    // TODO: implement fetchMessage
    return await remoteDataSource.fetchMessage(conversationId);
  }

  @override
  Future<void> sendMessage({required MessageEntity message}) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
}