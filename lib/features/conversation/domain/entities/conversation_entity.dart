import 'package:json_annotation/json_annotation.dart';

part 'conversation_entity.g.dart';

@JsonSerializable()
class ConversationEntity {
  @JsonKey(name: "conversation_id")
  final String id;
  @JsonKey(name: "participant_name")
  final String participantName;
  @JsonKey(name: "last_message")
  final String lastMessage;
  @JsonKey(name: "last_message_time")
  final DateTime lastMessageTime;

  ConversationEntity({required this.id, required this.participantName, required this.lastMessage, required this.lastMessageTime});

  factory ConversationEntity.fromJson(Map<String,dynamic> json)=> _$ConversationEntityFromJson(json);
  Map<String,dynamic> toJson()=> _$ConversationEntityToJson(this);

}