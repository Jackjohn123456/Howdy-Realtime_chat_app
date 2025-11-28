// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactEntity _$ContactEntityFromJson(Map<String, dynamic> json) =>
    ContactEntity(
      id: json['contact_id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$ContactEntityToJson(ContactEntity instance) =>
    <String, dynamic>{
      'contact_id': instance.id,
      'username': instance.username,
      'email': instance.email,
    };
