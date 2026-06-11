import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameCtrl = TextEditingController(text: 'Sarah Ahmed');
  final _emailCtrl = TextEditingController(text: 'sarah.ahmed@example.com');
  final _phoneCtrl = TextEditingController(text: '+880 1712-345678');
  final _addressCtrl = TextEditingController(text: '123 Main Street, Gulshan, Dhaka');
  final _schoolCtrl = TextEditingController(text: 'Greenfield International School');
  final _bioCtrl = TextEditingController();
  final _emergencyCtrl = TextEditingController(text: '+880 1823-456789');

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _schoolCtrl.dispose();
    _bioCtrl.dispose();
    _emergencyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20.sp, color: const Color(0xFF0C0C0C)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Edit Profile', style: AppTextStyles.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 48.r,
                    backgroundColor: AppColors.primary.withOpacity(0.15),
                    child: Icon(Icons.person, size: 48.sp, color: AppColors.primary),
                  ),
                  Positioned(
                    bottom: 0, right: 0,
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      child: Icon(Icons.camera_alt, size: 16.sp, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Center(
              child: Text('Click camera icon to change photo',
                  style: AppTextStyles.medium.copyWith(color: Colors.grey)),
            ),
            SizedBox(height: 24.h),

            _buildField('Full Name', _nameCtrl, Icons.person_outline),
            _buildField('Email', _emailCtrl, Icons.email_outlined, enabled: false),
            _buildField('Phone Number', _phoneCtrl, Icons.phone_outlined),
            _buildField('Address', _addressCtrl, Icons.location_on_outlined),
            _buildField('School Preference', _schoolCtrl, Icons.school_outlined),

            _buildLabel('Bio / About'),
            SizedBox(height: 8.h),
            TextField(
              controller: _bioCtrl,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Tell others about yourself...',
                hintStyle: AppTextStyles.medium.copyWith(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(14.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: const Color(0xFFE0E0E0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: const Color(0xFFE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            _buildField('Emergency Contact', _emergencyCtrl, Icons.emergency_outlined),
            SizedBox(height: 24.h),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.withOpacity(0.4)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel', style: AppTextStyles.medium),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text('Save Changes', style: AppTextStyles.medium.copyWith(color: Colors.white)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Text(text, style: AppTextStyles.title),
    );
  }

  Widget _buildField(String label, TextEditingController ctrl, IconData icon, {bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        SizedBox(height: 8.h),
        TextField(
          controller: ctrl,
          enabled: enabled,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.primary, size: 18.sp),
            filled: true,
            fillColor: enabled ? Colors.white : Colors.grey.withOpacity(0.08),
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: const Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: const Color(0xFFE0E0E0)),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: const Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.primary),
            ),
          ),
        ),
        SizedBox(height: 14.h),
      ],
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      currentIndex: 4,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Carpools'),
        BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'Inbox'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}