part of 'contact_bloc.dart';

sealed class ContactEvent {}

class AddContactEvent extends ContactEvent{
  final String email;

  AddContactEvent({required this.email});
}

class FetchContactEvent extends ContactEvent{
  FetchContactEvent();
}

class CheckOrCreateConversation extends ContactEvent{
  final String name;
  final String contactId;

  CheckOrCreateConversation({required this.name, required this.contactId});
}

class FetchRecentContacts extends ContactEvent{}

