import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import '../../data/app_data.dart';
import '../../widgets/app_bottom_nav.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _showUnread = false;

  List<Map<String, dynamic>> get _notifications => AppData().notifications.value;

  List<Map<String, dynamic>> get _filtered => _showUnread
      ? _notifications.where((n) => !n['read']).toList()
      : _notifications;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppData().notifications,
      builder: (context, _, __) {
        return Scaffold(
          backgroundColor:const Color(0xFFF9FAFB),
          appBar: AppBar(
            backgroundColor:const Color(0xFFF9FAFB),
            elevation: 0,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: false,
            title: Text('Notifications', style: AppTextStyles.heading),
            actions: [
              TextButton(
                onPressed: () => AppData().markAllRead(),
                child: Text('Mark all read',
                    style: AppTextStyles.mark),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  child: _buildToggle()),

                SizedBox(height: 4.h),
                Divider( color: Colors.grey.shade300, height: 2, thickness: 2),
                SizedBox(height: 12.h),

                Expanded(
                  child: _filtered.isEmpty
                      ? Center(
                    child: Text('No notifications',
                        style: AppTextStyles.medium
                            .copyWith(color: Colors.grey)))
                      : ListView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: 24.w, vertical: 4.h),
                    itemCount: _filtered.length,
                    itemBuilder: (_, i) {
                      final n = _filtered[i];
                      final globalIndex =
                      AppData().notifications.value.indexOf(n);
                      return _notificationCard(n, i, globalIndex);
                    },
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const AppBottomNav(currentIndex: 3),
        );
      },
    );
  }

  Widget _buildToggle() {
    return Row(
      children: [
        _toggleBtn('All', !_showUnread,
                () => setState(() => _showUnread = false)),
        SizedBox(width: 8.w),
        _toggleBtn('Unread', _showUnread,
                () => setState(() => _showUnread = true)),
      ],
    );
  }

  Widget _toggleBtn(String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF155DFC) :const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(10.16.r)),
        child: Text( label,
          style: AppTextStyles.mark.copyWith(
            color: active ? Colors.white :const Color(0xFF4A5565),
          ),
        ),
      ),
    );
  }

  Widget _notificationCard(Map<String, dynamic> n, int i, int globalIndex) {
    final isUnread = !n['read'] as bool;

    final style = AppData.getNotificationStyle(n['type'] as String);

    return GestureDetector(
      onTap: () => AppData().markRead(globalIndex),
      child: Container(
        margin: EdgeInsets.only(bottom: 13.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border(
            left: BorderSide(
              color: isUnread ? const Color(0xFF155DFC) : Colors.transparent,
              width: 3.73,
            ),
          ),
        boxShadow:const [
            // First Shadow
            BoxShadow(
              color: Color(0x1A000000),
              offset: Offset(0, 1.02),
              blurRadius: 2.03,
              spreadRadius: -1.02),
            // Second Shadow
            BoxShadow(
              color: Color(0x1A000000),
              offset: Offset(0, 1.02),
              blurRadius: 3.05,
              spreadRadius: 0),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48.77.w,
              height: 48.77.w,
              padding: EdgeInsets.only(left: 12.19.w, right: 12.21.w),
              decoration: BoxDecoration(
                color: style['bgColor'] as Color,
                shape: BoxShape.circle),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                style['icon'] as String,
                width: 24.sp,
                height: 24.sp,
                colorFilter: ColorFilter.mode(
                  style['color'] as Color,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          n['title'],
                          style: AppTextStyles.head.copyWith(
                            color: isUnread
                                ? const Color(0xFF101828)
                                : const Color(0xFF364153)))),
                      Text(
                        n['time'],
                        style: AppTextStyles.time),
                    ]
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    n['msg'],
                      style: AppTextStyles.school.copyWith(
                          color: isUnread
                              ? const Color(0xFF364153)
                              : const Color(0xFF4A5565))
                  ),
                ],
              ),
            ),
          ],
        ),
      )
          .animate()
          .fadeIn(delay: (i * 80).ms, duration: 300.ms)
          .slideY(begin: 0.1),
    );
  }
}