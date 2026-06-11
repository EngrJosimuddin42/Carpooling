import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_buttons.dart';
import '../inbox/chat_detail_screen.dart';

class CarpoolProfileScreen extends StatefulWidget {
  final Map<String, dynamic> familyData;
  const CarpoolProfileScreen({super.key, required this.familyData});



  @override
  State<CarpoolProfileScreen> createState() => _CarpoolProfileScreenState();
}

class _CarpoolProfileScreenState extends State<CarpoolProfileScreen> {
  bool _isInvited = false;

  @override
  void initState() {
    super.initState();
    _isInvited = widget.familyData['sentRequest'] ?? false;
  }

  final List<Map<String, dynamic>> _children = const [
    {'name': 'Ayesha Ahmed', 'age': 'Grade 3'},
    {'name': 'Fahim Ahmed', 'age': 'Grade 1'},
  ];

  final List<Map<String, dynamic>> _reviews = const [
    {
      'name': 'Rahman Khan',
      'rating': 5.0,
      'time': '2 weeks ago',
      'comment': 'Very reliable and punctual. Kids love riding with Sarah!'
    },
    {
      'name': 'Nadia Hossain',
      'rating': 4.5,
      'time': '1 month ago',
      'comment': 'Great communication, always on time.'
    },
    {
      'name': 'Karim Ali',
      'rating': 5.0,
      'time': '2 months ago',
      'comment': 'Trustworthy parent. Highly recommend!'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Header + Card 1 overlap ──
            Stack(
              clipBehavior: Clip.none,
              children: [
                // teal background
                Container(
                  height: 243.h,
                  color: AppColors.primary,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(top: 48.h, left: 24.w),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: const BoxDecoration(
                              color: Color(0x33FFFFFF),
                              shape: BoxShape.circle),
                          child: Icon(Icons.arrow_back, size: 20.sp, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),

                // Card 1
                Positioned(
                  top: 146.27.h,
                  left: 24.37.w,
                  right: 24.37.w,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(24.37.w, 69.89.h, 24.37.w, 25.13.h),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                        boxShadow: AppColors.shadow),
                    child: Column(
                      children: [
                        Text(widget.familyData['name'],
                            style: AppTextStyles.heading),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                'assets/icons/star_filled.svg', width: 20.sp, height: 20.sp,
                                colorFilter: const ColorFilter.mode(Color(0xFFFE9A00), BlendMode.srcIn)),
                            SizedBox(width: 4.w),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: '${widget.familyData['rating']} ',
                                      style: AppTextStyles.name.copyWith(fontWeight: FontWeight.w600)),
                                  TextSpan(
                                      text: '(${widget.familyData['reviews']} reviews)',
                                      style: AppTextStyles.medium.copyWith(color: const Color(0xFF4A5565))),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                'assets/icons/location.svg', width: 16.sp, height: 16.sp,
                                colorFilter: const ColorFilter.mode(Color(0xFF4A5565), BlendMode.srcIn)),
                            SizedBox(width: 8.w),
                            Text('${widget.familyData['distance']}',
                                style: AppTextStyles.school.copyWith(color: const Color(0xFF4A5565))),
                          ],
                        ),

                        SizedBox(height: 24.h),
                        Divider(color: Colors.grey.shade300, height: 2, thickness: 1),

                        _buildStats(),
                        SizedBox(height: 16.h),
                        _buildInviteButton(),
                      ],
                    ),
                  ),
                ),

                // Avatar overlap
                Positioned(
                  top: 105.63.h,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3.31),
                              boxShadow: AppColors.shadow,
                            ),
                            child: CircleAvatar(
                                radius: 48.r,
                                backgroundColor: const Color(0x3366B2A3),
                                backgroundImage: AssetImage(widget.familyData['image']))),
                        Positioned(
                          bottom: -8,
                          right: -8,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3.31),
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/privacy.svg',
                              width: 20.sp,
                              height: 20.sp,
                              colorFilter: const ColorFilter.mode(
                                  Color(0xFFFFFFFF), BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Card 1 এর height অনুযায়ী space
            SizedBox(height: 330.h),

            // ── Card 2, 3, 4 ──
            Padding(
              padding: EdgeInsets.fromLTRB(24.37.w, 0, 24.37.w, 24.37.h),
              child: Column(
                children: [
                  // Card 2: About + Info
                  _sectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        _buildAbout(),

                        SizedBox(height: 24.37.h),

                        _buildInfo(),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Card 3: Children
                  _sectionCard(child: _buildChildren()),
                  SizedBox(height: 12.h),

                  // Card 4: Reviews
                  _sectionCard(child: _buildReviews()),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
    );
  }

  Widget _sectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.37.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.26.r),
          boxShadow: AppColors.cardShadow),
      child: child,
    );
  }

  Widget _buildStats() {
    return Row(
      children: [
        Expanded(
            child: _statCard('assets/icons/carpool_outlined.svg', '48', 'Total Carpools',const Color(0xFF66B2A3))),
        SizedBox(width: 12.w),
        Expanded(
            child: _statCard('assets/icons/check.svg','${widget.familyData['childrenCount']}', 'Children',const Color(0xFF00A63E))),
      ],
    );
  }

  Widget _statCard(String assetPath, String value, String label, Color iconColor) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
      child: Column(
        children: [
          SvgPicture.asset(
              assetPath, width: 20.sp, height: 20.sp,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn)),
          SizedBox(height: 2.h),
          Text(value,
              style: AppTextStyles.heading),
          SizedBox(height: 2.h),
          Text(label,
              style: AppTextStyles.school.copyWith(color: const Color(0xFF4A5565))),
        ],
      ),
    );
  }

  Widget _buildInviteButton() {
    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            key: ValueKey(_isInvited),
            text: _isInvited ? 'Already Invited' : 'Invite to Carpool',
            height: 48.h,
            backgroundColor: _isInvited ? const Color(0xFFE5E7EB) : AppColors.primary,
            textColor: _isInvited ? const Color(0xFF6A7282) : Colors.white,
            fontWeight: FontWeight.w600,
            onPressed: () {
              setState(() {
                _isInvited = !_isInvited;
                widget.familyData['sentRequest'] = _isInvited;
              });
            },
          ),
        ),
        SizedBox(width: 17.w),
        Container(
          height: 48.h, width: 48.h,
          decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(14.r)),
          child: IconButton(
            icon: SvgPicture.asset(
                'assets/icons/chat.svg', width: 20.sp, height: 20.sp,
                colorFilter: const ColorFilter.mode(Color(0xFF364153), BlendMode.srcIn)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(
                    chatName: widget.familyData['name'],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAbout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About',
            style: AppTextStyles.name),
        SizedBox(height: 16.25.h),
        Text('Mother of two wonderful kids. I\'ve been carpooling for over a year and love the community we\'ve built. Safety is my top priority!',
          style: AppTextStyles.label.copyWith(color: const Color(0xFF364153)),
        ),
      ],
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoRow('assets/icons/school_outlined.svg', widget.familyData['info']),
        SizedBox(height: 14.h),
        _infoRow('assets/icons/calender.svg', 'Joined January 2024'),
        SizedBox(height: 14.h),
        _infoRow('assets/icons/phone_outlined.svg', '+880 1712-345678'),
      ],
    ).animate().fadeIn(delay: 300.ms);
  }

  Widget _infoRow(String assetPath, String text) {
    return Row(
      children: [
        SvgPicture.asset(
            assetPath,
            width: 20.sp,
            height: 20.sp,
            colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn)),
        SizedBox(width: 12.w),
        Text(text,
          style: AppTextStyles.medium.copyWith(color: const Color(0xFF364153)),
        ),
      ],
    );
  }

  Widget _buildChildren() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Children',
            style: AppTextStyles.name),
        SizedBox(height: 16.h),
        ..._children.map((child) => Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding:
          EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(14.22.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(child['name'],
                      style: AppTextStyles.cs.copyWith(color: const Color(0xFF101828))),
                  SizedBox(height: 2.h),
                  Text(child['age'],
                      style: AppTextStyles.school.copyWith(color: const Color(0xFF4A5565))),
                ],
              ),
              SvgPicture.asset(
                  'assets/icons/carpool_outlined.svg', width: 20.sp, height: 20.sp,
                  colorFilter: const ColorFilter.mode(Color(0xFF99A1AF), BlendMode.srcIn))
            ],
          ),
        )),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reviews (${_reviews.length})',
            style: AppTextStyles.name),
        SizedBox(height: 16.25.h),
        ..._reviews.asMap().entries.map((entry) {
          final r = entry.value;
          final isLast = entry.key == _reviews.length - 1;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(r['name'],
                      style: AppTextStyles.cs.copyWith(color: const Color(0xFF101828))),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                    decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(10.16.r)),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/star_filled.svg',
                            width: 14.sp, height: 14.sp,
                            colorFilter: const ColorFilter.mode(Color(0xFFFE9A00), BlendMode.srcIn)),
                        SizedBox(width: 4.w),
                        Text('${r['rating']}',
                            style: AppTextStyles.action.copyWith(
                              color: const Color(0xFFBB4D00),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Text(r['time'],
                  style: AppTextStyles.school.copyWith(color: const Color(0xFF6A7282))),
              SizedBox(height: 8.h),
              Text(r['comment'],
                  style: AppTextStyles.school.copyWith(color: const Color(0xFF364153))),
              if (!isLast) ...[
                SizedBox(height: 16.h),
                Divider(color: Colors.grey.shade300, height: 2, thickness: 1),
                SizedBox(height: 16.h),
              ],
            ],
          );
        }),
      ],
    ).animate().fadeIn(delay: 500.ms);
  }
}