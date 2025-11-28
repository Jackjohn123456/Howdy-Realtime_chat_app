import 'package:howdy/features/conversation/domain/entities/conversation_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'conversation_model.g.dart';
@JsonSerializable()
class ConversationModel extends ConversationEntity {
  ConversationModel({required super.id, required super.participantName, required super.lastMessage, required super.lastMessageTime});

  factory ConversationModel.fromJson(Map<String,dynamic> json) => _$ConversationModelFromJson(json);
  @override
  Map<String,dynamic> toJson() => _$ConversationModelToJson(this);
}