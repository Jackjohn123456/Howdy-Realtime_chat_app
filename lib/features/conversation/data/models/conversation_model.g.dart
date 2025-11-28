// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) =>
    ConversationModel(
      id: json['conversation_id'] as String,
      participantName: json['participant_name'] as String,
      lastMessage: json['last_message'] as String,
      lastMessageTime: DateTime.parse(json['last_message_time'] as String),
    );

Map<String, dynamic> _$ConversationModelToJson(ConversationModel instance) =>
    <String, dynamic>{
      'conversation_id': instance.id,
      'participant_name': instance.participantName,
      'last_message': instance.lastMessage,
      'last_message_time': instance.lastMessageTime.toIso8601String(),
    };
