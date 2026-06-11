import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
class AppTextField extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Color? fillColor;
  final Color? borderColor;
  final int? maxLines;
  final double? borderRadius;
  final bool readOnly;
  final VoidCallback? onTap;

  const AppTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.fillColor,
    this.borderColor,
    this.maxLines = 1,
    this.borderRadius,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius?.r ?? 8.r;
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      style: AppTextStyles.buttonText,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIconConstraints: BoxConstraints(minWidth: 48.w, maxHeight: 48.w),
        hintStyle: AppTextStyles.hintText,
        prefixIcon: prefixIcon != null
            ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.h),
            child: prefixIcon)
            : null,
        prefixIconConstraints: BoxConstraints(minWidth: 48.w, maxHeight: 48.w),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor ?? AppColors.bg,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: borderColor ?? AppColors.border)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: borderColor ?? AppColors.border)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: borderColor ?? AppColors.primary)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(color: AppColors.danger)),
      ),
    );
  }
}