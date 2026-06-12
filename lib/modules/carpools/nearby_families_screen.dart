import 'package:carpooling/modules/carpools/carpool_profile_screen.dart';
import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_text_field.dart';


class NearbyFamiliesScreen extends StatefulWidget {
  const NearbyFamiliesScreen({super.key});

  @override
  State<NearbyFamiliesScreen> createState() => _NearbyFamiliesScreenState();
}

class _NearbyFamiliesScreenState extends State<NearbyFamiliesScreen> {
  final _searchCtrl = TextEditingController();

  String _searchQuery = '';
  bool _isVerifiedFilterActive = false;
  List<Map<String, dynamic>> _filteredFamilies = [];


  final List<Map<String, dynamic>> _families = [
    {'image': 'assets/images/avatar.jpg','name': 'Sarah Ahmed', 'info': 'Greenfield School', 'distance': '0.3 km away', 'childrenCount': 2,'rating': 4.8, 'reviews': 3, 'status': 'Invite', 'verified': true,'sentRequest': false},
    {'image': 'assets/images/avatar1.jpg','name': 'Rahman Khan', 'info': 'Greenfield School', 'distance': '1.2 km away', 'childrenCount': 1,'rating': 4.9, 'reviews': 1, 'status': 'Invite', 'verified': true,'sentRequest': false},
    {'image': 'assets/images/avatar2.jpg','name': 'Nadia Hossain', 'info': 'Sunshine Academy', 'distance': '1.5 km away','childrenCount': 3, 'rating': 4.7, 'reviews': 1, 'status': 'Invite', 'verified': false,'sentRequest': false},
    {'image': 'assets/images/avatar3.jpg','name': 'Karim Ali', 'info': 'Downtown School', 'distance': '2.1 km away','childrenCount': 2, 'rating': 5, 'reviews': 0, 'status': 'Invite', 'verified': false,'sentRequest': false},
  ];


  void _onInviteTap(Map<String, dynamic> f) {
    setState(() {
      f['sentRequest'] = true;
      _applyFilters();
    });
  }


  @override
  void initState() {
    super.initState();
    _applyFilters();
  }

  void _applyFilters() {
    setState(() {
      _filteredFamilies = _families.where((user) {
        final matchesSearch = user['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user['info'].toLowerCase().contains(_searchQuery.toLowerCase());
        final matchesFilter = !_isVerifiedFilterActive || (user['verified'] == true);
        final notRequested = user['sentRequest'] == false;

        return matchesSearch && matchesFilter && notRequested;
      }).toList();
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
          title: Text('Nearby Families', style: AppTextStyles.heading)),

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.37.w, vertical: 16.25.h),
              child: Column(
                children: [
                  _buildSearchBar(),
                  SizedBox(height: 16.25.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildFilterButton(),
                    ],
                  )
                ],
              ),
            ),

            Divider(color: Colors.grey.shade300, height: 2, thickness: 2),

            _buildNoticeBanner(),

            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24.37.w),
                itemCount: _filteredFamilies.length,
                itemBuilder: (_, i) => _familyCard(_filteredFamilies[i], i)
                    .animate()
                    .fadeIn(delay: (i * 100).ms, duration: 400.ms)
                    .slideY(begin: 0.2),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
    );
  }

  Widget _buildSearchBar() {
    return AppTextField(
      controller: _searchCtrl,
      hintText: 'Search by name, school or phone...',
      fillColor: Colors.white,
      borderColor: const Color(0xFFD1D5DC),
      borderRadius: 14.22.r,
      prefixIcon: SvgPicture.asset(
          'assets/icons/search_outlined.svg', width: 20.sp, height: 20.sp,
          colorFilter: const ColorFilter.mode(Color(0xFF99A1AF), BlendMode.srcIn)),
      onChanged: (value) {
        _searchQuery = value;
        _applyFilters();
      },
    );
  }

  Widget _buildFilterButton() {
    return InkWell(
      onTap: () {
        setState(() => _isVerifiedFilterActive = !_isVerifiedFilterActive);
        _applyFilters();
      },
      borderRadius: BorderRadius.circular(10.16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.25.w, vertical: 10.h),
        decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(10.16.r)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
                'assets/icons/filter_alt_outlined.svg', width: 16.sp, height: 16.sp,
                colorFilter: const ColorFilter.mode(Color(0xFF364153), BlendMode.srcIn)),
            SizedBox(width: 7.w),
            Text('Filter',
                style: AppTextStyles.mark.copyWith(color: const Color(0xFF364153))),
          ],
        ),
      ),
    );
  }

  Widget _buildNoticeBanner() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.37.w, vertical: 16.25.h),
      padding: EdgeInsets.fromLTRB(28.18.w, 15.24.h, 23.92.w, 16.91.h),
      decoration: BoxDecoration(
          color: const Color(0x3366B2A3),
          borderRadius: BorderRadius.circular(10.16.r),
          border: const Border(
              left: BorderSide(color: Color(0xFF66B2A3), width: 3.81))),
      child: Text(
          'You can only invite parents who already added children to their profile.',
          style: AppTextStyles.school.copyWith(color: const Color(0xFF66B2A3))),
    );
  }

  Widget _familyCard(Map<String, dynamic> f,int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.25.h),
      padding: EdgeInsets.all(17.52.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: AppColors.cardShadow),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 32.r,
                backgroundImage: AssetImage(
                    f['image'] != null && f['image'].isNotEmpty
                        ? f['image']
                        : 'assets/images/avatar.jpg'
                ),
              ),
              SizedBox(width: 16.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(f['name'], style: AppTextStyles.head.copyWith(height: 1.5)),
                        if (f['verified']) ...[
                          SizedBox(width: 9.w),
                          SvgPicture.asset(
                              'assets/icons/privacy.svg', width: 20.sp, height: 20.sp,
                              colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn))
                        ],
                      ],
                    ),
                    SizedBox(height: 4.h),
                    _iconTextRow('assets/icons/location.svg', f['distance']),
                    _iconTextRow(null, f['info']),
                    _iconTextRow('assets/icons/carpool_outlined.svg', "${f['childrenCount']} children"),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEB),
                    borderRadius: BorderRadius.circular(10.16.r)),
                child: Row(
                  children: [
                    SvgPicture.asset(
                        'assets/icons/star_filled.svg', width: 16.sp, height: 16.sp,
                        colorFilter: const ColorFilter.mode(Color(0xFFFE9A00), BlendMode.srcIn)),
                    SizedBox(width: 4.w),
                    Text(f['rating'].toString(), style: AppTextStyles.action.copyWith(color:const Color(0xFFBB4D00))),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          //button
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  text: f['status'],
                  height: 39.h,
                  fontWeight: FontWeight.w600,
                  onPressed: () => _onInviteTap(f),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: OutlineButton2(
                  text: 'View Profile',
                  height: 39.h,
                  borderColor: const Color(0xFFD1D5DC),
                  textColor: const Color(0xFF364153),
                  fontWeight: FontWeight.w600,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CarpoolProfileScreen(familyData: f)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

// হেল্পার উইজেট
  Widget _iconTextRow(String? assetPath, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        children: [
          if (assetPath != null && assetPath.isNotEmpty) ...[
            SvgPicture.asset(
                assetPath, width: 16.sp, height: 16.sp,
                colorFilter: const ColorFilter.mode(Color(0xFF4A5565), BlendMode.srcIn)),
            SizedBox(width: 6.w),
          ],
          Text(text, style: AppTextStyles.school),
        ],
      ),
    );
  }
}