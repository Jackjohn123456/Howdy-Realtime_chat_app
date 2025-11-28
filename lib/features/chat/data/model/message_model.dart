import 'package:howdy/features/chat/domain/enitities/message_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel extends MessageEntity{
  MessageModel({required super.id, required super.conversationId, required super.senderId, required super.content, required super.created});

  factory MessageModel.fromJson(Map<String,dynamic> json)=> _$MessageModelFromJson(json);
  @override
  Map<String,dynamic> toJson()=> _$MessageModelToJson(this);
}