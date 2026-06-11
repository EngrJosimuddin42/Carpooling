import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckboxListItem extends StatelessWidget {
  final String label;
  final bool selected;
  final String? subtitle;
  final VoidCallback onTap;
  final bool showArrow;

  const CheckboxListItem({
    super.key,
    required this.label,
    required this.selected,
    this.subtitle,
    required this.onTap,
    this.showArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.56.h),
        padding: EdgeInsets.symmetric(horizontal: 16.75.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFE5E7EB))),
        child: Row(
          children: [
            // Checkbox box
            Container(
              width: 21.w,
              height: 21.w,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4.r),
                color: selected ? AppColors.primary : const Color(0xFFA8A8A8)),
              child: selected
                  ? Icon(Icons.check, color: Colors.white, size: 16.sp)
                  : null,
            ),
            SizedBox(width: 13.w),
            // Label + optional subtitle
            Expanded(
              child: subtitle != null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: AppTextStyles.social
                          .copyWith(color: const Color(0xFF101828))),
                  Text(subtitle!,
                      style: AppTextStyles.mark
                          .copyWith(color: const Color(0xFF4A5565))),
                ],
              )
                  : Text(label,
                  style: AppTextStyles.social
                      .copyWith(color: const Color(0xFF101828))),
            ),
            // Arrow
            if (showArrow)
              SvgPicture.asset(
                'assets/icons/arrow_right.svg', width: 24.sp, height: 24.sp,
                colorFilter: const ColorFilter.mode(Color(0xFF1C274C), BlendMode.srcIn),
              ),
          ],
        ),
      ),
    );
  }
}