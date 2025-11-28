import 'package:howdy/features/contact/domain/entities/contact_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_model.g.dart';

@JsonSerializable()
class ContactModel extends ContactEntity{
  ContactModel({required super.id, required super.username, required super.email});

  factory ContactModel.fromJson(Map<String,dynamic> json)=> _$ContactModelFromJson(json);
  @override
  Map<String,dynamic> toJson()=> _$ContactModelToJson(this);

}