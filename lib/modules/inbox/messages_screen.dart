import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_text_field.dart';
import 'chat_detail_screen.dart';

class MessagesScreen extends StatefulWidget {
  final int initialTab;
  const MessagesScreen({super.key, this.initialTab = 0});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchCtrl = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _chats = [

    {'name': 'Morning School Run', 'msg': 'Sequi quae aliquid numquam...', 'time': '08:09 PM', 'unreadCount': 2, 'isGroup': true, 'image': 'assets/images/avatar.jpg','memberCount': 3},
    {'name': 'Sarah Johnson', 'msg': 'Sequi quae aliquid numquam...', 'time': '08:09 PM', 'unreadCount': 0, 'isGroup': false, 'image': 'assets/images/avatar1.jpg'},
    {'name': 'Weekend Soccer Practice', 'msg': 'Sequi quae aliquid numquam...', 'time': '08:09 PM', 'unreadCount': 2, 'isGroup': true, 'image': 'assets/images/avatar2.jpg','memberCount': 5},
    {'name': 'Mike Thompson', 'msg': 'Sequi quae aliquid numquam...', 'time': '08:09 PM', 'unreadCount': 0, 'isGroup': false, 'image': 'assets/images/avatar3.jpg'},
    {'name': 'Arlene McCoy', 'msg': 'Sequi quae aliquid numquam...', 'time': '08:09 PM', 'unreadCount': 0, 'isGroup': true, 'image': 'assets/images/avatar.jpg','memberCount': 12},
    {'name': 'Annette Black', 'msg': 'Sequi quae aliquid numquam...', 'time': '08:09 PM', 'unreadCount': 2, 'isGroup': false, 'image': 'assets/images/avatar1.jpg'},
    {'name': 'Wade Warren', 'msg': 'Sequi quae aliquid numquam...', 'time': '08:09 PM', 'unreadCount': 0, 'isGroup': true, 'image': 'assets/images/avatar2.jpg','memberCount': 4},
  ];

  final List<Map<String, dynamic>> _contactInvitations = [
    {'name': 'Albert Flores', 'phone': '(201) 555-0124', 'image': 'assets/images/avatar3.jpg', 'isPending': true},
    {'name': 'Jenny Wilson', 'phone': '(201) 555-0198', 'image': 'assets/images/avatar.jpg', 'isPending': false,},
    {'name': 'Robert Fox', 'phone': '(201) 555-0147', 'image': 'assets/images/avatar1.jpg', 'isPending': false,},
    {'name': 'Cody Fisher', 'phone': '(201) 555-0133', 'image': 'assets/images/avatar2.jpg', 'isPending': false,},
    {'name': 'Savannah Nguyen', 'phone': '(201) 555-0109', 'image': 'assets/images/avatar3.jpg', 'isPending': false,},
  ];

  final List<Map<String, dynamic>> _carpoolInvitations = [
    {'name': 'Adam Brown', 'phone': '(201) 555-0124', 'address': '41-40 Parker Rd. Allentown, New Mexico 31134', 'distance': '1.9 km', 'image': 'assets/images/avatar.jpg', 'isPending': true,},
    {'name': 'Leslie Alexander', 'phone': '(201) 555-0177', 'address': '8502 Preston Rd. Inglewood, Maine 98380', 'distance': '3.2 km', 'image': 'assets/images/avatar1.jpg', 'isPending': false,},
    {'name': 'Jacob Jones', 'phone': '(201) 555-0155', 'address': '2464 Royal Ln. Mesa, New Jersey 45463', 'distance': '5.1 km', 'image': 'assets/images/avatar2.jpg', 'isPending': false},
    {'name': 'Leslie Alexander', 'phone': '(201) 555-0177', 'address': '8502 Preston Rd. Inglewood, Maine 98380', 'distance': '3.2 km', 'image': 'assets/images/avatar1.jpg', 'isPending': false,},
    {'name': 'Jacob Jones', 'phone': '(201) 555-0155', 'address': '2464 Royal Ln. Mesa, New Jersey 45463', 'distance': '5.1 km', 'image': 'assets/images/avatar2.jpg', 'isPending': false},
  ];

  List<Map<String, dynamic>> get _filteredChats => _chats
      .where((c) =>
      c['name'].toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTab,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchCtrl.dispose();
    super.dispose();
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
        title: Text('Messages', style: AppTextStyles.heading),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(110.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                child: _buildSearchBar()),
              SizedBox(height: 16.h),
              TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorSize: TabBarIndicatorSize.label,
                dividerColor: Colors.transparent,
                controller: _tabController,
                padding: EdgeInsets.only(left: 24.w),
                labelPadding: EdgeInsets.symmetric(horizontal: 12.w),
                labelColor: AppColors.primary,
                unselectedLabelColor: const Color(0xFF707070),
                indicatorColor: AppColors.primary,
                indicatorWeight: 1,
                labelStyle: AppTextStyles.display,
                unselectedLabelStyle: AppTextStyles.display,
                tabs: const [
                  Tab(text: 'Chats'),
                  Tab(text: 'Contact Invitations'),
                  Tab(text: 'Carpool Invitations'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChatList(),
          _buildInvitationList(isCarpool: false),
          _buildInvitationList(isCarpool: true),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),
    );
  }

