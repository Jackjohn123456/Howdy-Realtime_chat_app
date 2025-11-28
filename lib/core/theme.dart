
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontSizes{
  static const small = 12.0;
  static const standard = 14.0;
  static const standardUp = 16.0;
  static const medium = 20.0;
  static const large = 28.0;
}

class DefaultColors{
  static const greyText = Color(0xFFB3B9C9);
  static const whiteText = Color(0xFFFFFFFF);
  static const senderMessage = Color(0xFF7A8194);
  static const receiverMessage = Color(0xFF373E4E);
  static const sentMessageInput = Color(0xFF3D4354);
  static const messageListPage = Color(0xFF292F3F);
  static const buttonColor = Color(0xFF7A8194);
  static const backgroundColor = Color(0xFF1B202D);
}

class AppTheme{
  static ThemeData get darkTheme{
    return ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: DefaultColors.backgroundColor,
      textTheme: TextTheme(
        titleMedium: GoogleFonts.alegreyaSans(
          color: Colors.white,
          fontSize: FontSizes.medium
        ),
        titleLarge: GoogleFonts.alegreyaSans(
            color: Colors.white,
            fontSize: FontSizes.large
        ),
        bodyMedium: GoogleFonts.alegreyaSans(
            color: Colors.white,
            fontSize: FontSizes.standard
        ),
        bodyLarge: GoogleFonts.alegreyaSans(
            color: Colors.white,
            fontSize: FontSizes.standardUp
        ),
        bodySmall: GoogleFonts.alegreyaSans(
            color: Colors.white,
            fontSize: FontSizes.standardUp
        )
      )
    );
  }

  static ThemeData get lightTheme{
    return ThemeData(

    );
  }
}