import 'dart:io';

import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class ChatDetailScreen extends StatefulWidget {
  final String chatName;
  const ChatDetailScreen({super.key, required this.chatName});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final _msgCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  final ImagePicker _picker = ImagePicker();
  bool _showEmojiPicker = false;

  final List<Map<String, dynamic>> _messages = [
    {'sender': 'Sarah Johnson', 'msg': 'Good morning everyone!', 'time': '8:30 AM', 'isMe': false, 'isRead': false},
    {'sender': 'Me', 'msg': 'Morning! I\'ll be there in 5 minutes', 'time': '8:32 AM', 'isMe': true, 'isRead': true},
    {'sender': 'Mike Thompson', 'msg': 'Great, we\'re ready!', 'time': '8:33 AM', 'isMe': false, 'isRead': false},
    {'sender': 'Me', 'msg': 'I\'m on the way!', 'time': '8:35 AM', 'isMe': true, 'isRead': false},
  ];

  final List<String> _quickReplies = [
    'I\'m on the way',
    'Running late',
    'Reached destination',
  ];

  bool _isOnlyEmoji(String text) {
    final trimmed = text.trim();
    final emojiRegex = RegExp(
      r'^(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff]|\s)+$',
    );
    return emojiRegex.hasMatch(trimmed) && trimmed.isNotEmpty;
  }

  @override
  void dispose() {
    _msgCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_msgCtrl.text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        'sender': 'Me',
        'msg': _msgCtrl.text.trim(),
        'time': 'Now',
        'isMe': true,
      });
      _msgCtrl.clear();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollCtrl.animateTo(
        _scrollCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
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
                          color: Color(0xFFF3F4F6), shape: BoxShape.circle),
                      child: Icon(Icons.arrow_back, size: 22.sp, color: const Color(0xFF364153))))),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.chatName, style: AppTextStyles.message),
              Text('3 members',
                  style: AppTextStyles.school.copyWith(color:const Color(0xFF4A5565))),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 24.38.w),
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xFFF3F4F6),
                    shape: BoxShape.circle),
                child: IconButton(
                  icon: Icon(Icons.more_vert, color: const Color(0xFF364153), size: 20.sp),
                  onPressed: () {},
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(6.0),
              child: Divider(
                  color: Colors.grey.shade300, height: 2, thickness: 2))),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (_showEmojiPicker) {
                  setState(() => _showEmojiPicker = false);
                }
              },
              child: ListView.builder(
                controller: _scrollCtrl,
                padding: EdgeInsets.symmetric(
                    horizontal: 24.38.w, vertical: 16.h),
                itemCount: _messages.length,
                itemBuilder: (_, i) {
                  final m = _messages[i];
                  return _messageBubble(m)
                      .animate()
                      .fadeIn(delay: (i * 80).ms, duration: 300.ms);
                },
              ),
            ),
          ),
          _buildQuickReplies(),
          SizedBox(height: 26.79.h),
          Divider(color: Colors.grey.shade300, height: 2, thickness: 2),
          _buildInputBar(),
          if (_showEmojiPicker)
            Container(
              height: 200.h,
              color: Colors.white,
              padding: EdgeInsets.all(12.w),
              child: GridView.count(
                crossAxisCount: 8,
                children: [
                  '😊','😂','❤️','👍','🎉','😍','🙏','😭',
                  '😅','🔥','💪','✅','👋','🤔','😎','💯',
                  '🚗','🏫','👨‍👩‍👧','📍','⭐','🌟','💬','📞',
                  '😴','🤗','😇','🥰','😤','😢','😡','🤝',
                ].map((emoji) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _msgCtrl.text += emoji;
                      _msgCtrl.selection = TextSelection.fromPosition(
                        TextPosition(offset: _msgCtrl.text.length),
                      );
                      _showEmojiPicker = false;
                    });
                  },
                  child: Center(
                    child: Text(emoji, style: TextStyle(fontSize: 24.sp)),
                  ),
                )).toList(),
              ),
            ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _messageBubble(Map<String, dynamic> m) {
    final isMe = m['isMe'] as bool;
    final isRead = m['isRead'] as bool? ?? false;
    final isEmoji = _isOnlyEmoji(m['msg']);
    final hasImage = m.containsKey('imagePath') && m['imagePath'] != null;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // sender name (other only)
          if (!isMe) ...[
            Container(
              width: 32.w,
              height: 32.w,
              decoration: const BoxDecoration(
                  gradient: AppColors.purplePinkGradient,
                  shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Text(m['sender'].toString()[0],
                  style: AppTextStyles.displaySmall
                      .copyWith(height: 1.33)),
            ),
            SizedBox(width: 8.w),
          ],
          Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!isMe)
                Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Text(m['sender'],
                      style: AppTextStyles.time
                          .copyWith(color: const Color(0xFF4A5565))),
                ),
              if (hasImage)
                Container(
                  margin: EdgeInsets.only(bottom: 4.h),
                  width: 200.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    image: DecorationImage(
                      image: FileImage(File(m['imagePath'])),
                      fit: BoxFit.cover,
                    ),
                  ),
                )

             else if (isEmoji)
                Text(m['msg'], style: TextStyle(fontSize: 40.sp))
              else
              Container(
                  constraints: BoxConstraints(maxWidth: 0.65.sw),
                  padding: EdgeInsets.fromLTRB(
                      16.25.w, 12.19.h, 12.w, 12.19.h),
                  decoration: BoxDecoration(
                      color: isMe ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(16.26.r),
                      boxShadow: AppColors.cardShadow),
                  child:Text(
                      m['msg'],
                      style: AppTextStyles.school.copyWith(
                          color: isMe ? Colors.white : const Color(0xFF101828)))),
              SizedBox(height: 4.h),
              // time + tick
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Row(
                  children: [
                    Text(
                      m['time'],
                      style: AppTextStyles.time.copyWith(
                          color: isMe
                              ? const Color(0xFF6A7282)
                              : const Color(0xFF6A7282)),
                    ),
                    if (isMe) ...[
                      SizedBox(width: 4.w),
                      SvgPicture.asset(
                        isRead
                            ? 'assets/icons/double_tick.svg'
                            : 'assets/icons/single_tick.svg',
                        width: 12.sp,
                        height: 12.sp,
                        colorFilter: ColorFilter.mode(
                            isRead
                                ? const Color(0xFF93C5FD)
                                : const Color(0xFF99A1AF),
                            BlendMode.srcIn),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickReplies() {
    return SizedBox(
      height: 36.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 24.38.w),
        itemCount: _quickReplies.length,
        itemBuilder: (_, i) => GestureDetector(
          onTap: () {
            setState(() => _msgCtrl.text = _quickReplies[i]);
          },
          child: Container(
            margin: EdgeInsets.only(right: 8.w),
            padding:
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(20.r)),
            child: Text(_quickReplies[i],
                style: AppTextStyles.mark.copyWith(color:const Color(0xFF155DFC))),
          ),
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(24.38.w, 17.5.h, 24.38.w, 16.h),
      child: Row(
        children: [
          // attach icon
          GestureDetector(
            onTap: () async {
              final XFile? image = await _picker.pickImage(
                source: ImageSource.gallery,
              );
              if (image != null) {
                setState(() {
                  _messages.add({
                    'sender': 'Me',
                    'msg': '📷 Photo',
                    'time': 'Now',
                    'isMe': true,
                    'isRead': false,
                    'imagePath': image.path,
                  });
                });
                Future.delayed(const Duration(milliseconds: 100), () {
                  _scrollCtrl.animateTo(
                    _scrollCtrl.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                });
              }
            },
            child: Container(
              width: 40.w, height: 40.w,
              decoration: const BoxDecoration(
                  color: Color(0xFFF3F4F6), shape: BoxShape.circle),
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.w),
              child: SvgPicture.asset('assets/icons/image_outlined.svg', width: 20.sp, height: 20.sp,
                  colorFilter: const ColorFilter.mode(Color(0xFF4A5565), BlendMode.srcIn)),
            ),
          ),
          SizedBox(width: 12.w),

          // text field — শুধু input, emoji নেই ভেতরে
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(100.r),
                  border: Border.all(color: const Color(0xFFD1D5DC))),
              child: TextField(
                controller: _msgCtrl,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: AppTextStyles.medium.copyWith(color: const Color(0x800A0A0A), height: 1),
                  filled: false,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // emoji icon — field এর বাইরে
          GestureDetector(
            onTap: () {
              setState(() => _showEmojiPicker = !_showEmojiPicker);
            },
            child: Container(
              width: 40.w, height: 40.w,
              decoration: const BoxDecoration(
                  color: Color(0xFFF3F4F6), shape: BoxShape.circle),
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.w),
              child: SvgPicture.asset(
                  'assets/icons/emoji.svg',
                  width: 20.sp, height: 20.sp,
                  colorFilter: const ColorFilter.mode(
                      Color(0xFF4A5565), BlendMode.srcIn)),
            ),
          ),
          SizedBox(width: 12.w),

          // send button
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 40.w, height: 40.w,
              decoration: const BoxDecoration(
                  color: Color(0xFF155DFC), shape: BoxShape.circle),
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.w),
              child: SvgPicture.asset(
                  'assets/icons/send.svg',
                  width: 20.sp, height: 20.sp,
                  colorFilter: const ColorFilter.mode(
                      Colors.white, BlendMode.srcIn)),
            ),
          ),
        ],
      ),
    );
  }
}