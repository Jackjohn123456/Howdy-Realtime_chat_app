import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:howdy/features/contact/data/model/contact_model.dart';
import 'package:http/http.dart' as http;

class ContactRemoteDataSource {
  final String baseUrl;
  final _storage = FlutterSecureStorage();

  ContactRemoteDataSource({required this.baseUrl});

  Future<List<ContactModel>> fetchContacts() async {
    final token =await _storage.read(key: "token");
    debugPrint(token.toString());
    final res =await  http.get(
      Uri.parse("$baseUrl/contacts/"),
      headers: {
        'Authorization':'Bearer $token'
      }
    );
    debugPrint(res.body);
    if(res.statusCode==200){
      final List data = jsonDecode(res.body);
      return data.map((e) => ContactModel.fromJson(e),).toList();
    }
    else {
      throw Exception("Failed to Fetch Contacts");
    }
  }

  Future<void> addContacts({required String email}) async {
    final token =await _storage.read(key: "token");
    final res =await  http.post(
      Uri.parse("$baseUrl/contacts/"),
      body: jsonEncode({
        'contactEmail':email,
      }),
      headers: {
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      }
    );
    debugPrint(res.body);
    if(res.statusCode!=201){
      throw Exception("Failed to Fetch Contacts");
    }
  }

  Future<List<ContactModel>> fetchRecentContact() async {
    final token =await _storage.read(key: "token");
    debugPrint(token.toString());
    final res =await  http.get(
        Uri.parse("$baseUrl/contacts/recent"),
        headers: {
          'Authorization':'Bearer $token'
        }
    );
    if(res.statusCode==200){
      final List data = jsonDecode(res.body);
      return data.map((e) => ContactModel.fromJson(e),).toList();
    }
    else {
      throw Exception("Failed to fetch recent contacts");
    }
  }

}