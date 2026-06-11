import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color bg            = Color(0xFFF8F8F5);    //
  static const Color primary       = Color(0xFF66B2A3);   //
  static const Color primaryLight  = Color(0xFF6DCFBF);
  static const Color primaryDark   = Color(0xFF35A090);
  static const Color primarySubtle = Color(0xFFE8F8F6);
  static const Color accentOrange  = Color(0xFFF5A623);

  static const Color white    = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF7F7F7);
  static const Color border   = Color(0xFFE1E1E1);    //
  static const Color muted    = Color(0xFF99A1AF);    //
  static const Color sub      = Color(0xFF6B6B6B);
  static const Color body     = Color(0xFF3A3A3A);
  static const Color heading  = Color(0xFF1A1A1A);    //

  static const Color danger      = Color(0xFFC10007);  //
  static const Color dangerLight = Color(0xFFFDEAEA);
  static const Color success     = Color(0xFF4BBFAD);

// New Added Gradient Colors
  static const Color gradientStart = Color(0xFF2B7FFF);  //
  static const Color gradientEnd   = Color(0xFF155DFC);   //
  static const Color gradientGreenStart = Color(0xFF00BC7D);  //
  static const Color gradientGreenEnd   = Color(0xFF009966);  //
  static const Color gradientPurpleStart = Color(0xFFAD46FF);  //
  static const Color gradientPurpleEnd   = Color(0xFF9810FA);   //
  static const Color gradientOrangeStart = Color(0xFFFF6900);   //
  static const Color gradientOrangeEnd   = Color(0xFFF54900);    //
  static const Color gradientBluePurpleStart = Color(0xFF2B7FFF);  //
  static const Color gradientBluePurpleEnd   = Color(0xFF9810FA);   //
  static const Color gradientPinkEnd = Color(0xFFE60076);           //

  static const LinearGradient primaryGradient = LinearGradient(  //
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientStart, gradientEnd],
  );

  static const LinearGradient successGradient = LinearGradient(   //
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientGreenStart, gradientGreenEnd],
  );

  static const LinearGradient purpleGradient = LinearGradient(     //
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientPurpleStart, gradientPurpleEnd],
  );

  static const LinearGradient orangeGradient = LinearGradient(     //
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientOrangeStart, gradientOrangeEnd],
  );

  static const LinearGradient bluePurpleGradient = LinearGradient(   //
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientBluePurpleStart, gradientBluePurpleEnd],
  );

  static const LinearGradient purplePinkGradient = LinearGradient(    //
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientPurpleStart, gradientPinkEnd],
  );


  static const List<BoxShadow> commonBoxShadow = [      //
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 2.03),
      blurRadius: 4.06,
      spreadRadius: -2.03,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 4.06),
      blurRadius: 6.1,
      spreadRadius: -1.02,
    ),
  ];

  static const List<BoxShadow> softCardShadow = [       //
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> cardShadow = [    //
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 1.02),
      blurRadius: 2.03,
      spreadRadius: -1.02,
    ),

    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 1.02),
      blurRadius: 3.05,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> shadow = [      //
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 4.06),
      blurRadius: 6.1,
      spreadRadius: -4.06,
    ),

    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 10.16),
      blurRadius: 15.24,
      spreadRadius: -3.05,
    ),
  ];

  static const List<BoxShadow> softShadow = [      //
    BoxShadow(
      color: Color(0x263E9987),
      offset: Offset(2, 4),
      blurRadius: 20,
      spreadRadius: 0,
    ),
  ];
}