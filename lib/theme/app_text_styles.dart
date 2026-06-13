import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get average => GoogleFonts.inter(       //
      fontSize: 48.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      height: 1,
      letterSpacing: 0
  );

  static TextStyle get displayMedium => GoogleFonts.inter(       //
    fontSize: 36.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF0C0C0C),
    height: 1.4,
    letterSpacing: 0
  );

  static TextStyle get large => GoogleFonts.inter(     //
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    height: 1.1,
    letterSpacing: 0
  );


  static TextStyle get headlineMedium => GoogleFonts.inter(   //
    fontSize: 30.sp,
    fontWeight: FontWeight.w700,
    color:const Color(0xFF101828),
    height: 1.2,
    letterSpacing: 0
  );

  static TextStyle get headlineLarge => GoogleFonts.inter(    //
    fontSize: 24.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
    height: 1.4,
    letterSpacing: 0
  );

  static TextStyle get cardNumber => GoogleFonts.inter(    //
      fontSize: 24.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
      height: 1.2,
      letterSpacing: 0
  );

  static TextStyle get digit => GoogleFonts.inter(    //
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF757575),
      height: 1.2,
      letterSpacing: 0
  );

  static TextStyle get heading => GoogleFonts.inter(   //
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF101828),
    height: 1.33,
      letterSpacing: 0
  );

  static TextStyle get message => GoogleFonts.inter(   //
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF101828),
      height: 1.5,
      letterSpacing: 0
  );

  static TextStyle get card => GoogleFonts.inter(    //
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: const Color(0xFFFFFFFF),
      height: 1.2,
      letterSpacing: 0
  );

  static TextStyle get tagline => GoogleFonts.inter(    //
    fontSize: 20.33.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF101828),
    height: 1.5,
    letterSpacing: 0
  );


  static TextStyle get title => GoogleFonts.roboto(       //
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF757575),
      height: 1.4,
      letterSpacing: 0
  );

  static TextStyle get head => GoogleFonts.inter(      //
    fontSize: 18.3.sp,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF101828),
    height: 1.6,
    letterSpacing: 0
  );

  static TextStyle get name => GoogleFonts.inter(       //
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF101828),
      height: 1.55,
      letterSpacing: 0
  );

  static TextStyle get delete => GoogleFonts.inter(    //
      fontSize: 17.sp,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF757575),
      height: 1.2,
      letterSpacing: 0
  );

  static TextStyle get medium => GoogleFonts.roboto(       //
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF757575),
    height: 1.5,
    letterSpacing: 0
  );

  static TextStyle get emptyText => GoogleFonts.inter(       //
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF6A7282),
      height: 1.5,
      letterSpacing: 0
  );


  static TextStyle get dropHitText => GoogleFonts.inter(       //
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF99A1AF),
      height: 1,
      letterSpacing: 0
  );

  static TextStyle get label => GoogleFonts.inter(       //
    fontSize: 16.26.sp,
    fontWeight: FontWeight.w400,
    color:const Color(0xFFEFF6FF),
    height: 1.62,
    letterSpacing: 0
  );

  static TextStyle get social => GoogleFonts.roboto(       //
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF344054),
      height: 1.5,
      letterSpacing: 0
  );

  static TextStyle get carpool => GoogleFonts.inter(       //
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF364153),
      height: 1.3,
      letterSpacing: 0
  );

  static TextStyle get display => GoogleFonts.inter(      //
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    height: 1.5,
    letterSpacing: 0
  );

  static TextStyle get cs => GoogleFonts.inter(      //
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
      height: 1.5,
      letterSpacing: 0
  );


  static TextStyle get hintText => GoogleFonts.inter(    //
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF707070),
    height: 1.7,
    letterSpacing: 0,
  );

  static TextStyle get school => GoogleFonts.inter(    //
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF364153),
    height: 1.45,
    letterSpacing: 0,
  );

  static TextStyle get chat => GoogleFonts.inter(     //
    fontSize: 14.23.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF101828),
    height: 1.6,
  );

  static TextStyle get buttonText => GoogleFonts.inter(     //
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.heading,
    height: 1.7,
    letterSpacing: 0,
  );


  static TextStyle get mark => GoogleFonts.inter(   //
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF155DFC),
    height: 1.4,
    letterSpacing: 0
  );

  static TextStyle get action => GoogleFonts.inter(    //
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color:AppColors.primary,
    height: 1.45,
    letterSpacing: 0,
  );

  static TextStyle get small => GoogleFonts.inter(   //
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF4A5565),
    height: 1.4,
    letterSpacing: 0,
  );

  static TextStyle get navText => GoogleFonts.inter(   //
      fontSize: 13.sp,
      fontWeight: FontWeight.w700,
      height: 1.66,
      letterSpacing: 0
  );

  static TextStyle get time => GoogleFonts.inter(    //
    fontSize: 12.2.sp,
    fontWeight: FontWeight.w400,
    color:const Color(0xFF6A7282),
    height: 1.33,
    letterSpacing: 0,
  );

  static TextStyle get notice => GoogleFonts.inter(    //
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color:const Color(0xFF6A7282),
    height: 1.39,
    letterSpacing: 0,
  );

  static TextStyle get address => GoogleFonts.inter(   //
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF707070),
      height: 1.66,
      letterSpacing: 0
  );

  static TextStyle get status => GoogleFonts.inter(   //
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF007A55),
      height: 1.33,
      letterSpacing: 0
  );

  static TextStyle get textSmall => GoogleFonts.inter(   //
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF364153),
    height: 1.5,
    letterSpacing: 0
  );


  static TextStyle get displaySmall => GoogleFonts.inter(     //
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    height: 1.69,
  );

  static TextStyle get pending => GoogleFonts.inter(    //
    fontSize: 8.sp,
    fontWeight: FontWeight.w500,
    color: const Color(0xFFF53838),
    height: 3,
    letterSpacing: 0
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    height: 1.4,
  );

  static TextStyle get labelMedium => GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    letterSpacing: 0.5,
  );

  static TextStyle get labelSmall => GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
    letterSpacing: 0.5,
  );



  static TextStyle get buttonOutline => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    letterSpacing: 0.2,
  );

  // Caption / Overline
  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    letterSpacing: 0.4,
  );

  static TextStyle get overline => GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    letterSpacing: 1.5,
  );



  static TextStyle get success => GoogleFonts.inter(
    fontSize: 28.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.success,
    height: 1.0,
  );







}