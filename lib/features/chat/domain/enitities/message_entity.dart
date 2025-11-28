import 'package:json_annotation/json_annotation.dart';

part 'message_entity.g.dart';

@JsonSerializable()
class MessageEntity {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'conversation_id')
  final String conversationId;
  @JsonKey(name: 'sender_id')
  final String senderId;
  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'created_at')
  final String created;

  MessageEntity({required this.id, required this.conversationId, required this.senderId, required this.content, required this.created});

  factory MessageEntity.fromJson(Map<String,dynamic> json)=> _$MessageEntityFromJson(json);
  Map<String,dynamic> toJson()=> _$MessageEntityToJson(this);

}