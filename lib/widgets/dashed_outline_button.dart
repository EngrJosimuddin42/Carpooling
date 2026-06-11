import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashedOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? borderColor;
  final List<double> dashPattern;

  const DashedOutlineButton({
    super.key,
    required this.text,
    this.onPressed,
    this.borderColor,
    this.dashPattern = const [6, 3],
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(12.r),
      color: borderColor ?? AppColors.primary,
      dashPattern: dashPattern,
      strokeWidth: 1.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: SizedBox(
          width: double.infinity,
          height: 56.h,
          child: InkWell(
            onTap: onPressed,
            child: Center(
              child: Text( text,
                style: AppTextStyles.display,
              )),
          ),
        ),
      ),
    );
  }
}