  Widget _buildSearchBar() {
    return AppTextField(
      controller: _searchCtrl,
      hintText: 'Search messages...',
      fillColor: Colors.white,
      borderColor: const Color(0xFFD1D5DC),
      borderRadius: 14.r,
      prefixIcon: SvgPicture.asset('assets/icons/search_outlined.svg', width: 20.sp, height: 20.sp,
          colorFilter: const ColorFilter.mode(Color(0xFF99A1AF), BlendMode.srcIn)),
      onChanged: (value) => setState(() => _searchQuery = value),
    );
  }

  Widget _buildChatList() {
    final chats = _filteredChats;
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      itemCount: chats.length,
      itemBuilder: (_, i) {
        final c = chats[i];
        final hasUnread = (c['unreadCount'] as int) > 0;
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatDetailScreen(chatData: c))),
          child: Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding:
            EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFCFCFC),
              borderRadius: BorderRadius.circular(8.r)),
            child: Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 24.r,
                  backgroundImage: AssetImage(c['image'])),
                SizedBox(width: 12.w),

                // Name + message
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c['name'],
                          style: AppTextStyles.title.copyWith(color: const Color(0xFF101828))),
                      SizedBox(height: 4.h),
                      Text(
                        c['msg'],
                        style: AppTextStyles.hintText.copyWith(color: const Color(0xFF757575)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),

                // Time + unread badge
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      c['time'],
                      style: AppTextStyles.hintText.copyWith(color: const Color(0xFF707070))),
                    SizedBox(height: 4.h),
                    if (hasUnread)
                      Container(
                        width: 16.w,
                        height: 16.w,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Text(
                          '${c['unreadCount']}',
                          style: AppTextStyles.notice.copyWith(color: Colors.white)))
                    else
                      SizedBox(height: 20.w),
                  ],
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(delay: (i * 60).ms, duration: 300.ms)
              .slideY(begin: 0.1),
        );
      },
    );
  }

  Widget _buildInvitationList({required bool isCarpool}) {
    final allItems = isCarpool ? _carpoolInvitations : _contactInvitations;

    final items = _searchQuery.isEmpty
        ? allItems
        : allItems
        .where((item) => item['name']
        .toString()
        .toLowerCase()
        .contains(_searchQuery.toLowerCase()))
        .toList();

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      itemCount: items.length,
      itemBuilder: (_, i) {
        final item = items[i];
        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
              color: const Color(0xFFFCFCFC),
              borderRadius: BorderRadius.circular(12.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 32.r,
                      backgroundImage: AssetImage(item['image'])),
                  SizedBox(width: 12.w),

                  // name + address/phone
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // name row + distance (carpool only)
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                item['name'].toString(),
                                style: AppTextStyles.social.copyWith(color: const Color(0xFF0C0C0C)))),
                            if (isCarpool)
                              Text(
                                item['distance'].toString(),
                                style: AppTextStyles.hintText.copyWith(color: const Color(0xFF0C0C0C)),
                              ),
                          ],
                        ),
                        SizedBox(height: 4.h),

                        // contact → phone, carpool → address
                        if (!isCarpool)
                          Text(
                            item['phone'].toString(),
                            style: AppTextStyles.hintText.copyWith(color: const Color(0xFF707070))),

                        if (isCarpool) ...[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/icons/location.svg', width: 24.sp, height: 24.sp,
                                  colorFilter: const ColorFilter.mode(Color(0xFF2A2B2D), BlendMode.srcIn)),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  item['address'].toString(),
                                  style: AppTextStyles.address,
                                  maxLines: 2)),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Pending badge —  right, vertically centered
                  if (item['isPending'] == true) ...[
                    SizedBox(width: 12.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                          color: const Color(0xFFFFD8D8),
                          borderRadius: BorderRadius.circular(10.r),
                        boxShadow: AppColors.softShadow),
                      child: Text( 'Pending',
                        style: AppTextStyles.pending)),
                  ],
                ],
              ),

              // Delete + Confirm buttons (isPending false হলে)
              if (item['isPending'] == false) ...[
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40.h,
                        child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: AppColors.softShadow),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFF53838)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r))),
                            onPressed: () {
                              setState(() {
                                if (isCarpool) {
                                  _carpoolInvitations.remove(item);
                                } else {
                                  _contactInvitations.remove(item);
                                }
                              });
                            },
                          child: Text(
                            'Delete',
                            style: AppTextStyles.display.copyWith(color: const Color(0xFFF53838))))))),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: SizedBox(
                        height: 40.h,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: AppColors.softShadow),
                        child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r))),
                            onPressed: () {
                              setState(() {
                                if (isCarpool) {
                                  _carpoolInvitations.remove(item);
                                } else {
                                  _contactInvitations.remove(item);
                                }
                              });
                            },
                        child: Text('Confirm',
                            style: AppTextStyles.display.copyWith(color:const Color(0xFFFCFCFC)))),
                      )),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ).animate().fadeIn(delay: (i * 80).ms, duration: 300.ms);
      },
    );
  }
}