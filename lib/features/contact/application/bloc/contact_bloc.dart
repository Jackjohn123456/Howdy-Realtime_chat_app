import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:howdy/features/contact/domain/entities/contact_entity.dart';
import 'package:howdy/features/contact/domain/usecases/add_contact_use_case.dart';
import 'package:howdy/features/contact/domain/usecases/fetch_contact_use_case.dart';
import 'package:howdy/features/contact/domain/usecases/fetch_recent_contact_use_case.dart';
import 'package:howdy/features/conversation/domain/usecases/check_or_create_conversation_use_case.dart';

part 'contact_event.dart';
part 'contact_state.dart';


class ContactBloc extends Bloc<ContactEvent,ContactState>{
  final AddContactUseCase addContactUseCase;
  final FetchContactUseCase fetchContactUseCase;
  final CheckOrCreateConversationUseCase checkOrCreateConversationUseCase;
  final FetchRecentContactUseCase fetchRecentContactUseCase;

  ContactBloc({required this.fetchRecentContactUseCase,required this.checkOrCreateConversationUseCase, required this.addContactUseCase, required this.fetchContactUseCase}):super(InitialContactState()){
    on<FetchContactEvent>(_fetchContacts);
    on<AddContactEvent>(_addContact);
    on<FetchRecentContacts>(_fetchRecentContacts);
    on<CheckOrCreateConversation>(_checkOrCreateConversation);
  }

  Future<void> _fetchContacts(FetchContactEvent event, Emitter<ContactState> emit) async {
    try {
      emit(LoadingContactState());
      final List<ContactEntity> contactList = await fetchContactUseCase();
      emit(LoadedContactState(contactList: contactList));
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(ErrorContactState(message: "No Contact Found"));
    }
  }

  Future<void> _addContact(AddContactEvent event, Emitter<ContactState> emit) async {
    try {
      emit(LoadingContactState());
      await addContactUseCase(email: event.email);
      emit(AddedContactState());
      add(FetchContactEvent());
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(ErrorContactState(message: "No Contact Found"));
    }
  }

  Future<void> _checkOrCreateConversation(CheckOrCreateConversation event, Emitter<ContactState> emit) async {
    emit(LoadingContactState());
    final conversationId = await checkOrCreateConversationUseCase.call(contactId: event.contactId);
    emit(ConversationCreated(name: event.name,conversationID: conversationId));
  }

  Future<void> _fetchRecentContacts(FetchRecentContacts event, Emitter<ContactState> emit) async {
    emit(RecentContactLoading());
    try {
      final recentContacts =await fetchRecentContactUseCase();
      emit(RecentContactLoaded(recentContacts: recentContacts));
    } on Exception catch (e) {
      // TODO
      debugPrint(e.toString());
      emit(RecentContactError(error: "Failed to load recent contacts"));
    }
  }

}