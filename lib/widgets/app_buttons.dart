import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../theme/app_colors.dart';

// ── Primary Button ─────────────────────────     //
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Widget? icon;
  final double? height;
  final bool isUnderlined;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isUnderlined = false,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.icon,
    this.height
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 56.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.primary,
            disabledBackgroundColor: AppColors.primaryLight,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            elevation: 0),
        child: isLoading ? SizedBox(width: 22.w, height: 22.w,
            child:const CircularProgressIndicator(
                color: AppColors.white, strokeWidth: 2))
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 8.w),
            ],
            Text( text,
                style:AppTextStyles.display.copyWith(
                    color: textColor ?? const Color(0xFFFCFCFC),
                    fontSize: fontSize,fontWeight: fontWeight,
                  decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
                  decorationColor: textColor ?? const Color(0xFFFCFCFC))),
          ],
        ),
      ),
    );
  }
}

// ── Outline Button ─────────────────────────        //
class OutlineButton2 extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final VoidCallback? onPressed;
  final Color? borderColor;
  final Widget? icon;
  final FontWeight? fontWeight;
  final double? height;
  final Color? backgroundColor;

  const OutlineButton2({super.key,this.height,this.backgroundColor, required this.text, this.onPressed,this.borderColor, this.icon, this.textColor,this.fontWeight,
    this.fontSize,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 56.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            backgroundColor: backgroundColor,
            side: BorderSide(color: borderColor ?? AppColors.primary, width: 1.3),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 6.w),
            ],
            Text(text,  style:AppTextStyles.display.copyWith(color: textColor ?? const Color(0xFF66B2A3),fontSize: fontSize,fontWeight: fontWeight)),
          ],
        ),
      ),
    );
  }
}


// ── UploadButton ─────────────────────────        //

class UploadButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final String svgPath;

  const UploadButton({
    super.key,
    required this.text,
    required this.svgPath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xFFF3F4F6),
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.23.r)),
            padding: EdgeInsets.symmetric(vertical: 14.h)),
        icon: SvgPicture.asset(
            svgPath, width: 20.sp, height: 20.sp,
            colorFilter: const ColorFilter.mode(Color(0xFF364153), BlendMode.srcIn)),
        label: Text( text,
          style: AppTextStyles.cs.copyWith(color: const Color(0xFF364153),
          ),
        ),
      ),
    );
  }
}

// ── Social Button (Google / Phone) ─────────    //
class SocialButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback? onPressed;

  const SocialButton({
    super.key,
    required this.icon,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color:Color(0xFFD0D5DD)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            backgroundColor: AppColors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 12.w),
            Text( text,
                style: AppTextStyles.social),
          ],
        ),
      ),
    );
  }
}

// ── Danger Button ──────────────────────────
class DangerButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? elevation;

  const DangerButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.backgroundColor,
    this.borderColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? const Color(0xFFFEF2F2),
            elevation: elevation ?? 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            side: BorderSide(color: borderColor ?? const Color(0xFFFFC9C9))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 8.w),
            ],
            Text(
                text,
                style: AppTextStyles.cs.copyWith(color: AppColors.danger)),
          ],
        ),
      ),
    );
  }
}