import 'dart:io';

import 'package:carpooling/modules/profile/support_call_screen.dart';
import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/app_text_field.dart';
import 'email_support_screen.dart';
import 'legal_document_screen.dart';
import 'live_chat_support_screen.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final _reportCtrl = TextEditingController();
  int? _expandedFaq;

  final List<Map<String, String>> _faqs = [
    {
      'q': 'How to create a carpool?',
      'a': 'Go to the Carpools tab, tap the + button, fill in the details including pickup location, destination, time, and select children. You can also invite other parents before creating the carpool.',
    },
    {
      'q': 'How to invite parents to my carpool?',
      'a': 'Open your carpool, tap "Members", then tap "Invite Parents". You can search by name, phone, or email.',
    },
    {
      'q': 'How does driver assignment work?',
      'a': 'Any member of the carpool can become the driver. Open the carpool details and tap "Become a Driver" to assign yourself.',
    },
    {
      'q': 'How does tracking work?',
      'a': 'Once a trip starts, live tracking is enabled. All carpool members can see the driver\'s location in real time.',
    },
  ];

  @override
  void dispose() {
    _reportCtrl.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  File? _selectedImage;

  // ─── Submit Text Only ──────────────────────────────────────────
  void _submitTextOnly() {
    if (_reportCtrl.text.isEmpty) {
      AppSnackBar.show(
        context: context,
        message: "Please describe your issue first.",
        backgroundColor: Colors.red,
      );
      return;
    }

    // API না থাকা পর্যন্ত আপাতত একটি মেসেজ দেখান
    print("Submitting text: ${_reportCtrl.text}");
    AppSnackBar.show(
      context: context,
      message: "Report submitted successfully!",
      backgroundColor: Colors.green,
    );
    _reportCtrl.clear(); // ইনপুট খালি করে দিন
  }

  // ─── Upload with Image ──────────────────────────────────────────
  void _uploadWithImage(File image) {
    if (_reportCtrl.text.isEmpty) {
      AppSnackBar.show(
        context: context,
        message: "Please describe your issue first.",
        backgroundColor: Colors.red,
      );
      return;
    }

    // এখানে পরে API ইন্টিগ্রেশন করবেন
    print("Submitting text: ${_reportCtrl.text} with image: ${image.path}");

    AppSnackBar.show(
      context: context,
      message: "Report with screenshot submitted!",
      backgroundColor: Colors.green,
    );

    // কাজ শেষ হলে স্টেট রিসেট করুন
    setState(() {
      _selectedImage = null;
      _reportCtrl.clear();
    });
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
          title: Text('Help & Support', style: AppTextStyles.heading),

          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(2.0),
              child: Divider(color: Colors.grey.shade300, height: 2, thickness: 2))),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.38.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FAQ
            _buildFaq().animate().fadeIn(delay: 50.ms, duration: 300.ms),
            SizedBox(height: 24.38.h),

            // Contact Support
            _buildContactSupport().animate().fadeIn(delay: 100.ms, duration: 300.ms),
            SizedBox(height: 24.38.h),

            // Legal Information
            _buildLegal().animate().fadeIn(delay: 150.ms, duration: 300.ms),
            SizedBox(height: 24.38.h),

            // Report a Problem
            _buildReport().animate().fadeIn(delay: 200.ms, duration: 300.ms),
            SizedBox(height: 24.38.h),

            // App Information
            _buildAppInfo().animate().fadeIn(delay: 250.ms, duration: 300.ms),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 4),
    );
  }

  // ─── FAQ ──────────────────────────────────────────────────────
  Widget _buildFaq() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.32.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.26.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 1.02),
            blurRadius: 2.03,
            spreadRadius: -1.02),
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 1.02),
            blurRadius: 3.05,
            spreadRadius: 0),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  Title
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/help_outline.svg', width: 20.sp, height: 20.sp,
                colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn)),
              SizedBox(width: 8.w),
              Text('Frequently Asked Questions',
                  style: AppTextStyles.tagline),
            ],
          ),
          SizedBox(height: 16.25.h),

          //  প্রতিটা FAQ আলাদা inner card এ
          ..._faqs.asMap().entries.map((e) {
            final i = e.key;
            final faq = e.value;
            final isOpen = _expandedFaq == i;

            return Container(
              margin: EdgeInsets.only(bottom: 12.19.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14.23.r),
                border: Border.all(color: const Color(0xFFE5E7EB),width: 1.24)),
              child: InkWell(
                borderRadius: BorderRadius.circular(14.23.r),
                onTap: () => setState(() => _expandedFaq = isOpen ? null : i),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(faq['q']!, style: AppTextStyles.display.copyWith(color:const Color(0xFF101828)))),
                          Icon(
                            isOpen
                                ? Icons.keyboard_arrow_down
                                : Icons.arrow_forward_ios,
                            size: isOpen ? 18.sp : 14.sp,
                            color: const Color(0xFF99A1AF),
                          ),
                        ],
                      ),
                      if (isOpen) ...[
                        SizedBox(height: 16.h),
                      const Divider(color: Color(0xFFF3F4F6), height: 2, thickness: 2),
                        SizedBox(height: 8.h),
                        Text(faq['a']!,
                            style: AppTextStyles.school.copyWith(color:const Color(0xFF4A5565))),
                        if (i == 3) ...[
                          SizedBox(height: 6.h),
                          GestureDetector(
                            onTap: () => _launchUrl('https://hadikid.com/details.html'),
                            child: Text(
                              'https://hadikid.com/details.html',
                              style: AppTextStyles.medium.copyWith(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ─── Contact Support ──────────────────────────────────────────
  Widget _buildContactSupport() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.32.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.26.r),
        boxShadow: const [
          BoxShadow(
              color: Color(0x1A000000),
              offset: Offset(0, 1.02),
              blurRadius: 2.03,
              spreadRadius: -1.02),
          BoxShadow(
              color: Color(0x1A000000),
              offset: Offset(0, 1.02),
              blurRadius: 3.05,
              spreadRadius: 0),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              SvgPicture.asset(
                  'assets/icons/chat.svg', width: 20.sp, height: 20.sp,
                  colorFilter: const ColorFilter.mode(Color(0xFF009966), BlendMode.srcIn)),
              SizedBox(width: 8.w),
              Text('Contact Support',
                  style: AppTextStyles.tagline),
            ],
          ),
          SizedBox(height: 16.25.h),

          //  প্রতিটা item আলাদা inner card এ
          _contactCard(
              svgPath: 'assets/icons/chat.svg',
              iconColor: AppColors.primary,
              bgColor: const Color(0xFFEFF6FF),
              title: 'Live Chat Support',
              sub:'Chat with our support team',
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const LiveChatSupportScreen()))),

          SizedBox(height: 12.19.h),

          _contactCard(
              svgPath: 'assets/icons/email_outlined.svg',
              iconColor: const Color(0xFF9810FA),
              bgColor: const Color(0xFFFAF5FF),
              title:'Email Support',
              sub:'support@carpool.com',
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const EmailSupportScreen()))),

          SizedBox(height: 12.19.h),

          _contactCard(
            svgPath: 'assets/icons/phone_outlined.svg',
            iconColor:const Color(0xFF009966),
            bgColor: const Color(0xFFECFDF5),
            title:'Call Support',
            sub:'+880 1712-345678',
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SupportCallScreen())),
          ),
        ],
      ),
    );
  }

  Widget _contactCard({
    required String svgPath,
    required String title,
    required String sub,
    required VoidCallback onTap,
    required Color iconColor,
    required Color bgColor,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14.23.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          children: [
            SvgPicture.asset( svgPath, width: 24.sp, height: 24.sp,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn)),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.cs.copyWith(color:const Color(0xFF101828))),
                  SizedBox(height: 2.h),
                  Text(sub,
                      style: AppTextStyles.mark.copyWith(color: const Color(0xFF4A5565))),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 14.sp, color:const Color(0xFF99A1AF)),
          ],
        ),
      ),
    );
  }

  // ─── Legal Information ────────────────────────────────────────
  Widget _buildLegal() {
    final items = [
      {'svg': 'assets/icons/privacy.svg', 'label': 'Privacy Policy'},
      {'svg': 'assets/icons/description_outlined.svg', 'label': 'Terms of Service'},
      {'svg': 'assets/icons/carpool_outlined.svg', 'label': 'Community Guidelines'},
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.32.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.26.r),
        boxShadow: const [
          BoxShadow(
              color: Color(0x1A000000),
              offset: Offset(0, 1.02),
              blurRadius: 2.03,
              spreadRadius: -1.02),
          BoxShadow(
              color: Color(0x1A000000),
              offset: Offset(0, 1.02),
              blurRadius: 3.05,
              spreadRadius: 0),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  Title
          Row(
            children: [
              SvgPicture.asset(
                  'assets/icons/description_outlined.svg', width: 20.sp, height: 20.sp,
                  colorFilter: const ColorFilter.mode(Color(0xFF4A5565), BlendMode.srcIn)),
              SizedBox(width: 8.w),
              Text('Legal Information',
                  style: AppTextStyles.tagline),
            ],
          ),
          SizedBox(height: 16.25.h),

          ...items.asMap().entries.map((e) {
            final i = e.key;
            final item = e.value;
            return Column(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LegalDocumentScreen(
                        title: item['label'] as String,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12.h),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          item['svg'] as String,
                          width: 20.sp,
                          height: 20.sp,
                          colorFilter: const ColorFilter.mode(Color(0xFF99A1AF), BlendMode.srcIn)),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(item['label'] as String,
                              style: AppTextStyles.display.copyWith(color: const Color(0xFF101828))),
                        ),
                        Icon(Icons.arrow_forward_ios, size: 14.sp, color: const Color(0xFF99A1AF)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  // ─── Report a Problem ─────────────────────────────────────────
  Widget _buildReport() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.32.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.26.r),
        boxShadow: const [
          BoxShadow(
              color: Color(0x1A000000),
              offset: Offset(0, 1.02),
              blurRadius: 2.03,
              spreadRadius: -1.02),
          BoxShadow(
              color: Color(0x1A000000),
              offset: Offset(0, 1.02),
              blurRadius: 3.05,
              spreadRadius: 0),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              SvgPicture.asset(
                  'assets/icons/upload_outlined.svg', width: 20.sp, height: 20.sp,
                  colorFilter: const ColorFilter.mode(Color(0xFFE7000B), BlendMode.srcIn)),

              SizedBox(width: 8.w),
              Text('Report a Problem',
                  style: AppTextStyles.tagline),
            ],
          ),
          SizedBox(height: 16.25.h),

          //  Text area
          AppTextField(
            controller: _reportCtrl,
            hintText: "Describe the issue you're experiencing...",
            fillColor: AppColors.white,
            borderColor: const Color(0xFFD1D5DC),
            borderRadius: 14.23.r,
            maxLines: 5),

          SizedBox(height: 17.h),

          // Upload button
          UploadButton(
            text: _selectedImage == null ? 'Upload Screenshot (Optional)' : 'Change Screenshot',
            svgPath: 'assets/icons/upload_outlined.svg',
            onPressed: () async {
              final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (image != null) {
                setState(() {
                  _selectedImage = File(image.path);
                });
              }
            },
          ),
          SizedBox(height: 12.19.h),

          if (_selectedImage != null)
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.file(_selectedImage!, height: 100.h, width: double.infinity, fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
          SizedBox(height: 12.19.h),
          //  Submit button
          PrimaryButton(
            text: 'Submit Report',
            onPressed: _selectedImage == null
                ? () => _submitTextOnly()
                : () => _uploadWithImage(_selectedImage!),
          ),
        ],
      ),
    );
  }

  // ─── App Information ──────────────────────────────────────────
  Widget _buildAppInfo() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.32.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.26.r),
        boxShadow: const [
          BoxShadow(
              color: Color(0x1A000000),
              offset: Offset(0, 1.02),
              blurRadius: 2.03,
              spreadRadius: -1.02),
          BoxShadow(
              color: Color(0x1A000000),
              offset: Offset(0, 1.02),
              blurRadius: 3.05,
              spreadRadius: 0),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  Title
          Row(
            children: [
              SvgPicture.asset(
                  'assets/icons/info_outline.svg', width: 20.sp, height: 20.sp,
                  colorFilter: const ColorFilter.mode(Color(0xFF4A5565), BlendMode.srcIn)),

              SizedBox(width: 8.w),
              Text('App Information',
                  style: AppTextStyles.tagline),
            ],
          ),
          SizedBox(height: 16.25.h),

          //  App Version row
          _infoRow('App Version', '2.4.1'),
          SizedBox(height: 12.19.h),

          //  Last Updated row
          _infoRow('Last Updated', 'May 10, 2026'),
          SizedBox(height: 12.19.h),

          //  Up to date button
          InkWell(
            onTap: () {
              AppSnackBar.show(
                context: context,
                message: "Your app is already up to date!",
                backgroundColor: const Color(0xFF007A55),
                position: SnackPosition.bottom,
              );
            },
            borderRadius: BorderRadius.circular(14.23.r),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.19.h),
              decoration: BoxDecoration(
                color: const Color(0xFFECFDF5),
                borderRadius: BorderRadius.circular(14.23.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                      'assets/icons/up_to_date.svg',
                      width: 10.sp,
                      height: 10.sp,
                      colorFilter: const ColorFilter.mode(Color(0xFF007A55), BlendMode.srcIn)),
                  SizedBox(width: 6.w),
                  Text(
                      'Up to date',
                      style: AppTextStyles.cs.copyWith(color: const Color(0xFF007A55))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.19.w, vertical: 12.19.h),
      decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(14.23.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: AppTextStyles.display.copyWith(color: const Color(0xFF364153))),
          Text(value,
              style: AppTextStyles.cs.copyWith(color: const Color(0xFF101828))),
        ],
      ),
    );
  }
  }
