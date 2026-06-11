import 'package:carpooling/routes/app_routes.dart';
import 'package:carpooling/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../data/app_data.dart';
import '../theme/app_text_styles.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
  });

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0: context.replace(AppRoutes.home); break;
      case 1: context.replace(AppRoutes.carpools); break;
      case 2: context.replace(AppRoutes.messages); break;
      case 3: context.replace(AppRoutes.notifications); break;
      case 4: context.replace(AppRoutes.profile); break;
    }
  }

  Widget _svgIcon(String path, bool isActive) {
    return SvgPicture.asset(
      path,
      width: 26.w,
      height: 26.w,
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(
        isActive ? AppColors.primary : const Color(0xFFFCFCFC),
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0C0C0C),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        child: ValueListenableBuilder(
          valueListenable: AppData().notifications,
          builder: (context, _, __) {
            final badgeCount = AppData().unreadCount;

            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: const Color(0xFFFCFCFC),
              currentIndex: currentIndex,
              backgroundColor: const Color(0xFF0C0C0C),
              elevation: 0,
              onTap: (index) => _onTap(context, index),
              selectedLabelStyle: AppTextStyles.navText,
              unselectedLabelStyle: AppTextStyles.navText,
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
                    child: _svgIcon('assets/icons/home_outlined.svg', currentIndex == 0),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
                    child: _svgIcon('assets/icons/carpool_outlined.svg', currentIndex == 1),
                  ),
                  label: 'Carpools',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
                    child: _svgIcon('assets/icons/inbox_outlined.svg', currentIndex == 2),
                  ),
                  label: 'Inbox',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
                    child: Badge(
                      backgroundColor: Colors.red,
                      label: Text(
                        '$badgeCount',
                        style: TextStyle(fontSize: 9.sp, color: Colors.white),
                      ),
                      isLabelVisible: badgeCount > 0,
                      child: _svgIcon('assets/icons/notification_outlined.svg', currentIndex == 3),
                    ),
                  ),
                  label: 'Notifications',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
                    child: _svgIcon('assets/icons/profile_outlined.svg', currentIndex == 4),
                  ),
                  label: 'Profile',
                ),
              ],
            ),
            );
          },
        ),
      ),
    );
  }
}