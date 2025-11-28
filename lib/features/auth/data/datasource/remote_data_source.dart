import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:howdy/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class RemoteDataSource {
  final String baseUrl;

  RemoteDataSource({required this.baseUrl});

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'content-type': 'application/json'},
    ).timeout(Duration(seconds: 2));
    // if (res.statusCode == 200) {
    //   return UserModel.fromJson(jsonDecode(res.body));
    // } else {
    //   return null;
    // }
    return UserModel.fromJson(jsonDecode(res.body)["user"]);
  }

  Future<UserModel> register({
    required String email,
    required String password,
    required String username,
  }) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      body: jsonEncode({
        'email': email,
        'password': password,
        'username': username,
      }),
      headers: {'content-type': 'application/json'},
    );
    debugPrint(res.body);
    // if (res.statusCode == 200) {
    //   return UserModel.fromJson(jsonDecode(res.body));
    // } else {
    //   return null;
    // }
    return UserModel.fromJson(jsonDecode(res.body)["user"]);
  }
}
