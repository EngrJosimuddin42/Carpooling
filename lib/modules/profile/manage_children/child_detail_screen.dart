import 'dart:io';

import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../models/child_model.dart';
import '../../../widgets/app_bottom_nav.dart';
import '../../../widgets/app_buttons.dart';

class ChildDetailScreen extends StatefulWidget {
  final ChildModel child;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const ChildDetailScreen({super.key, required this.child, required this.onEdit, required this.onDelete});

  @override
  State<ChildDetailScreen> createState() => _ChildDetailScreenState();
}

class _ChildDetailScreenState extends State<ChildDetailScreen> {
  late ChildModel _currentChild;

  @override
  void initState() {
    super.initState();
    _currentChild = widget.child;
  }


  @override
  Widget build(BuildContext context) {
    final imageFile = _currentChild.photoPath != null ? File(_currentChild.photoPath!) : null;
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
          backgroundColor: const Color(0xFFF9FAFB),
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          leadingWidth: 72.w,
          titleSpacing: 8.w,
          leading: Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Color(0xFFF3F4F6),
                          shape: BoxShape.circle),
                      child: Icon(Icons.arrow_back, size: 22.sp, color: const Color(0xFF364153))))),
          title: Text('Child Details', style: AppTextStyles.heading),
          actions: [
            GestureDetector(
                onTap: widget.onEdit,
                child: Container(
                    margin: EdgeInsets.only(right: 24.38.w),
                    padding: EdgeInsets.all(10.w),
                    decoration:const BoxDecoration(
                        color: Color(0xFFDBEAFE),
                        shape: BoxShape.circle),
                    child: SvgPicture.asset(
                        'assets/icons/edit_outlined.svg', width: 20.sp, height: 20.sp,
                        colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn)))),
          ],

          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(2.0),
              child: Divider(color: Colors.grey.shade300, height: 2, thickness: 2))),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3.31),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0x1A000000),
                        offset: Offset(0, 3.61),
                        blurRadius: 5.41,
                        spreadRadius: -3.61),
                    BoxShadow(
                        color: Color(0x1A000000),
                        offset: Offset(0, 9.02),
                        blurRadius: 13.54,
                        spreadRadius: -2.71),
                  ],
                ),
                child: CircleAvatar(
                    radius: 58.r,
                    backgroundColor: const Color(0x3366B2A3),
                    backgroundImage: imageFile != null ? FileImage(imageFile) : null,
                    child: imageFile == null
                        ? SvgPicture.asset(
                        'assets/icons/person_outline.svg', width: 58.w, height: 58.w,
                        colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn))
                        : null)),

            SizedBox(height: 16.h),

            Text(_currentChild.fullName, style: AppTextStyles.heading),

            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(20.r)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/icons/group_outlined.svg', width: 16.sp, height: 16.sp,
                      colorFilter: const ColorFilter.mode(Color(0xFF66B2A3), BlendMode.srcIn)),
                  SizedBox(width: 8.w),
                  Text('Added by ${_currentChild.relationship}',
                      style: AppTextStyles.mark.copyWith( color: const Color(0xFF66B2A3))),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            _detailItem(
                svgPath: 'assets/icons/school_outlined.svg',
                iconColor:const Color(0xFF009966),
                backgroundColor:const Color(0xFFDBEAFE),
                label: 'School',
                value: _currentChild.schoolName),

            _detailItem(
                svgPath: 'assets/icons/school_outlined.svg',
                iconColor: const Color(0xFF9810FA),
                backgroundColor:const Color(0xFFF3E8FF),
                label: 'Grade / Class',
                value: _currentChild.grade),

            _detailItem(
                svgPath: 'assets/icons/carpool_outlined.svg',
                iconColor: const Color(0xFFE17100),
                backgroundColor: const Color(0xFFFEF3C6),
                label: 'Your Relationship',
                value: _currentChild.relationship),
            SizedBox(height: 45.h),

            Row(
              children: [
                Expanded(
                    child: PrimaryButton(
                        text: 'Edit Details',
                        icon: SvgPicture.asset(
                            'assets/icons/edit_outlined.svg', width: 20.sp, height: 20.sp,
                            colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
                        onPressed: widget.onEdit)),

                SizedBox(width: 12.w),

                Expanded(
                    child: DangerButton(
                        text: 'Delete Child',
                        icon: SvgPicture.asset(
                            'assets/icons/delete_outline.svg', width: 20.sp, height: 20.sp,
                            colorFilter: const ColorFilter.mode(AppColors.danger, BlendMode.srcIn)),
                        onPressed: widget.onDelete)),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 4),
    );
  }

  Widget _detailItem({
    required String svgPath,
    required Color iconColor,
    required Color backgroundColor,
    required String label,
    required String value,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.23.r),
          boxShadow: const [
            BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(0, 3.61),
                blurRadius: 5.41,
                spreadRadius: -3.61),
            BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(0, 9.02),
                blurRadius: 13.54,
                spreadRadius: -2.71),
          ]),
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle),
              child: SvgPicture.asset(
                  svgPath, width: 18.sp, height: 18.sp,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn))),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.school.copyWith(color:const Color(0xFF4A5565))),
              Text(value, style: AppTextStyles.head.copyWith(height: 1.55)),
            ],
          ),
        ],
      ),
    );
  }
}