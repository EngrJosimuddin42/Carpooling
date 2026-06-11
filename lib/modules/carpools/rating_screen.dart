import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _rating = 0;
  final _reviewCtrl = TextEditingController();
  final List<String> _quickFeedback = ['Punctual', 'Safe Driver', 'Friendly', 'Clean Vehicle', 'Good with Kids', 'Professional'];
  final Set<String> _selectedFeedback = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20.sp, color: const Color(0xFF0C0C0C)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Rate Your Experience', style: AppTextStyles.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40.r,
              backgroundColor: AppColors.primary.withOpacity(0.15),
              child: Icon(Icons.person, size: 40.sp, color: AppColors.primary),
            ),
            SizedBox(height: 12.h),
            Text('Ahmed Rahman', style: AppTextStyles.large),
            Text('Morning School Run',
                style: AppTextStyles.medium.copyWith(color: Colors.grey)),
            Text('May 14, 2026',
                style: AppTextStyles.medium.copyWith(color: Colors.grey)),
            SizedBox(height: 24.h),

            Text('How was your carpool experience?', style: AppTextStyles.title),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) => GestureDetector(
                onTap: () => setState(() => _rating = i + 1),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Icon(
                    i < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 36.sp,
                  ),
                ),
              )),
            ),
            SizedBox(height: 6.h),
            Text(_rating == 0 ? 'Tap a star to rate' : '$_rating / 5',
                style: AppTextStyles.medium.copyWith(color: Colors.grey)),
            SizedBox(height: 24.h),

            Align(
              alignment: Alignment.centerLeft,
              child: Text('Write a Review (Optional)', style: AppTextStyles.title),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: _reviewCtrl,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Share your experience with other parents...',
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
            SizedBox(height: 6.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Be respectful and constructive in your feedback',
                  style: AppTextStyles.medium.copyWith(color: Colors.grey)),
            ),
            SizedBox(height: 20.h),

            Align(
              alignment: Alignment.centerLeft,
              child: Text('Quick Feedback', style: AppTextStyles.title),
            ),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: _quickFeedback.map((f) {
                final selected = _selectedFeedback.contains(f);
                return GestureDetector(
                  onTap: () => setState(() {
                    selected ? _selectedFeedback.remove(f) : _selectedFeedback.add(f);
                  }),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: selected ? AppColors.primary : const Color(0xFFE0E0E0),
                      ),
                    ),
                    child: Text(f,
                        style: AppTextStyles.medium.copyWith(
                            color: selected ? Colors.white : Colors.grey)),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 24.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _rating == 0 ? Colors.grey : AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                icon: Icon(Icons.star_outline, color: Colors.white, size: 18.sp),
                label: Text('Submit Rating',
                    style: AppTextStyles.medium.copyWith(color: Colors.white)),
                onPressed: _rating == 0 ? null : () => Navigator.pop(context),
              ),
            ),
            if (_rating == 0)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text('Please select a rating before submitting',
                    style: AppTextStyles.medium.copyWith(color: Colors.grey)),
              ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      currentIndex: 1,
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