import 'dart:io';
import 'package:carpooling/data/app_data.dart';
import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:carpooling/widgets/app_bottom_nav.dart';
import 'package:carpooling/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/app_buttons.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _addressCtrl;
  late final TextEditingController _schoolCtrl;
  late final TextEditingController _bioCtrl;
  late final TextEditingController _emergencyCtrl;

  String? _photoPath;

  @override
  void initState() {
    super.initState();
    final p = AppData().userProfile.value;
    _nameCtrl      = TextEditingController(text: p['name']);
    _phoneCtrl     = TextEditingController(text: p['phone']);
    _addressCtrl   = TextEditingController(text: p['address']);
    _schoolCtrl    = TextEditingController(text: p['school']);
    _bioCtrl       = TextEditingController(text: p['bio']);
    _emergencyCtrl = TextEditingController(text: p['emergency']);
    _photoPath     = p['avatar']!.isEmpty ? null : p['avatar'];
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _schoolCtrl.dispose();
    _bioCtrl.dispose();
    _emergencyCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _photoPath = picked.path);
  }

  void _save() {
    AppData().userProfile.value = {
      'name':      _nameCtrl.text.trim(),
      'phone':     _phoneCtrl.text.trim(),
      'address':   _addressCtrl.text.trim(),
      'school':    _schoolCtrl.text.trim(),
      'bio':       _bioCtrl.text.trim(),
      'emergency': _emergencyCtrl.text.trim(),
      'avatar':    _photoPath ?? '',
    };
    Navigator.pop(context);
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
                          color: Color(0xFFF3F4F6), shape: BoxShape.circle),
                      child: Icon(Icons.arrow_back, size: 22.sp,
                          color: const Color(0xFF364153))))),
          title: Text('Edit Profile', style: AppTextStyles.heading),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(2.0),
              child: Divider(color: Colors.grey.shade300, height: 2, thickness: 2))),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Avatar ──
            Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3.31),
                          boxShadow: const [
                            BoxShadow(color: Color(0x1A000000), offset: Offset(0, 3.61), blurRadius: 5.41),
                            BoxShadow(color: Color(0x1A000000), offset: Offset(0, 9.02), blurRadius: 13.54),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 65.r,
                          backgroundColor: const Color(0x3366B2A3),
                          backgroundImage: _photoPath != null
                              ? (_photoPath!.startsWith('assets/')
                              ? AssetImage(_photoPath!) as ImageProvider
                              : FileImage(File(_photoPath!)))
                              : null,
                          child: _photoPath == null
                              ? SvgPicture.asset('assets/icons/person_outline.svg',
                              width: 65.w, height: 65.w,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.primary, BlendMode.srcIn))
                              : null,
                        )),
                    GestureDetector(
                        onTap: _pickPhoto,
                        child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 3.31)),
                            child: Icon(Icons.camera_alt_outlined,
                                size: 14.sp, color: Colors.white))),
                  ],
                )),
            SizedBox(height: 8.h),
            Center(
                child: Text('Click camera icon to change photo',
                    style: AppTextStyles.school.copyWith(
                        color: const Color(0xFF4A5565)))),
            SizedBox(height: 24.h),

            _buildField('Full Name',         _nameCtrl,    'assets/icons/person_outline.svg'),
            _buildField('Phone Number',      _phoneCtrl,     'assets/icons/phone_outlined.svg'),
            _buildField('Address',           _addressCtrl,   'assets/icons/location.svg'),
            _buildField('School Preference', _schoolCtrl,    'assets/icons/school_outlined.svg'),

            _buildLabel('Bio / About'),
            SizedBox(height: 8.h),
            AppTextField(
              hintText: 'Tell others about yourself...',
              controller: _bioCtrl,
              maxLines: 3,
              borderRadius: 14.23.r,
              borderColor:const Color(0xFFD1D5DC),
              fillColor:const Color(0xFFF9FAFB),
              prefixIcon: Padding(
                padding:const  EdgeInsets.symmetric(vertical: 15),
                child: SvgPicture.asset('assets/icons/description_outlined.svg', width: 20.sp, height: 20.sp,
                  colorFilter: const ColorFilter.mode(Color(0xFF99A1AF), BlendMode.srcIn),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            _buildField('Emergency Contact', _emergencyCtrl, 'assets/icons/info_outline.svg'),
            SizedBox(height: 24.h),

            Row(
              children: [
                Expanded(
                  child: OutlineButton2(
                    text: 'Cancel',
                    height: 57.h,
                    backgroundColor: const Color(0xFFE5E7EB),
                    textColor: const Color(0xFF364153),
                    borderColor: Colors.transparent,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: PrimaryButton(
                    text: 'Save Changes',
                    height: 57.h,
                    onPressed: _save,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 4),
    );
  }

  Widget _buildLabel(String text) => Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Text(text, style: AppTextStyles.mark.copyWith(color:const Color(0xFF364153))));

  Widget _buildField(String label, TextEditingController ctrl, String svgPath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        SizedBox(height: 8.h),
        AppTextField(
          hintText: label,
          borderColor:const Color(0xFFD1D5DC),
          borderRadius: 14.23.r,
          controller: ctrl,
          fillColor: const Color(0xFFF9FAFB),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: SvgPicture.asset(
              svgPath,
              colorFilter: const ColorFilter.mode(Color(0xFF99A1AF), BlendMode.srcIn),
              width: 20.sp,
              height: 20.sp,
            ),
          ),
        ),
        SizedBox(height: 14.h),
      ],
    );
  }
}