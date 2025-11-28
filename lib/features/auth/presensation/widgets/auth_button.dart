import 'package:flutter/material.dart';

import '../../../../core/theme.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const AuthButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed:() {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: DefaultColors.buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)
            ),
            padding: EdgeInsets.symmetric(vertical: 15)
        ),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.grey
          ),
        )
    );
  }

}
