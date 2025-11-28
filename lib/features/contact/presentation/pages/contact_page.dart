import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:howdy/core/theme.dart';
import 'package:howdy/features/chat/presentation/pages/chat_page.dart';
import 'package:howdy/features/contact/application/bloc/contact_bloc.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ContactBloc>(context).add(FetchContactEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: BlocListener<ContactBloc,ContactState>(
          listener:(context, state) async {
            final contactBloc =  BlocProvider.of<ContactBloc>(context);
            if(state is ConversationCreated){
              final res = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatPage(conversationId: state.conversationID, chatName:state.name),));
              if (res==null) {
                contactBloc.add(FetchContactEvent());
              }
            }
          },
        child: BlocBuilder<ContactBloc,ContactState>(
          builder: (context, state) {
            if(state is LoadingContactState) {
              return Center(child: CircularProgressIndicator());
            }
            else if(state is LoadedContactState) {
              return ListView.builder(
                itemCount: state.contactList.length,
                itemBuilder:(context, index) {
                  final contact = state.contactList[index];
                  return ListTile(
                    tileColor: DefaultColors.buttonColor,
                    title: Text(contact.username),
                    subtitle: Text(contact.email),
                    onTap: () {
                      BlocProvider.of<ContactBloc>(context).add(CheckOrCreateConversation(name: contact.username, contactId:contact.id));
                    },
                  );
                },
              );
            }
            else if(state is ErrorContactState){
              return Center(child: Text(state.message),);
            }
            return Center(child: Text("You have no Friends"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: DefaultColors.buttonColor,
          onPressed:() => _showAddContactDialog(context),
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    final emailController = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Add Contact"),
      content: TextField(
        controller: emailController,
        decoration: InputDecoration(
          hintText: "email"
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text("cancel")),
        ElevatedButton(onPressed: (){
          final email = emailController.text.trim();
          if(email.isNotEmpty){
            BlocProvider.of<ContactBloc>(context).add(AddContactEvent(email: email));
            Navigator.pop(context);
          }
        }, child: Text("Add"))
      ],
    ),);
  }
}
