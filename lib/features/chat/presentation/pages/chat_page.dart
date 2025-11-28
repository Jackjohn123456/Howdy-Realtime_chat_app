import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:howdy/core/theme.dart';
import 'package:howdy/features/chat/application/bloc/message_bloc.dart';

class ChatPage extends StatefulWidget {
  final String conversationId;
  final String chatName;
  const ChatPage({super.key,required this.conversationId, required this.chatName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final  _messageController = TextEditingController();
  final _storage = FlutterSecureStorage();
  String userId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUser();
    BlocProvider.of<MessageBloc>(context).add(LoadMessagesEvent(conversationId: widget.conversationId));
  }

  fetchUser() async {
    userId = await _storage.read(key: 'userId')??"";
    debugPrint("UserId::::::::::::::::::$userId");
    setState(() {
      userId = userId;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _messageController.dispose();
  }

  void _sendMessage(){
    debugPrint("Tap:::::send message");
    final content = _messageController.text;
    if(content.isNotEmpty){
      BlocProvider.of<MessageBloc>(context).add(SendMessageEvent(conversationId: widget.conversationId, content: content, senderId: userId));
    }
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://i.pinimg.com/736x/01/5a/f4/015af4828c0ede54f42bd76abbf0bf6d.jpg"
              ),
            ),
            SizedBox(width: 10,),
            Text(
              widget.chatName,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {

          },
              icon: Icon(Icons.search))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child:BlocBuilder<MessageBloc,MessageState>(builder: (context, state) {
                if(state is MessageStateLoading){
                  return Center(child: CircularProgressIndicator());
                }
                else if(state is MessageStateLoaded){
                  debugPrint("state message length::::::${state.messages.length}");
                  return ListView.builder(
                    itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        debugPrint("index::::::$index");
                        final message = state.messages[index];
                        bool isSent = message.senderId == userId;
                        if(isSent){
                          return _buildSentMessage(context, message.content);
                        }
                        else{
                          return _buildReceivedMessage(context, message.content);
                        }
                      },);
                }
                else if(state is MessageStateError){
                  return Center(child: Text(state.error));
                }
                else{
                  return Center(child: Text("Start Messaging"));
                }
              },)
          ),
          _buildMessageInput()
        ],
      ),
    );
  }

  _buildReceivedMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: 30,top: 5,bottom: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: DefaultColors.receiverMessage,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(
            message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  _buildSentMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(right: 30,top: 5,bottom: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: DefaultColors.receiverMessage,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(
            message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  _buildMessageInput() {
    return Container(
      decoration: BoxDecoration(
        color: DefaultColors.sentMessageInput,
        borderRadius: BorderRadius.circular(25)
      ),
      margin: EdgeInsets.all(25),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          GestureDetector(
            child: Icon(
              Icons.camera_alt,
              color: Colors.grey,
            ),
            onTap: () {

            },
          ),
          SizedBox(width: 10,),
          Expanded(child: TextField(
            controller: _messageController,
            decoration:InputDecoration(
              hintText: "Message",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none
            ),
            style: TextStyle(
              color: Colors.white
            ),
          )),
          SizedBox(width: 10,),
          GestureDetector(
            onTap: ()=>_sendMessage(),
            child: Icon(
                Icons.send,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
