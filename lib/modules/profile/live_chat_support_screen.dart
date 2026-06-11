import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

class LiveChatSupportScreen extends StatefulWidget {
  const LiveChatSupportScreen({super.key});

  @override
  State<LiveChatSupportScreen> createState() => _LiveChatSupportScreenState();
}

class _LiveChatSupportScreenState extends State<LiveChatSupportScreen> {
  final _msgCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  bool _isTyping = false;

  final List<Map<String, dynamic>> _messages = [
    {
      'msg': 'Hello! Welcome to Carpool Support. How can I help you today?',
      'time': '10:30 AM',
      'isMe': false,
    },
    {
      'msg': 'Hi, I need help with creating a carpool event',
      'time': '10:31 AM',
      'isMe': true,
    },
    {
      'msg': "I'd be happy to help you with that! To create a carpool event, go to the Carpools tab and tap the '+' button. What specific issue are you facing?",
      'time': '10:31 AM',
      'isMe': false,
    },
  ];

  @override
  void dispose() {
    _msgCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _msgCtrl.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'msg': text, 'time': 'Now', 'isMe': true});
      _msgCtrl.clear();
      _isTyping = true;
    });

    _scrollToBottom();

    // Simulate support reply
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add({
          'msg': 'Thank you for your message. Our support team will get back to you shortly.',
          'time': 'Now',
          'isMe': false,
        });
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
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
                      child: Icon(Icons.arrow_back,
                          size: 22.sp, color: const Color(0xFF364153))))),
          title: Row(
            children: [
              CircleAvatar(
                  radius: 20.r,
                  backgroundColor: AppColors.primary,
                  child: Text('CS',
                      style: AppTextStyles.cs)),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customer Support', style: AppTextStyles.heading),
                  Row(
                    children: [
                      Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: const BoxDecoration(
                              color: Color(0xFF00BC7D),
                              shape: BoxShape.circle)),
                      SizedBox(width: 8.w),
                      Text('Online',
                          style: AppTextStyles.time.copyWith(
                              color: const Color(0xFF009966))),
                    ],
                  ),
                ],
              ),
            ],
          ),

          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(2.0),
              child: Divider(
                  color: Colors.grey.shade300, height: 2, thickness: 2))),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (_, i) {
                if (_isTyping && i == _messages.length) {
                  return _typingIndicator()
                      .animate()
                      .fadeIn(duration: 200.ms);
                }
                return _messageBubble(_messages[i], i)
                    .animate()
                    .fadeIn(delay: (i * 60).ms, duration: 300.ms);
              },
            ),
          ),
          _buildInputBar(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _messageBubble(Map<String, dynamic> m, int i) {
    final isMe = m['isMe'] as bool;
    return Padding(
        padding: EdgeInsets.only(bottom: 14.h),
        child: Column(
            crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 0.7.sw),
                      padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: isMe ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(16.26.r),
                        boxShadow: const [
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
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            m['msg'],
                            style: AppTextStyles.chat.copyWith(
                              color: isMe ? Colors.white : const Color(
                                  0xFF101828),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                              m['time'],
                              style: AppTextStyles.time.copyWith(color: isMe
                                  ? const Color(0xFFDBEAFE)
                                  : const Color(0xFF101828))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]
        ));
  }

  Widget _typingIndicator() {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h, left: 24.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.26.r),
          boxShadow: const [
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
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) =>
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                    color: Color(0xFF99A1AF),
                    shape: BoxShape.circle),
              ).animate(onPlay: (c) => c.repeat())
                  .fadeIn(delay: (i * 200).ms, duration: 400.ms)
                  .then()
                  .fadeOut(duration: 400.ms)),
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 17.h),
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(color: Color(0xFFE5E7EB), width: 2)),
          color: Colors.white),
      child: Row(
        children: [
          _buildCircularIcon('assets/icons/attach_file.svg', () {}),
          SizedBox(width: 12.w),
          _buildCircularIcon('assets/icons/image_outlined.svg', () {}),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: _msgCtrl,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                hintStyle: AppTextStyles.medium.copyWith(color: const Color(0x800A0A0A)),
                filled: true,
                fillColor:AppColors.white,
                contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.23.r),
                  borderSide: const BorderSide(color: Color(0xFFD1D5DC), width: 1.24)),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.23.r),
                  borderSide: const BorderSide(color: Color(0xFFD1D5DC), width: 1.24)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.23.r),
                  borderSide: const BorderSide(color: Color(0xFFD1D5DC), width: 1.24))),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: EdgeInsets.all(10.w),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle),
              child: SvgPicture.asset(
                  'assets/icons/send.svg', width: 20.sp, height: 20.sp,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularIcon(String assetPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: const BoxDecoration(
            color: Color(0xFFF3F4F6),
            shape: BoxShape.circle),
        child: SvgPicture.asset(
          assetPath, width: 20.sp, height: 20.sp,
          colorFilter: const ColorFilter.mode(
            Color(0xFF4A5565),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}