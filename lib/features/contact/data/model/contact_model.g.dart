// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactModel _$ContactModelFromJson(Map<String, dynamic> json) => ContactModel(
  id: json['contact_id'] as String,
  username: json['username'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$ContactModelToJson(ContactModel instance) =>
    <String, dynamic>{
      'contact_id': instance.id,
      'username': instance.username,
      'email': instance.email,
    };
