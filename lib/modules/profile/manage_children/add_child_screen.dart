import 'dart:io';
import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/child_model.dart';
import '../../../widgets/app_bottom_nav.dart';
import '../../../widgets/app_buttons.dart';
import '../../../widgets/app_text_field.dart';

class AddChildScreen extends StatefulWidget {
  const AddChildScreen({super.key});

  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  final _nameCtrl = TextEditingController();
  final _schoolCtrl = TextEditingController();
  final _gradeCtrl = TextEditingController();
  final _relationCtrl = TextEditingController();

  String? _photoPath;
  bool _showForm = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _schoolCtrl.dispose();
    _gradeCtrl.dispose();
    _relationCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _photoPath = picked.path);
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text('Add Child', style: AppTextStyles.heading),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(2.0),
              child: Divider(color: Colors.grey.shade300, height: 2, thickness: 2))),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            _buildAvatar('Add child\'s photo'),

            SizedBox(height: 24.h),

            _fieldLabel("Child's Full Name"),
            SizedBox(height: 7.21.h),
            AppTextField(
                controller: _nameCtrl,
                fillColor: Colors.white,
                borderColor:const Color(0xFFD1D5DC),
                hintText: "Enter child's name",
                prefixIcon: SvgPicture.asset(
                    'assets/icons/person_outline.svg', width: 20.sp, height: 20.sp,
                    colorFilter: const ColorFilter.mode(AppColors.muted, BlendMode.srcIn))),

            SizedBox(height: 16.h),

            _fieldLabel("School Name"),
            SizedBox(height: 7.21.h),
            AppTextField(
                controller: _schoolCtrl,
                fillColor: Colors.white,
                borderColor:const Color(0xFFD1D5DC),
                hintText: "Enter school name",
                prefixIcon: SvgPicture.asset(
                    'assets/icons/school_outlined.svg', width: 20.sp, height: 20.sp,
                    colorFilter: const ColorFilter.mode(AppColors.muted, BlendMode.srcIn))),

            SizedBox(height: 16.h),

            _fieldLabel("Grade / Class"),
            SizedBox(height: 7.21.h),
            AppTextField(
                controller: _gradeCtrl,
                fillColor: Colors.white,
                borderColor:const Color(0xFFD1D5DC),
                hintText: "e.g., 3rd Grade",
                prefixIcon: SvgPicture.asset(
                    'assets/icons/school_outlined.svg', width: 20.sp, height: 20.sp,
                    colorFilter: const ColorFilter.mode(AppColors.muted, BlendMode.srcIn))),

            SizedBox(height: 16.h),
            _fieldLabel("Your Relationship"),
            SizedBox(height: 8.13.h),
            AppTextField(
              controller: _relationCtrl,
              fillColor: Colors.white,
              borderColor: const Color(0xFFD1D5DC),
              hintText: "Mother",
              prefixIcon: SvgPicture.asset(
                  'assets/icons/group_outlined.svg',
                  width: 20.sp,
                  height: 20.sp,
                  colorFilter: const ColorFilter.mode(AppColors.muted, BlendMode.srcIn)
              ),
            ),

            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    backgroundColor:const Color(0xFFE5E7EB),
                    textColor: const Color(0xFF364153),
                    text: 'Cancel',
                    onPressed: () => setState(() => _showForm = false),
                  ),
                ),

                SizedBox(width: 12.w),
                Expanded(
                  child: PrimaryButton(
                    text: 'Add Child',
                    onPressed: () {
                      if (_nameCtrl.text.isNotEmpty) {
                        final newChild = ChildModel(
                          id: DateTime.now().toIso8601String(),
                          fullName: _nameCtrl.text,
                          schoolName: _schoolCtrl.text,
                          grade: _gradeCtrl.text,
                          relationship: _relationCtrl.text,
                          photoPath: _photoPath,
                        );
                        Navigator.pop(context, newChild);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 4),
    );
  }

  Widget _buildAvatar(String label) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickPhoto,
          child: Stack(
            alignment: Alignment.bottomRight,
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
                      backgroundImage: _photoPath != null ? FileImage(File(_photoPath!)) : null,
                      child: _photoPath == null
                          ? SvgPicture.asset(
                          'assets/icons/person_outline.svg', width: 58.w, height: 58.w,
                          colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn))
                          : null)),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primary,
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
                child:Icon(Icons.camera_alt_outlined, size: 14.sp, color: AppColors.white),
              )
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Text("Add child's photo",
            style: AppTextStyles.small),
      ],
    );
  }

  Widget _fieldLabel(String text) => Align(
    alignment: Alignment.centerLeft,
    child: Text(text, style: AppTextStyles.textSmall),
  );
}