import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:howdy/features/chat/data/model/message_model.dart';
import 'package:http/http.dart' as http;

class MessagesRemoteDataSource {
  final String baseUrl;
  final _storage = FlutterSecureStorage();

  MessagesRemoteDataSource({required this.baseUrl});

  Future<List<MessageModel>> fetchMessage(String conversationId) async {
      final token =await _storage.read(key: "token");
      final res = await http.get(
        Uri.parse('$baseUrl/messages/$conversationId'),
        headers: {
          'Authorization':'Bearer $token'
        }
      );
      if(res.statusCode==200){
        final List list =  jsonDecode(res.body);
        return list.map((e) => MessageModel.fromJson(e),).toList();
      }
      else{
        throw Exception("Failed to Fetch Message");
      }
  }

  

}