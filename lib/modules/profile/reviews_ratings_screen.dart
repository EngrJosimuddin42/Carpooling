import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import '../../widgets/app_bottom_nav.dart';

class ReviewsRatingsScreen extends StatefulWidget {
  const ReviewsRatingsScreen({super.key});

  @override
  State<ReviewsRatingsScreen> createState() => _ReviewsRatingsScreenState();
}

class _ReviewsRatingsScreenState extends State<ReviewsRatingsScreen> {
  String _selectedSort = 'Recent Reviews';
  bool _positiveOnly = false;

  final List<Map<String, dynamic>> _reviews = [
    {
      'reviewer': 'Sarah Ahmed',
      'avatarUrl': null,
      'reviewed': 'Abdullah Rahman',
      'date': 'May 12, 2026',
      'rating': 5,
      'comment': 'Very safe and punctual driver. Kids felt comfortable throughout the ride.',
    },
    {
      'reviewer': 'Rahman Khan',
      'avatarUrl': null,
      'reviewed': 'Sarah Ahmed',
      'date': 'May 11, 2026',
      'rating': 5,
      'comment': 'Excellent experience! Very responsible and caring with the children.',
    },
    {
      'reviewer': 'Nadia Hossain',
      'avatarUrl': null,
      'reviewed': 'Karim Ali',
      'date': 'May 10, 2026',
      'rating': 4,
      'comment': 'Good driver, but was 5 minutes late. Otherwise great service.',
    },
    {
      'reviewer': 'Karim Ali',
      'avatarUrl': null,
      'reviewed': 'Rahman Khan',
      'date': 'May 9, 2026',
      'rating': 5,
      'comment': 'Highly recommend! Very professional and friendly driver.',
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    List<Map<String, dynamic>> list = List.from(_reviews);
    if (_positiveOnly) list = list.where((r) => r['rating'] >= 4).toList();
    if (_selectedSort == 'Highest Rated') {
      list.sort((a, b) => b['rating'].compareTo(a['rating']));
    }
    return list;
  }

  double get _averageRating {
    if (_reviews.isEmpty) return 0;
    final total = _reviews.fold(0, (sum, r) => sum + (r['rating'] as int));
    return total / _reviews.length;
  }

  int get _totalReviews => _reviews.length;

  int get _positiveCount =>
      _reviews.where((r) => r['rating'] >= 4).length;

  int get _positivePercent =>
      _totalReviews == 0 ? 0 : (_positiveCount * 100 / _totalReviews).round();

  Map<int, int> get _dynamicStarDist {
    final dist = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (final r in _reviews) {
      final star = r['rating'] as int;
      dist[star] = (dist[star] ?? 0) + 1;
    }
    return dist;
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
              child: Icon(Icons.arrow_back,
                  size: 22.sp, color: const Color(0xFF364153))))),
        title: Text('Reviews & Ratings', style: AppTextStyles.heading)),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Colors.grey.shade300, height: 2, thickness: 2),
            SizedBox(height: 20.h),
            _buildSummaryCard().animate().fadeIn(duration: 400.ms),
            SizedBox(height: 24.h),
            _buildSortRow().animate().fadeIn(delay: 100.ms, duration: 300.ms),
            SizedBox(height: 24.h),
            ..._filtered.asMap().entries.map((e) => _reviewCard(e.value)
                .animate()
                .fadeIn(delay: (200 + e.key * 80).ms, duration: 300.ms)
                .slideY(begin: 0.1)),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 4),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A8D79),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow:const [
          BoxShadow(
              color:  Color(0x1A000000),
              offset: Offset(0, 4.07),
              blurRadius: 6.1,
              spreadRadius: -4.07),
          BoxShadow(
            color:  Color(0x1A000000),
            offset: Offset(0, 10.16),
            blurRadius: 15.25,
            spreadRadius: -3.05),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_averageRating.toStringAsFixed(1),
                      style: AppTextStyles.average),
                  SizedBox(height: 4.h),
                  _starRow(_averageRating, color: Colors.white, size: 20.sp),
                  SizedBox(height: 4.h),
                  Text('Average Rating',
                      style: AppTextStyles.school.copyWith(color: Colors.white)),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/car.svg', width: 20.sp, height: 22.sp,
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                      SizedBox(width: 10.w),
                      Text('$_totalReviews Completed Rides',
                          style: AppTextStyles.social.copyWith(color: Colors.white,fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/trending_up.svg', width: 20.sp, height: 22.sp,
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                      SizedBox(width: 4.w),
                      Text('$_positivePercent% positive reviews',
                          style: AppTextStyles.school.copyWith(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...[5, 4, 3, 2, 1].map((star) => _starBar(star)),
        ],
      ),
    );
  }

  Widget _starBar(int star) {
    final dist = _dynamicStarDist;
    final total = _reviews.length;
    final count = dist[star] ?? 0;
    final ratio = total == 0 ? 0.0 : count / total;

    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        children: [
          Text('$star',
              style: AppTextStyles.school.copyWith(color: Colors.white)),
          SizedBox(width: 4.w),
          SvgPicture.asset('assets/icons/star.svg', width: 14.sp, height: 14.sp,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
          SizedBox(width: 8.w),
          Expanded(
              child: Container(
                  height: 8.h,
                  decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4.r)),
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                      widthFactor: ratio,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.r)))))),
          SizedBox(width: 8.w),
          SizedBox(
            width: 20.w,
            child: Text('$count',
                style: AppTextStyles.school.copyWith(color: Colors.white),
                textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  Widget _buildSortRow() {
    return Row(
      children: [
        SvgPicture.asset('assets/icons/filter_alt_outlined.svg', width: 18.sp, height: 20.sp,
            colorFilter: const ColorFilter.mode(Color(0xFF4A5565), BlendMode.srcIn)),
        SizedBox(width: 8.w),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Recent Reviews & Highest Rated
                ...['Recent Reviews', 'Highest Rated'].map((o) {
                  final selected = _selectedSort == o;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedSort = o),
                    child: Container(
                      margin: EdgeInsets.only(right: 8.w),
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: selected ? AppColors.primary : const Color(0xFFD1D5DC))),
                      child: Text(o,
                          style: AppTextStyles.mark.copyWith(
                              color: selected ? Colors.white :const Color(0xFF364153))),
                    ),
                  );
                }),

                // Positive Only
                GestureDetector(
                  onTap: () => setState(() => _positiveOnly = !_positiveOnly),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: _positiveOnly ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: _positiveOnly ? AppColors.primary : const Color(0xFFD1D5DC))),
                    child: Text('Positive Only',
                        style: AppTextStyles.mark.copyWith(
                            color: _positiveOnly ? Colors.white :const Color(0xFF364153))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _reviewCard(Map<String, dynamic> r) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE5E7EB),width: 1.24),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //  Avatar — network image অথবা default SVG
              CircleAvatar(
                radius: 24.r,
                backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                //যদি Network ইমেজ থাকে তবে সেটিই দেখাবে
                backgroundImage: r['avatarUrl'] != null
                    ? NetworkImage(r['avatarUrl']) as ImageProvider
                    : null,
                // Network ইমেজ না থাকলে লোকাল Image দেখাবে
                child: r['avatarUrl'] == null
                    ? ClipOval(
                  child: Image.asset('assets/images/avatar.jpg', width: 48.r, height: 48.r,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      //  যদি লোকাল ইমেজও না পায়, তবে SVG দেখাবে
                      return SvgPicture.asset(
                        'assets/icons/person_outline.svg', width: 24.w, height: 24.w,
                        colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                      );
                    },
                  ),
                )
                    : null,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${r['reviewer']} rated ${r['reviewed']}',
                      style: AppTextStyles.action.copyWith(color:const Color(0xFF101828))),
                    Text( r['date'],
                      style: AppTextStyles.time.copyWith(color: const Color(0xFF4A5565))),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          _starRow(r['rating'].toDouble(), color:const Color(0xFFFFB900), size: 20.sp),

          SizedBox(height: 12.h),

          Text(
            '"${r['comment']}"',
            style: AppTextStyles.school.copyWith(height: 1.62),
          ),
        ],
      ),
    );
  }



  Widget _starRow(double rating, {required Color color, required double size}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        String iconPath;
        if (i < rating.floor()) {
          iconPath = 'assets/icons/star_filled.svg';      // পূর্ণ star
        } else if (i < rating && rating - i >= 0.5) {
          iconPath = 'assets/icons/star_half.svg';        // অর্ধেক star
        } else {
          iconPath = 'assets/icons/star_border.svg';      // খালি star
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: SvgPicture.asset(
            iconPath,
            width: size.sp,
            height: size.sp,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
        );
      }),
    );
  }
}