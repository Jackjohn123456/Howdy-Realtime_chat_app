import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:howdy/features/conversation/data/models/conversation_model.dart';
import 'package:http/http.dart' as http;

class ConversationRemoteDataSource {
  final String baseUrl;

  ConversationRemoteDataSource({required this.baseUrl});

  final _storage = FlutterSecureStorage();

  Future<List<ConversationModel>> fetchConversations() async {
    debugPrint("fetchConversations:::::::::::::");
    String token = await _storage.read(key: "token")??'';
    final response =await http.get(
      Uri.parse('$baseUrl/conversation'),
      headers: {
        'Authorization':'Bearer $token'
      }
    );
    debugPrint("All Conversations");
    if(response.statusCode==200){
      final List data = jsonDecode(response.body);
      debugPrint(data.toString());
      return data.map((e)=>ConversationModel.fromJson(e)).toList();
    }
    else{
      throw Exception('Failed to Fetch Conversations');
    }
  }

  Future<String> checkOrCreateConversation({required String contactId}) async {
    String token = await _storage.read(key: "token")??'';
    debugPrint(contactId);
    final response =await http.post(
      Uri.parse('$baseUrl/conversation/check-or-create'),
      body: jsonEncode({
        'contactId':contactId
      }),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      }
    );
    debugPrint(response.body);
    if(response.statusCode==200){
      final data = jsonDecode(response.body);
      final String conversationId = data['conversationId'];
      return conversationId;
    }
    else{
      throw Exception('Failed to check or create Conversations');
    }
  }
}