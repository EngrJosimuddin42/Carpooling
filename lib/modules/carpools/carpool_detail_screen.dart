import 'package:carpooling/modules/carpools/live_tracking_screen.dart';
import 'package:carpooling/modules/carpools/ready_to_start_screen.dart';
import 'package:carpooling/modules/carpools/route_map_screen.dart';
import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../data/app_data.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_buttons.dart';
import '../inbox/chat_detail_screen.dart';
import '../../widgets/custom_delete_dialog.dart';
import 'create_carpool_screen.dart';

class CarpoolDetailScreen extends StatefulWidget {
  final Map<String, dynamic> carpool;
  final int carpoolIndex;
  const CarpoolDetailScreen({
    super.key,
    required this.carpool,
    required this.carpoolIndex,
  });

  @override
  State<CarpoolDetailScreen> createState() => _CarpoolDetailScreenState();
}

class _CarpoolDetailScreenState extends State<CarpoolDetailScreen> {
  final List<Map<String, dynamic>> _members = [
    {
      'name': 'You',
      'avatar': 'assets/images/avatar2.jpg',
      'isVerified': true,
      'children': ['Emma', 'Liam'],
    },
    {
      'name': 'Sarah Johnson',
      'avatar': 'assets/images/avatar.jpg',
      'isVerified': true,
      'children': ['Olivia'],
    },
    {
      'name': 'Mike Thompson',
      'avatar': 'assets/images/avatar1.jpg',
      'isVerified': false,
      'children': ['Noah', 'Sophia'],
    },
  ];

  final Set<int> _expandedMembers = {};

  @override
  void initState() {
    super.initState();
    _expandedMembers.addAll(List.generate(_members.length, (i) => i));
  }

  void _deleteCarpool() {
    AppData().carpools.value.removeWhere(
            (item) => item['title'] == widget.carpool['title']);
    AppData().carpools.notifyListeners();
    Navigator.pop(context);
  }

