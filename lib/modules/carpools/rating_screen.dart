import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_text_field.dart';
import 'my_carpools_screen.dart';

class RatingScreen extends StatefulWidget {
  final Map<String, dynamic> driverInfo;
  final String tripTitle;
  final String date;

  const RatingScreen({
    super.key,
    required this.driverInfo,
    required this.tripTitle,
    required this.date
  });

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _rating = 0;
  final _reviewCtrl = TextEditingController();
  final List<String> _quickFeedback = [
    'Punctual', 'Safe Driver', 'Friendly',
    'Clean Vehicle', 'Good with Kids', 'Professional'
  ];
  final Set<String> _selectedFeedback = {};

  @override
  void dispose() {
    _reviewCtrl.dispose();
    super.dispose();
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
          title: Text('Rate Your Experience', style: AppTextStyles.heading),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(2.0),
              child: Divider(color: Colors.grey.shade300, height: 2, thickness: 2))),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            // ── Driver info card ──
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.26.r),
                  boxShadow: AppColors.cardShadow),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFDBEAFE), width: 3)),
                    child: CircleAvatar(
                      radius: 48.r,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                      backgroundImage: (widget.driverInfo['avatar'] != null && widget.driverInfo['avatar'].startsWith('assets'))
                          ? AssetImage(widget.driverInfo['avatar'])
                          : const AssetImage('assets/images/avatar1.jpg'))),
                  SizedBox(height: 12.h),
                  Text(widget.driverInfo['name'] ?? 'Unknown Driver', style: AppTextStyles.tagline),
                  SizedBox(height: 4.h),
                  Text(widget.tripTitle,
                      style: AppTextStyles.school.copyWith(color:const Color(0xFF4A5565))),
                  SizedBox(height: 4.h),
                  Text(widget.date,
                      style: AppTextStyles.notice),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // ── Rating card ──
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.26.r),
                  boxShadow: AppColors.cardShadow),
              child: Column(
                children: [
                  Text('How was your carpool experience?',
                      style: AppTextStyles.name,
                      textAlign: TextAlign.center),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (i) => GestureDetector(
                      onTap: () => setState(() => _rating = i + 1),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: SvgPicture.asset(
                            i < _rating
                                ? 'assets/icons/star_filled.svg'
                                : 'assets/icons/star_border.svg',
                            width: 48.sp, height: 48.sp,
                            colorFilter: ColorFilter.mode(
                                i < _rating
                                    ? Colors.amber
                                    :const Color(0xFFD1D5DC),
                                BlendMode.srcIn)),
                      ),
                    )),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                      _rating == 0 ? 'Tap a star to rate' : '$_rating / 5',
                      style: AppTextStyles.school.copyWith(color: const Color(0xFF6A7282))),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // ── Write a Review card ──
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.26.r),
                  boxShadow: AppColors.cardShadow),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Write a Review (Optional)',
                      style: AppTextStyles.name),
                  SizedBox(height: 12.h),
                  AppTextField(
                      controller: _reviewCtrl,
                      hintText: 'Share your experience with other parents...',
                      maxLines: 4,
                      borderRadius: 14,
                      fillColor: const Color(0xFFFFFFFF),
                      borderColor: const Color(0xFFD1D5DC)),
                  SizedBox(height: 14.h),
                  Text('Be respectful and constructive in your feedback',
                      style: AppTextStyles.notice),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // ── Quick Feedback card ──
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.26.r),
                  boxShadow: AppColors.cardShadow),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quick Feedback', style: AppTextStyles.name),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: _quickFeedback.map((f) {
                      final selected = _selectedFeedback.contains(f);
                      return GestureDetector(
                        onTap: () => setState(() {
                          selected
                              ? _selectedFeedback.remove(f)
                              : _selectedFeedback.add(f);
                        }),
                        child: Container(
                          padding: EdgeInsets.symmetric( horizontal: 15.w, vertical: 8.h),
                          decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.primary
                                  : const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(20.r)),
                          child: Text(f,
                              style: AppTextStyles.mark.copyWith(
                                  color: selected ? Colors.white : const Color(0xFF364153))),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // ── Submit button ──
            PrimaryButton(
                text: 'Submit Rating',
                textColor: _rating == 0 ? const Color(0xFF6A7282) : Colors.white,
                backgroundColor: _rating == 0 ? const Color(0xFFD1D5DC) : AppColors.primary,
                disabledBackgroundColor: _rating == 0 ? const Color(0xFFD1D5DC) : AppColors.primaryLight,
                icon: SvgPicture.asset('assets/icons/send.svg', width: 20.sp, height: 20.sp,
                    colorFilter: ColorFilter.mode( _rating == 0 ? const Color(0xFF6A7282) : Colors.white, BlendMode.srcIn)),

                onPressed: _rating == 0 ? null : () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MyCarpoolsScreen()),
                        (Route<dynamic> route) => false,
                  );
                },
            ),
            if (_rating == 0)
              Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text( 'Please select a rating before submitting',
                      style: AppTextStyles.school.copyWith(color: const Color(0xFF6A7282)))),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}