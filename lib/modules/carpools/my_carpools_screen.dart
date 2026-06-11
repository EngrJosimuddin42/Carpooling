import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/app_data.dart';
import '../../widgets/app_bottom_nav.dart';
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

  List<Map<String, dynamic>> get _filtered {
    final all = AppData().carpools.value;
    return _selectedFilter == 'All'
        ? all
        : all.where((c) => c['status'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text('My Carpools', style: AppTextStyles.large),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.history, color: AppColors.primary, size: 16.sp),
            label: Text('History',
                style:
                AppTextStyles.medium.copyWith(color: AppColors.primary)),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                children: [
                  _buildSearchBar(),
                  SizedBox(height: 10.h),
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
                      child: Text('No carpools yet',
                          style: AppTextStyles.medium.copyWith(color: Colors.grey)),
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
    return TextField(
      controller: _searchCtrl,
      decoration: InputDecoration(
        hintText: 'Search carpools...',
        hintStyle: AppTextStyles.medium.copyWith(color: Colors.grey),
        prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20.sp),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 10.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  Widget _buildFilterRow() {
    return Row(
      children: [
        ..._filters.map((f) => GestureDetector(
          onTap: () => setState(() => _selectedFilter = f),
          child: Container(
            margin: EdgeInsets.only(right: 8.w),
            padding: EdgeInsets.symmetric(
                horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: _selectedFilter == f
                  ? AppColors.primary
                  : Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: _selectedFilter == f
                    ? AppColors.primary
                    : const Color(0xFFE0E0E0),
              ),
            ),
            child: Text(f,
                style: AppTextStyles.medium.copyWith(
                  color: _selectedFilter == f
                      ? Colors.white
                      : Colors.grey,
                )),
          ),
        )),
        const Spacer(),
        Icon(Icons.filter_list, color: Colors.grey, size: 22.sp),
      ],
    );
  }
}