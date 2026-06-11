import 'package:carpooling/modules/carpools/select_driver_screen.dart';
import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarpoolDetailScreen extends StatelessWidget {
  final Map<String, dynamic> carpool;
  const CarpoolDetailScreen({super.key, required this.carpool});

  final List<Map<String, dynamic>> _members = const [
    {
      'name': 'You',
      'children': ['Emma, 8 years', 'Liam, 6 years'],
      'isDriver': false,
    },
    {
      'name': 'Sarah Johnson',
      'children': ['Olivia, 7 years'],
      'isDriver': false,
    },
    {
      'name': 'Mike Thompson',
      'children': ['Noah, 9 years', 'Sophia, 7 years'],
      'isDriver': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final hasDriver = carpool['driver'] != 'No Driver';

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20.sp, color: const Color(0xFF0C0C0C)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_outlined, size: 20.sp, color: const Color(0xFF0C0C0C)),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, size: 20.sp, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(hasDriver),
            SizedBox(height: 16.h),
            if (!hasDriver) _buildNoDriverAlert(context),
            SizedBox(height: 16.h),
            _buildRoute(),
            SizedBox(height: 16.h),
            _buildMapButton(),
            SizedBox(height: 20.h),
            _buildMembers(),
            SizedBox(height: 20.h),
            _buildNotes(),
            SizedBox(height: 20.h),
            _buildActionButtons(context),
            SizedBox(height: 16.h),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader(bool hasDriver) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(carpool['title'], style: AppTextStyles.large),
            SizedBox(width: 10.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text('Upcoming',
                  style: AppTextStyles.medium.copyWith(color: AppColors.primary)),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            Icon(Icons.calendar_today, size: 14.sp, color: Colors.grey),
            SizedBox(width: 4.w),
            Text('May 14, 2026 • 7:30 AM - 8:00 AM',
                style: AppTextStyles.medium.copyWith(color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  Widget _buildNoDriverAlert(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.red.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber, color: Colors.red, size: 18.sp),
              SizedBox(width: 6.w),
              Text('No Driver Assigned',
                  style: AppTextStyles.title.copyWith(color: Colors.red)),
            ],
          ),
          SizedBox(height: 6.h),
          Text('This carpool needs a driver. Select a member to be the driver.',
              style: AppTextStyles.medium.copyWith(color: Colors.red)),
          SizedBox(height: 10.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SelectDriverScreen(carpool: carpool)),
            ),
            child: Text('Become a Driver',
                style: AppTextStyles.medium.copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildRoute() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Route', style: AppTextStyles.title),
        SizedBox(height: 12.h),
        _routeItem(Icons.circle, AppColors.primary, 'Pickup', '123 Main Street, Cityville'),
        Container(
          margin: EdgeInsets.only(left: 11.w),
          width: 2,
          height: 20.h,
          color: Colors.grey.withOpacity(0.3),
        ),
        _routeItem(Icons.location_on, Colors.red, 'Destination',
            'Lincoln Elementary School, 456 Oak Avenue'),
      ],
    );
  }

  Widget _routeItem(IconData icon, Color color, String label, String address) {
    return Row(
      children: [
        Icon(icon, color: color, size: 14.sp),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTextStyles.medium.copyWith(color: Colors.grey)),
            Text(address, style: AppTextStyles.title),
          ],
        ),
      ],
    );
  }

  Widget _buildMapButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          padding: EdgeInsets.symmetric(vertical: 14.h),
        ),
        icon: Icon(Icons.map_outlined, color: Colors.white, size: 18.sp),
        label: Text('View on Map',
            style: AppTextStyles.medium.copyWith(color: Colors.white)),
        onPressed: () {},
      ),
    );
  }

  Widget _buildMembers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Members (${_members.length})', style: AppTextStyles.title),
        SizedBox(height: 12.h),
        ..._members.map((m) => Container(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16.r,
                    backgroundColor: AppColors.primary.withOpacity(0.15),
                    child: Text(m['name'][0],
                        style: AppTextStyles.medium
                            .copyWith(color: AppColors.primary)),
                  ),
                  SizedBox(width: 10.w),
                  Text(m['name'], style: AppTextStyles.title),
                  if (m['isDriver']) ...[
                    SizedBox(width: 6.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text('Driver',
                          style: AppTextStyles.medium
                              .copyWith(color: Colors.white, fontSize: 10.sp)),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 6.h),
              ...(m['children'] as List<String>).map((child) => Padding(
                padding: EdgeInsets.only(left: 42.w, bottom: 2.h),
                child: Row(
                  children: [
                    Icon(Icons.child_care,
                        size: 12.sp, color: Colors.grey),
                    SizedBox(width: 4.w),
                    Text(child,
                        style: AppTextStyles.medium
                            .copyWith(color: Colors.grey)),
                  ],
                ),
              )),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildNotes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Notes', style: AppTextStyles.title),
        SizedBox(height: 8.h),
        Text("Please be on time. Kids should bring their lunchboxes.",
            style: AppTextStyles.medium),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
              padding: EdgeInsets.symmetric(vertical: 14.h),
            ),
            icon: Icon(Icons.chat_outlined, color: AppColors.primary, size: 18.sp),
            label: Text('Chat',
                style: AppTextStyles.medium.copyWith(color: AppColors.primary)),
            onPressed: () {},
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
              padding: EdgeInsets.symmetric(vertical: 14.h),
            ),
            icon: Icon(Icons.location_on, color: Colors.white, size: 18.sp),
            label: Text('Track Live',
                style: AppTextStyles.medium.copyWith(color: Colors.white)),
            onPressed: () {},
          ),
        ),
      ],
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