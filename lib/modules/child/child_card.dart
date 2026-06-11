import 'dart:io';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../models/child_model.dart';
import '../../theme/app_colors.dart';


class ChildCard extends StatelessWidget {
  final ChildModel child;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onView;

  const ChildCard({super.key,required this.child, required this.onDelete, required this.onEdit,required this.onView});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color:const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40.r,
                backgroundColor: AppColors.primarySubtle,
                backgroundImage: child.photoPath != null ? FileImage(File(child.photoPath!)) : null,
                child: child.photoPath == null
                    ? SvgPicture.asset(
                  'assets/icons/person_outline.svg', width: 24.w, height: 24.w,
                  colorFilter: const ColorFilter.mode(AppColors.muted, BlendMode.srcIn))
                    : null),
               SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(child.fullName,
                        style:AppTextStyles.name),
                    SizedBox(height: 5.h),
                    if (child.schoolName.isNotEmpty)
                      Row(children: [
                        SvgPicture.asset(
                            'assets/icons/school_outlined.svg', width: 14.sp, height: 14.sp,
                            colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn)),
                         SizedBox(width: 4.h),
                        Text(child.schoolName,
                            style:AppTextStyles.school),
                      ]),
                    SizedBox(height: 5.h),
                    if (child.grade.isNotEmpty)
                      Text(child.grade,
                          style:AppTextStyles.small.copyWith(fontSize: 14.sp)),
                    SizedBox(height: 5.h),
                    Row(children: [
                      SvgPicture.asset(
                          'assets/icons/group_outlined.svg', width: 12.sp, height: 12.sp,
                          colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn)),
                      SizedBox(width: 4.h),
                      Text('Added by ${child.relationship}',
                          style: AppTextStyles.textSmall.copyWith(color: AppColors.primary)),
                    ]),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: ActionBtn(
                  iconPath: 'assets/icons/view_outlined.svg',
                  label: 'View',
                  color: AppColors.primary,
                  onTap: onView,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ActionBtn(
                  iconPath: 'assets/icons/edit_outlined.svg',
                  label: 'Edit',
                  color: const Color(0xFF007A55),
                  onTap: onEdit,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ActionBtn(
                  iconPath: 'assets/icons/delete_outline.svg',
                  label: 'Delete',
                  color: AppColors.danger,
                  onTap: onDelete,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ActionBtn extends StatelessWidget {
  final String iconPath;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const ActionBtn({super.key,required this.iconPath, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.16.r),
          color: color.withValues(alpha: 0.05)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath, width: 14.w, height: 14.w,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
            SizedBox(width: 6.w),
            Text(label, style: AppTextStyles.action.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}