  void _showSelectDriverSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (_) => Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w, height: 4.h,
                decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(10.r)),
              ),
            ),
            SizedBox(height: 16.h),
            Text('Select a Driver', style: AppTextStyles.heading),
            SizedBox(height: 16.h),
            ..._members.map((m) => GestureDetector(
              onTap: () {
                final updated = Map<String, dynamic>.from(
                    AppData().carpools.value[widget.carpoolIndex]);
                updated['driver'] = m['name'];
                updated['driver_avatar'] = m['avatar'];
                AppData().carpools.value[widget.carpoolIndex] = updated;
                AppData().carpools.notifyListeners();
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10.h),
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFE5E7EB))),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage: m['avatar'] != null
                          ? AssetImage(m['avatar']) as ImageProvider
                          : null,
                      backgroundColor: const Color(0x3366B2A3),
                      child: m['avatar'] == null
                          ? SvgPicture.asset(
                          'assets/icons/person_outline.svg',
                          width: 20.sp, height: 20.sp,
                          colorFilter: const ColorFilter.mode(
                              AppColors.primary, BlendMode.srcIn))
                          : null,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                        child: Text(m['name'], style: AppTextStyles.social)),
                    SvgPicture.asset('assets/icons/shield_outlined.svg',
                        width: 16.sp, height: 16.sp,
                        colorFilter: ColorFilter.mode(
                            m['isVerified'] == true
                                ? AppColors.primary
                                : const Color(0xFF99A1AF),
                            BlendMode.srcIn)),
                  ],
                ),
              ),
            )),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppData().carpools,
      builder: (context, carpools, _) {
        final c = widget.carpoolIndex < carpools.length
            ? carpools[widget.carpoolIndex]
            : widget.carpool;
        final hasDriver = c['driver'] != 'No Driver';

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
                        child: Icon(Icons.arrow_back,
                            size: 22.sp, color: const Color(0xFF364153))))),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CreateCarpoolScreen(
                        carpoolToEdit: c,
                        index: widget.carpoolIndex,
                      ),
                    ),
                  ),
                  child: Container(
                    width: 40.w, height: 40.w,
                    decoration: const BoxDecoration(
                        color: Color(0xFFF3F4F6), shape: BoxShape.circle),
                    child: Center(
                      child: SvgPicture.asset(
                          'assets/icons/edit_outlined.svg',
                          width: 20.sp, height: 20.sp,
                          colorFilter: const ColorFilter.mode(
                              Color(0xFF364153), BlendMode.srcIn)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 24.38.w),
                child: GestureDetector(
                  onTap: () => CustomDeleteDialog.show(
                    context: context,
                    title: 'Delete Carpool',
                    message: 'Are you sure you want to delete this carpool?',
                    onConfirm: _deleteCarpool,
                  ),
                  child: Container(
                    width: 40.w, height: 40.w,
                    decoration: const BoxDecoration(
                        color: Color(0xFFFFE2E2), shape: BoxShape.circle),
                    child: Center(
                      child: SvgPicture.asset(
                          'assets/icons/delete_outline.svg',
                          width: 20.sp, height: 20.sp,
                          colorFilter: const ColorFilter.mode(
                              Color(0xFFE7000B), BlendMode.srcIn)),
                    ),
                  ),
                ),
              ),
            ],
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(6.0),
                child: Divider(
                    color: Colors.grey.shade300, height: 2, thickness: 2)),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(c),
                SizedBox(height: 20.32.h),
                if (!hasDriver) _buildNoDriverAlert(context, c),
                if (!hasDriver) SizedBox(height: 20.32.h),
                if (hasDriver) _buildDriverBanner(c),
                if (hasDriver) SizedBox(height: 20.32.h),
                _buildRoute(context, c),
                SizedBox(height: 20.32.h),
                _buildMembers(),
                SizedBox(height: 20.32.h),
                _buildNotes(c),
                SizedBox(height: 20.32.h),
                _buildActionButtons(context, c),
                SizedBox(height: 16.h),
              ],
            ),
          ),
          bottomNavigationBar: const AppBottomNav(currentIndex: 1),
        );
      },
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader(Map<String, dynamic> c) {
    final isActive = c['driver'] != 'No Driver';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
                child: Text(c['title'] ?? '',
                    style: AppTextStyles.heading)),
            SizedBox(width: 10.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFFD0FAE5)
                      : const Color(0xFFFFEDD4),
                  borderRadius: BorderRadius.circular(20.r)),
              child: Text(
                  isActive ? 'Active' : 'Pending',
                  style: AppTextStyles.status.copyWith(
                      color: isActive ? AppColors.primary : const Color(0xFFCA3500),
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            SvgPicture.asset('assets/icons/clock.svg',
                width: 16.sp, height: 16.sp,
                colorFilter: const ColorFilter.mode(
                    Color(0xFF4A5565), BlendMode.srcIn)),
            SizedBox(width: 8.w),
            Text(c['date'] ?? 'No Date',
                style: AppTextStyles.school.copyWith(
                    color: const Color(0xFF4A5565))),
          ],
        ),
      ],
    );
  }

  // ── No Driver Alert ───────────────────────────────────────────────────────

  Widget _buildNoDriverAlert(BuildContext context, Map<String, dynamic> c) {
    return Container(
      padding: EdgeInsets.all(17.5.w),
      decoration: BoxDecoration(
          color: const Color(0xFFFEF2F2),
          borderRadius: BorderRadius.circular(14.23.r),
          border: Border.all(color: const Color(0xFFFFC9C9), width: 1.24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/icons/warning.svg',
                  width: 20.sp, height: 20.sp,
                  colorFilter: const ColorFilter.mode(
                      Color(0xFFE7000B), BlendMode.srcIn)),
              SizedBox(width: 12.w),
              Text('No Driver Assigned',
                  style: AppTextStyles.display.copyWith(
                      color: const Color(0xFF82181A))),
            ],
          ),
          SizedBox(height: 4.h),
          Padding(
              padding: EdgeInsets.only(left: 32.5.w),
              child: Text(
                  'This carpool needs a driver. Select a member to be the driver.',
                  style: AppTextStyles.school.copyWith(
                      color: const Color(0xFFC10007)))),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.only(left: 32.5.w),
            child: SizedBox(
              width: 128.w, height: 35.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE7000B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.16.r)),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.w, vertical: 7.h)),
                onPressed: () => _showSelectDriverSheet(context),
                child: Text('Become a Driver',
                    style: AppTextStyles.mark.copyWith(
                        color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Driver Banner ─────────────────────────────────────────────────────────
  Widget _buildDriverBanner(Map<String, dynamic> c) {
    final driverName = c['driver'] ?? 'Unknown';
    final driverAvatar = c['driver_avatar'] as String?;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.26.r),
              boxShadow: AppColors.cardShadow),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: const Color(0xFFDBEAFE), width: 2)),
                child: CircleAvatar(
                  radius: 29.r,
                  backgroundImage: driverAvatar != null && driverAvatar.isNotEmpty
                      ? AssetImage(driverAvatar) as ImageProvider
                      : null,
                  child: (driverAvatar == null || driverAvatar.isEmpty)
                      ? Text(driverName[0].toUpperCase(),
                      style: AppTextStyles.medium.copyWith(color: AppColors.primary))
                      : null,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c['driver'] ?? '',
                        style: AppTextStyles.social),
                    SizedBox(height: 2.h),
                    Text(c['date'] ?? '',
                        style: AppTextStyles.school.copyWith(
                            color: Colors.grey)),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12.w, vertical: 5.h),
                  decoration: BoxDecoration(
                      color:const Color(0x1A66B2A3),
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Text('Driver',
                      style: AppTextStyles.status.copyWith(
                          color: AppColors.primary))),
            ],
          ),
        ),

        SizedBox(height: 20.h),

        // ── You are the driver banner ──
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(14.23.r),
              border: Border.all(color:const Color(0xFFA4F4CF))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/icons/car.svg', width: 20.sp, height: 20.sp,
                      colorFilter:const ColorFilter.mode( AppColors.primary, BlendMode.srcIn)),
                  SizedBox(width: 12.w),
                  Text('You are the driver',
                      style: AppTextStyles.social.copyWith(color:const Color(0xFF004F3B))),
                ],
              ),
              SizedBox(height: 6.h),
              Padding(
                  padding: EdgeInsets.only(left: 32.5.w),
                  child: Text("You've been assigned as the driver for this carpool.",
                  style: AppTextStyles.school.copyWith( color:const Color(0xFF007A55)))),
              SizedBox(height: 12.h),
                   Padding(
                padding: EdgeInsets.only(left: 32.5.w),
                child: SizedBox(
                     width: 182.w, height: 39.h,
                     child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                           backgroundColor:Colors.white,
                           shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(10.16.r)),
                           elevation: 0,
                           side: BorderSide(
                             color: AppColors.primary,
                             width: 1.24.r),
                           padding: EdgeInsets.symmetric(
                               horizontal: 8.w, vertical: 7.h)),
                       onPressed: () {
                         final updated = Map<String, dynamic>.from(
                             AppData().carpools.value[widget.carpoolIndex]);
                         updated['driver'] = 'No Driver';
                         AppData().carpools.value[widget.carpoolIndex] = updated;
                         AppData().carpools.notifyListeners();
                       },
                       child: Text('Remove Myself as Driver',
                           style: AppTextStyles.medium.copyWith(
                               color: AppColors.primary)),
                     ),
                   ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Route ─────────────────────────────────────────────────────────────────

  Widget _buildRoute(BuildContext context, Map<String, dynamic> c) {
    final pickupAddress = c['from'] ?? 'No pickup address';
    final destinationAddress = c['to'] ?? 'No destination address';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.32.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.23.r),
          boxShadow: AppColors.cardShadow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Route', style: AppTextStyles.message),
          SizedBox(height: 16.h),

          // Pickup
          Row(
            children: [
              Container(
                  width: 33.w, height: 33.w,
                  padding: EdgeInsets.all(8.w),
                  decoration: const BoxDecoration(
                      color: Color(0xFFD0FAE5), shape: BoxShape.circle),
                  child: Center(
                      child: SvgPicture.asset('assets/icons/location.svg',
                          width: 16.sp, height: 16.sp,
                          colorFilter: const ColorFilter.mode(
                              AppColors.primary, BlendMode.srcIn)))),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pickup',
                      style: AppTextStyles.mark.copyWith(
                          color: const Color(0xFF101828))),
                  SizedBox(height: 2.h),
                  Text(pickupAddress,
                      style: AppTextStyles.school.copyWith(
                          color: const Color(0xFF4A5565))),
                ],
              ),
            ],
          ),

          // dotted line
          Padding(
            padding: EdgeInsets.only(left: 17.w, top: 4.h, bottom: 4.h),
            child: Column(
              children: List.generate(10, (i) => Container(
                width: 2, height: 5.h,
                margin: EdgeInsets.only(bottom: 3.h),
                decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(2)),
              )),
            ),
          ),

          // Destination
          Row(
            children: [
              Container(
                  width: 33.w, height: 33.w,
                  padding: EdgeInsets.all(8.w),
                  decoration: const BoxDecoration(
                      color: Color(0xFFFFE2E2), shape: BoxShape.circle),
                  child: Center(
                      child: SvgPicture.asset('assets/icons/location.svg',
                          width: 16.sp, height: 16.sp,
                          colorFilter: const ColorFilter.mode(
                              Color(0xFFE7000B), BlendMode.srcIn)))),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Destination',
                        style: AppTextStyles.mark.copyWith(
                            color: const Color(0xFF101828))),
                    SizedBox(height: 2.h),
                    Text(destinationAddress,
                        style: AppTextStyles.school.copyWith(
                            color: const Color(0xFF4A5565))),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          PrimaryButton(
            text: 'View on Map',
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => RouteMapScreen(carpool: c))),
            icon: SvgPicture.asset('assets/icons/send1.svg',
                width: 20.sp, height: 20.sp,
                colorFilter: const ColorFilter.mode(
                    Colors.white, BlendMode.srcIn)),
          ),
        ],
      ),
    );
  }

  // ── Members ───────────────────────────────────────────────────────────────

  Widget _buildMembers() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.32.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.23.r),
          boxShadow: AppColors.cardShadow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/icons/carpool_outlined.svg',
                  width: 20.sp, height: 20.sp,
                  colorFilter: const ColorFilter.mode(
                      Color(0xFF101828), BlendMode.srcIn)),
              SizedBox(width: 8.w),
              Text('Members (${_members.length})',
                  style: AppTextStyles.message),
            ],
          ),
          SizedBox(height: 16.h),

          ..._members.asMap().entries.map((entry) {
            final i = entry.key;
            final m = entry.value;
            final children = m['children'] as List<String>;
            final isExpanded = _expandedMembers.contains(i);

            return Padding(
              padding: EdgeInsets.only(
                  bottom: i < _members.length - 1 ? 12.h : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      if (isExpanded) {
                        _expandedMembers.remove(i);
                      } else {
                        _expandedMembers.add(i);
                      }
                    }),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22.r,
                          backgroundImage: m['avatar'] != null
                              ? AssetImage(m['avatar']) as ImageProvider
                              : null,
                          backgroundColor: const Color(0x3366B2A3),
                          child: m['avatar'] == null
                              ? SvgPicture.asset(
                              'assets/icons/person_outline.svg',
                              width: 22.sp, height: 22.sp,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.primary, BlendMode.srcIn))
                              : null,
                        ),
                        SizedBox(width: 12.w),
                        Text(m['name'], style: AppTextStyles.social),
                        SizedBox(width: 6.w),
                        SvgPicture.asset('assets/icons/shield_outlined.svg',
                            width: 16.sp, height: 16.sp,
                            colorFilter: ColorFilter.mode(
                                m['isVerified'] == true
                                    ? AppColors.primary
                                    : const Color(0xFF99A1AF),
                                BlendMode.srcIn)),
                      ],
                    ),
                  ),

                  AnimatedCrossFade(
                    firstChild: const SizedBox.shrink(),
                    secondChild: children.isNotEmpty
                        ? Padding(
                      padding: EdgeInsets.only(
                          left: 31.68.w, top: 8.h),
                      child: Column(
                        children: children.map((child) => Padding(
                          padding: EdgeInsets.only(bottom: 4.h),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 1.5, height: 24.w,
                                  margin: EdgeInsets.only(right: 16.w),
                                  color: const Color(0xFFE5E7EB)),
                              Container(
                                  width: 24.w, height: 24.w,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFE5E7EB),
                                      shape: BoxShape.circle),
                                  child: Center(
                                      child: Text(
                                          child[0].toUpperCase(),
                                          style: AppTextStyles.school
                                              .copyWith(
                                              fontSize: 12.sp,
                                              color: const Color(
                                                  0xFF4A5565))))),
                              SizedBox(width: 8.w),
                              Text(child,
                                  style: AppTextStyles.school
                                      .copyWith(
                                      color: const Color(
                                          0xFF364153))),
                            ],
                          ),
                        )).toList(),
                      ),
                    )
                        : const SizedBox.shrink(),
                    crossFadeState: isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 250),
                  ),

                  if (i < _members.length - 1)
                    Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: Divider(
                            color: Colors.grey.shade300,
                            height: 1.24,
                            thickness: 1)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ── Notes ─────────────────────────────────────────────────────────────────

  Widget _buildNotes(Map<String, dynamic> c) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.32.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.23.r),
          boxShadow: AppColors.cardShadow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Notes', style: AppTextStyles.message),
          SizedBox(height: 8.13.h),
          Text(
              c['notes']?.isNotEmpty == true
                  ? c['notes']
                  : 'Please be on time. Kids should bring their backpacks.',
              style: AppTextStyles.school.copyWith(
                  color: const Color(0xFF4A5565))),
        ],
      ),
    );
  }

  // ── Action Buttons ────────────────────────────────────────────────────────

  Widget _buildActionButtons(BuildContext context, Map<String, dynamic> c) {
    final hasDriver = c['driver'] != 'No Driver';
    return Column(
      children: [
        if (hasDriver) ...[
          PrimaryButton(
            text: 'Start Trip',
            height: 52.h,
            icon: SvgPicture.asset('assets/icons/send1.svg',
                width: 20.sp, height: 20.sp,
                colorFilter: const ColorFilter.mode(
                    Colors.white, BlendMode.srcIn)),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ReadyToStartScreen(carpool: c))),
          ),
          SizedBox(height: 12.h),
        ],
        Row(
          children: [
            Expanded(
              child: OutlineButton2(
                text: 'Chat',
                height: 52.h,
                borderColor: AppColors.primary,
                textColor: AppColors.primary,
                icon: SvgPicture.asset('assets/icons/chat.svg',
                    width: 20.sp, height: 20.sp,
                    colorFilter: const ColorFilter.mode(
                        AppColors.primary, BlendMode.srcIn)),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ChatDetailScreen(
                            chatName: c['title'] ?? 'Carpool Chat'))),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: PrimaryButton(
                text: 'Track Live',
                height: 52.h,
                textColor: AppColors.white,
                icon: SvgPicture.asset('assets/icons/send1.svg',
                    width: 20.sp, height: 20.sp,
                    colorFilter: const ColorFilter.mode(
                        AppColors.white, BlendMode.srcIn)),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => LiveTrackingScreen(carpool: c))),
              ),
            ),
          ],
        ),
      ],
    );
  }
}