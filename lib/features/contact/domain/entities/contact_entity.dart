import 'package:json_annotation/json_annotation.dart';

part 'contact_entity.g.dart';

@JsonSerializable()
class ContactEntity {
  @JsonKey(name: "contact_id")
  final String id;
  final String username;
  final String email;

  ContactEntity({required this.id, required this.username, required this.email});

  factory ContactEntity.fromJson(Map<String,dynamic> json)=> _$ContactEntityFromJson(json);
  Map<String,dynamic> toJson()=> _$ContactEntityToJson(this);

}