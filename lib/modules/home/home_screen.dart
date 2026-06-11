import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import '../../data/app_data.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/carpool_card.dart';
import '../carpools/create_carpool_screen.dart';
import '../carpools/my_carpools_screen.dart';
import '../carpools/nearby_families_screen.dart';
import '../inbox/messages_screen.dart';
import '../profile/manage_children/manage_children_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final String _userName = 'John';

  // ── Nearby parents list with sentRequest state ──
  final List<Map<String, dynamic>> _parents = [
    {'name': 'Sarah J.', 'info': '0.3 mi away • 2 children', 'isVerified': true,  'sentRequest': false},
    {'name': 'Mike T.',  'info': '0.5 mi away • 1 child',    'isVerified': true,  'sentRequest': false},
    {'name': 'Lisa M.',  'info': '0.8 mi away • 3 children', 'isVerified': false, 'sentRequest': false},
  ];

  void _onInviteTap(int index) {
    setState(() {
      _parents[index]['sentRequest'] = true;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFFF9FAFB),
      body: Column(
        children: [
          _buildHeaderWithStats(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.37.w, vertical: 24.38.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildQuickActions(context),
                  SizedBox(height: 24.37.h),
                  _buildUpcomingCarpools(context),
                  SizedBox(height: 24.37.h),
                  _buildNearbyParents(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: Container(
          width: 56.w, height: 56.w,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            border: Border.all(
                color: Colors.white,
                width: 2.0),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x1A000000),
                  offset: Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: -4),
              BoxShadow(
                  color: Color(0x1A000000),
                  offset: Offset(0, 10),
                  blurRadius: 15,
                  spreadRadius: -3),
            ],
          ),
          child: Material(
              color: Colors.transparent,
              child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CreateCarpoolScreen()),
                    );
                  },
                  child: Center(
                      child: Icon(Icons.add, color: Colors.white, size: 28.sp))))),

      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }

  // ─── HEADER + STATS (gradient background) ───────────────────────────────────

  Widget _buildHeaderWithStats() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF66B2A3),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24.38.r),
            bottomRight: Radius.circular(24.38.r)),
        boxShadow: const [
          BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 6.1,
              spreadRadius: -4.06,
              offset: Offset(0, 4.06)),
          BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 15.24,
              spreadRadius: -3.05,
              offset: Offset(0, 10.16)),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 24.37.h),
              _buildStats(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( 'Welcome back, $_userName!',
                  style: AppTextStyles.heading.copyWith(color: Colors.white)
              ).animate().fadeIn(duration: 400.ms),
              SizedBox(height: 3.h),
              Text("Let's make today's rides safe",
                style: AppTextStyles.emptyText.copyWith(
                    color: const Color(0xFFDBEAFE)),
              ).animate().fadeIn(delay: 100.ms),
            ],
          ),
          CircleAvatar(
            radius: 24.r,
            backgroundColor: Colors.white,
            child: SvgPicture.asset(
                'assets/icons/car.svg', width: 24.sp, height: 24.sp,
                colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn)),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Row(
      children: [
        Expanded(child: _statBox('5', 'This Week')),
        SizedBox(width: 12.w),
        Expanded(child: _statBox('12', 'Total Rides')),
        SizedBox(width: 12.w),
        Expanded(child: _statBox('8', 'Parents')),
      ],
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.15);
  }

  Widget _statBox(String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.18.h),
      decoration: BoxDecoration(
          color:const Color(0x33FFFFFF),
          borderRadius: BorderRadius.circular(14.r)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text( value,
              style: AppTextStyles.heading.copyWith(
                  color: Colors.white)),
          SizedBox(height: 3.h),
          Text(label,
              style: AppTextStyles.time.copyWith( color:const Color(0xFFDBEAFE))),
        ],
      ),
    );
  }

  // ─── QUICK ACTIONS ───────────────────────────────────────────────────────────

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: AppTextStyles.name),
        SizedBox(height: 4.h),
        Text('Please add your child first before creating a carpool.',
            style: AppTextStyles.school.copyWith(color: const Color(0xFF707070),height: 2)),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _actionButton(
                svgIconPath: 'assets/icons/add_icon.svg',
                label: 'Create Carpool',
                gradient: AppColors.primaryGradient,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreateCarpoolScreen(),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _actionButton(
                svgIconPath: 'assets/icons/double_chat.svg',
                label: 'Carpool Invitations',
                gradient: AppColors.successGradient,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MessagesScreen(initialTab: 2),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _actionButton(
                svgIconPath: 'assets/icons/search_outlined.svg',
                label: 'Find Families',
                gradient: AppColors.purpleGradient,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NearbyFamiliesScreen(),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _actionButton(
                svgIconPath: 'assets/icons/carpool_outlined.svg',
                label: 'Manage children',
                gradient: AppColors.orangeGradient,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ManageChildrenScreen(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 300.ms);
  }

  Widget _actionButton({
    required String svgIconPath,
    required String label,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 31.h, horizontal: 13.w),
        decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: AppColors.commonBoxShadow),
        child: Row(
          children: [
            SvgPicture.asset(svgIconPath, width: 24.sp, height: 24.sp,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
            SizedBox(width: 4.w),
            Expanded(
                child: Text( label,
                    style: AppTextStyles.action.copyWith(color: Colors.white))),
          ],
        ),
      ),
    );
  }

  // ─── UPCOMING CARPOOLS ───────────────────────────────────────────────────────
  Widget _buildUpcomingCarpools(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppData().carpools,
      builder: (context, carpools, _) {
        final preview = carpools.length > 2
            ? carpools.sublist(carpools.length - 2)
            : carpools.toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Upcoming Carpools', style: AppTextStyles.name),
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const MyCarpoolsScreen())),
                  child: Text('View All',
                      style: AppTextStyles.mark.copyWith(color: AppColors.primary)),
                ),
              ],
            ),
            SizedBox(height: 12.18.h),
            if (preview.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Center(
                  child: Text('No upcoming carpools',
                      style: AppTextStyles.medium.copyWith(color: Colors.grey)),
                ),
              )
            else
              ...preview.map((c) => CarpoolCard(carpool: c)),
          ],
        ).animate().fadeIn(delay: 400.ms);
      },
    );
  }

  // ─── NEARBY PARENTS ──────────────────────────────────────────────────────────

  Widget _buildNearbyParents() {
    final visibleParents = _parents
        .asMap()
        .entries
        .where((e) => e.value['sentRequest'] == false)
        .toList();

    if (visibleParents.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nearby Parents', style: AppTextStyles.name),
        SizedBox(height: 12.h),
        ...visibleParents.map((e) => _parentTile(e.key, e.value)),
      ],
    ).animate().fadeIn(delay: 500.ms);
  }

  Widget _parentTile(int index, Map<String, dynamic> p) {
    final bool isVerified = p['isVerified'] ?? false;
    final String name = p['name'] ?? 'Unknown';
    final String info = p['info'] ?? '';
    final String status = p['status'] ?? 'Invite';

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.25.w, vertical: 16.75.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: AppColors.softCardShadow),
      child: Row(
        children: [

          // Avatar
          Container(
              width: 48.r,
              height: 48.r,
              decoration:const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.bluePurpleGradient),
              alignment: Alignment.center,
              child: Text( name.isNotEmpty ? name[0] : '?',
                  style: AppTextStyles.cs)),
          SizedBox(width: 16.25.w),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: AppTextStyles.head.copyWith(height: 1.5)),
                    SizedBox(width: 2.w),
                    if (isVerified)
                      SvgPicture.asset(
                          'assets/icons/shield_outlined.svg', width: 16.sp, height: 16.sp,
                          colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn))
                  ],
                ),
                SizedBox(height: 2.h),
                Text(info,
                    style: AppTextStyles.school.copyWith(
                        color: const Color(0xFF4A5565))),
              ],
            ),
          ),
          // Invite
          GestureDetector(
              onTap: () => _onInviteTap(index),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                  decoration: BoxDecoration(
                      color:  AppColors.primary,
                      borderRadius: BorderRadius.circular(10.16.r)),
                  child: Text(status,
                      style: AppTextStyles.mark.copyWith(
                          color: Colors.white)))),
        ],
      ),
    );
  }
}