import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import '../../data/app_data.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/carpool_card.dart';

class MyCarpoolsScreen extends StatefulWidget {
  const MyCarpoolsScreen({super.key});

  @override
  State<MyCarpoolsScreen> createState() => _MyCarpoolsScreenState();
}

class _MyCarpoolsScreenState extends State<MyCarpoolsScreen> {
  final _searchCtrl = TextEditingController();
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Active', 'Pending'];

  String _searchQuery = '';
  String _selectedSort = '';
  String _selectedRole = '';

  List<Map<String, dynamic>> get _filtered {
    final all = AppData().carpools.value;

    // status filter
    var result = _selectedFilter == 'All'
        ? all
        : all.where((c) => c['status'] == _selectedFilter).toList();

    // role filter
    if (_selectedRole.isNotEmpty) {
      result = result.where((c) {
        final driver = (c['driver'] ?? '').toString().toLowerCase();
        if (_selectedRole == 'Driver') return driver == 'you';
        if (_selectedRole == 'Passenger') return driver != 'you' && driver != 'no driver';
        if (_selectedRole == 'Organizer') return driver == 'no driver';
        return true;
      }).toList();
    }

    // sort
    if (_selectedSort == 'A - Z') {
      result.sort((a, b) => (a['title'] ?? '').compareTo(b['title'] ?? ''));
    } else if (_selectedSort == 'Oldest') {
      result = result.reversed.toList();
    }

    // search
    if (_searchQuery.trim().isEmpty) return result;
    final query = _searchQuery.toLowerCase().trim();
    return result.where((c) {
      final title  = (c['title']  ?? '').toString().toLowerCase();
      final from   = (c['from']   ?? '').toString().toLowerCase();
      final to     = (c['to']     ?? '').toString().toLowerCase();
      final driver = (c['driver'] ?? '').toString().toLowerCase();
      return title.contains(query) || from.contains(query) ||
          to.contains(query) || driver.contains(query);
    }).toList();
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
        titleSpacing: 24.w,
        title: Text('My Carpools', style: AppTextStyles.heading),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                children: [
                  _buildSearchBar(),
                  SizedBox(height: 16.h),
                  _buildFilterRow(),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: AppData().carpools,
                builder: (context, _, __) {
                  final list = _filtered;
                  if (list.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/icons/search_outlined.svg',
                              width: 48.sp, height: 48.sp,
                              colorFilter: const ColorFilter.mode(
                                  Color(0xFFD1D5DC), BlendMode.srcIn)),
                          SizedBox(height: 12.h),
                          Text('No carpools found',
                              style: AppTextStyles.medium.copyWith(color: Colors.grey)),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: list.length,
                    itemBuilder: (_, i) => CarpoolCard(carpool: list[i])
                        .animate()
                        .fadeIn(delay: (i * 80).ms, duration: 300.ms)
                        .slideY(begin: 0.1),
                  );
                },
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
      hintText: 'Search carpools...',
      fillColor: Colors.white,
      borderColor: const Color(0xFFD1D5DC),
      borderRadius: 14.r,
      prefixIcon: SvgPicture.asset('assets/icons/search_outlined.svg', width: 20.sp, height: 20.sp,
          colorFilter: const ColorFilter.mode(Color(0xFF99A1AF), BlendMode.srcIn)),
      onChanged: (value) => setState(() => _searchQuery = value),
    );
  }

  Widget _buildFilterRow() {
    return Row(
      children: [
        ..._filters.map((f) => GestureDetector(
          onTap: () => setState(() => _selectedFilter = f),
          child: Container(
            height: 36.h,
            margin: EdgeInsets.only(right: 8.w),
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: _selectedFilter == f
                  ? AppColors.primary
                  : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: _selectedFilter == f
                    ? AppColors.primary
                    : const Color(0xFFF3F4F6),
              ),
            ),
            child: Text(f,
                style: AppTextStyles.mark.copyWith(
                  color: _selectedFilter == f
                      ? Colors.white
                      : const Color(0xFF4A5565),
                )),
          ),
        )),
        GestureDetector(
          onTap: _showFilterSheet,
          child: Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(10.r)),
            child: Center(
              child: SvgPicture.asset('assets/icons/filter_alt_outlined.svg',
                width: 20.sp, height: 20.sp,
                colorFilter: const ColorFilter.mode(
                    Color(0xFF4A5565), BlendMode.srcIn),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showFilterSheet() {
    String tempSort = _selectedSort;
    String tempRole = _selectedRole;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (_) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
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
              Text('Filter Carpools', style: AppTextStyles.heading),
              SizedBox(height: 20.h),

              Text('Sort By', style: AppTextStyles.mark.copyWith(
                  color: const Color(0xFF364153))),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 8.w,
                children: ['Newest', 'Oldest', 'A - Z'].map((s) =>
                    GestureDetector(
                      onTap: () => setSheetState(() => tempSort = tempSort == s ? '' : s),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                            color: tempSort == s
                                ? AppColors.primary
                                : const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Text(s, style: AppTextStyles.mark.copyWith(
                            color: tempSort == s ? Colors.white : const Color(0xFF4A5565))),
                      ),
                    )).toList(),
              ),
              SizedBox(height: 20.h),

              Text('Role', style: AppTextStyles.mark.copyWith(
                  color: const Color(0xFF364153))),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 8.w,
                children: ['Driver', 'Passenger', 'Organizer'].map((s) =>
                    GestureDetector(
                      onTap: () => setSheetState(() => tempRole = tempRole == s ? '' : s),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                            color: tempRole == s
                                ? AppColors.primary
                                : const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Text(s, style: AppTextStyles.mark.copyWith(
                            color: tempRole == s ? Colors.white : const Color(0xFF4A5565))),
                      ),
                    )).toList(),
              ),
              SizedBox(height: 24.h),

              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.withValues(alpha: 0.4)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r)),
                              padding: EdgeInsets.symmetric(vertical: 14.h)),
                          onPressed: () {
                            setSheetState(() { tempSort = ''; tempRole = ''; });
                            setState(() { _selectedSort = ''; _selectedRole = ''; });
                            Navigator.pop(context);
                          },
                          child: Text('Reset', style: AppTextStyles.medium))),
                  SizedBox(width: 12.w),
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r)),
                              padding: EdgeInsets.symmetric(vertical: 14.h)),
                          onPressed: () {
                            setState(() {
                              _selectedSort = tempSort;
                              _selectedRole = tempRole;
                            });
                            Navigator.pop(context);
                          },
                          child: Text('Apply', style: AppTextStyles.medium.copyWith(
                              color: Colors.white)))),
                ],
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}