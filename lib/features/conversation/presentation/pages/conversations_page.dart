import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:howdy/core/theme.dart';
import 'package:howdy/features/chat/presentation/pages/chat_page.dart';
import 'package:howdy/features/contact/application/bloc/contact_bloc.dart';
import 'package:howdy/features/contact/domain/entities/contact_entity.dart';
import 'package:howdy/features/conversation/application/bloc/conversation_bloc.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key});

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("Called InitState::::::::::::::");
    BlocProvider.of<ConversationBloc>(context).add(FetchConversation());
    BlocProvider.of<ContactBloc>(context).add(FetchRecentContacts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        title: Text("Messages", style: Theme.of(context).textTheme.titleLarge),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text("Recent", style: Theme.of(context).textTheme.bodySmall),
          ),
          Container(
            height: 100,
            padding: EdgeInsets.all(5),
            child: BlocBuilder<ContactBloc, ContactState>(
              builder: (context, state) {
                if (state is RecentContactLoaded) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.recentContacts.length,
                    itemBuilder: (context, index) {
                      final contact = state.recentContacts[index];
                      return _buildRecentContact(context: context,contact: contact);
                    },
                  );
                }
                else if(state is RecentContactError){
                  return Center(child: Text(state.error));
                }
                else if(state is RecentContactLoading){
                  return Center(child: CircularProgressIndicator(color: Colors.white,));
                }
                return Text("Something went completely wrong");
              },
            ),
            ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: DefaultColors.messageListPage,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: BlocBuilder<ConversationBloc, ConversationState>(
                builder: (context, state) {
                  debugPrint(state.runtimeType.toString());
                  if (state is ConversationLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ConversationError) {
                    return Center(child: Text(state.error));
                  } else if (state is ConversationLoaded ) {
                    debugPrint("State Loaded");
                    return ListView.builder(
                      itemCount: state.conversations.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatPage(conversationId:state.conversations[index].id, chatName: state.conversations[index].participantName),));
                          },
                          child: _buildMessageTile(
                            name: state.conversations[index].participantName,
                            message: state.conversations[index].lastMessage,
                            time: state.conversations[index].lastMessageTime.toString(),
                          ),
                        );
                      },
                    );
                  }
                  return Text("Something Completely Went wrong");
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: DefaultColors.buttonColor,
        child: Icon(Icons.person_outline,color: Colors.white,),
          onPressed: () async {
            final res = await Navigator.pushNamed(context, '/contact');
            if(res==null){
              BlocProvider.of<ContactBloc>(context).add(FetchRecentContacts());
            }
          },
      ),
    );
  }

  Widget _buildRecentContact({required BuildContext context, required ContactEntity contact}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              "https://i.pinimg.com/736x/01/5a/f4/015af4828c0ede54f42bd76abbf0bf6d.jpg",
            ),
          ),
          SizedBox(height: 5),
          Text(contact.username, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildMessageTile({
    required String name,
    required String message,
    required String time,
  }) {
    {
      return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            "https://i.pinimg.com/736x/01/5a/f4/015af4828c0ede54f42bd76abbf0bf6d.jpg",
          ),
        ),
        title: Text(
          name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          message,
          style: TextStyle(color: Colors.grey, overflow: TextOverflow.ellipsis),
        ),
        trailing: Text(
          time,
          style: TextStyle(color: Colors.grey, overflow: TextOverflow.ellipsis),
        ),
      );
    }
  }
}
