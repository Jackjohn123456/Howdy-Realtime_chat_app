import 'package:flutter/material.dart';

import '../../../../core/theme.dart';

class AuthInputFields extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool obscureText;
  const AuthInputFields({super.key, required this.hint, required this.icon, required this.controller, this.obscureText=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: DefaultColors.sentMessageInput,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Icon(icon,color: Colors.grey,),
          SizedBox(width: 10,),
          Expanded(
              child:TextField(
                controller: controller,
                obscureText: obscureText,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.grey)
                ),
                style: TextStyle(color: Colors.white),
              )
          )
        ],
      ),
    );
  }
}
