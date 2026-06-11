import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_text_field.dart';

class ContactListScreen extends StatefulWidget {
  final bool isFromCreateCarpool;

  const ContactListScreen({
    super.key,
    this.isFromCreateCarpool = false,
  });

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final _searchCtrl = TextEditingController();

  String _searchQuery = '';
  bool _showOnlyInviteable = false;
  List<Map<String, dynamic>> _filteredContacts = [];

  final List<Map<String, dynamic>> _contacts = [
    {'name': 'Courtney Henry', 'phone': '(201) 555-0124', 'initials': 'AB', 'canInvite': false},
    {'name': 'Albert Flores', 'phone': 'abc323@gmail.com', 'initials': 'Ac', 'canInvite': true},
    {'name': 'Savannah Nguyen', 'phone': '(405) 555-0128', 'initials': 'Ad', 'canInvite': false},
    {'name': 'Devon Lane', 'phone': '(505) 555-0125', 'initials': 'Ae', 'canInvite': false},
    {'name': 'Bessie Cooper', 'phone': '(319) 555-0115', 'initials': 'AB', 'canInvite': false},
    {'name': 'Jacob Jones', 'phone': '(603) 555-0123', 'initials': 'AB', 'canInvite': false},
    {'name': 'Jerome Bell', 'phone': '(808) 555-0111', 'initials': 'AB', 'canInvite': false},
  ];

  @override
  void initState() {
    super.initState();
    _applyFilters();
  }

  void _applyFilters() {
    setState(() {
      _filteredContacts = _contacts.where((user) {
        final matchesSearch = user['name'].toLowerCase().contains(_searchQuery.toLowerCase());
        final matchesFilter = !_showOnlyInviteable || (user['canInvite'] == true);
        return matchesSearch && matchesFilter;
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
          title: Text('Contact List', style: AppTextStyles.heading)),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.37.w, vertical: 16.25.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(),
                  SizedBox(height: 16.h),
                  _buildFilterButton(),
                ],
              ),
            ),

            Divider(color: Colors.grey.shade300, height: 2, thickness: 2),

            if (widget.isFromCreateCarpool) _buildNoticeBanner(),

            Expanded(
              child: Container(
                color: const Color(0xFFFAF9F6),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  itemCount: _filteredContacts.length,
                  itemBuilder: (_, i) => _contactTile(_filteredContacts[i], i)
                      .animate()
                      .fadeIn(delay: (i * 80).ms, duration: 400.ms),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: widget.isFromCreateCarpool
          ? const AppBottomNav(currentIndex: 1)
          : null,
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
        setState(() => _showOnlyInviteable = !_showOnlyInviteable);
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


  Widget _contactTile(Map<String, dynamic> c, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      decoration: BoxDecoration(
        color:const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundColor: const Color(0xFFF8F8F5),
            child: Text(
              c['initials'],
              style: AppTextStyles.title.copyWith(color: const Color(0xFF0C0C0C)))),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c['name'], style: AppTextStyles.title.copyWith(fontSize: 16.sp,color: const Color(0xFF0C0C0C))),
                SizedBox(height: 4.h),
                Text(c['phone'], style: AppTextStyles.hintText),
              ],
            ),
          ),

          if (c['canInvite'])
            Container(
              padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFF66B2A3),
                borderRadius: BorderRadius.circular(10.16.r)),
              child: Text('Invite', style: AppTextStyles.displaySmall))
          else
            GestureDetector(
              onTap: () => _showDeleteDialog(index),
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: const Color(0xFFFAE6E6),
                child: SvgPicture.asset(
                    'assets/icons/delete_outline.svg', width: 24.sp, height: 24.sp,
                    colorFilter: const ColorFilter.mode(Color(0xFFF53838), BlendMode.srcIn)),
              ),
            ),
        ],
      ),
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        backgroundColor: const Color(0xFFFCFCFC),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Delete Contact',
                style: AppTextStyles.digit.copyWith(color: const Color(0xFFF53838))),

              SizedBox(height: 24.h),
              Divider(color: Colors.grey.shade300, height: 2, thickness: 1),
              SizedBox(height: 24.h),

              Text('Are you sure to delete this contact?',
                style: AppTextStyles.delete,
                textAlign: TextAlign.center),
              SizedBox(height: 24.h),

          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  text: 'No',
                  onPressed: () => Navigator.pop(context),
                ),
              ),
                  SizedBox(width: 12.w),

              Expanded(
                child: DangerButton(
                  text: 'Yes',
                  backgroundColor: Colors.white,
                  borderColor: const Color(0xFFF53838),
                  onPressed: () {
                    setState(() {
                      final itemToDelete = _filteredContacts[index];
                      _contacts.removeWhere((element) => element == itemToDelete);
                      _applyFilters();
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}