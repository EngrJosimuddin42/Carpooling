import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_text_field.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _holderCtrl = TextEditingController();
  final _cardCtrl   = TextEditingController();
  final _mmyyCtrl   = TextEditingController();
  final _cvvCtrl    = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cardCtrl.addListener(() => setState(() {}));
    _holderCtrl.addListener(() => setState(() {}));
    _mmyyCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _holderCtrl.dispose();
    _cardCtrl.dispose();
    _mmyyCtrl.dispose();
    _cvvCtrl.dispose();
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
          leadingWidth: 72.w,
          titleSpacing: 8.w,
          leading: Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Color(0xFFF3F4F6), shape: BoxShape.circle),
                      child: Icon(Icons.arrow_back, size: 22.sp,
                          color: const Color(0xFF364153))))),
          title: Text('Payments', style: AppTextStyles.heading)),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            _buildCard(),
            SizedBox(height: 24.h),
            AppTextField(
              hintText: 'Card Holder',
              controller: _holderCtrl,
              keyboardType: TextInputType.name,
              fillColor: Colors.white,
              borderRadius: 10.r),
            SizedBox(height: 16.h),
            AppTextField(
              hintText: 'Card Number',
              controller: _cardCtrl,
              keyboardType: TextInputType.number,
              fillColor: Colors.white,
              borderRadius: 10.r),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    hintText: 'MM/YY',
                    controller: _mmyyCtrl,
                    keyboardType: TextInputType.number,
                    fillColor: Colors.white,
                    borderRadius: 10.r)),
                SizedBox(width: 16.w),
                Expanded(
                  child: AppTextField(
                    hintText: 'CVV',
                    controller: _cvvCtrl,
                    keyboardType: TextInputType.number,
                    fillColor: Colors.white,
                    borderRadius: 10.r)),
              ],
            ),
            SizedBox(height: 24.h),
            PrimaryButton(text: 'Update', onPressed: () {}),
            SizedBox(height: 30.h),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 4),
    );
  }

  Widget _buildCard() {
    final cardNum = _cardCtrl.text.isEmpty
        ? '1234  5678  1234  5678'
        : _cardCtrl.text;
    final holder = _holderCtrl.text.isEmpty
        ? 'CARDHOLDER NAME'
        : _holderCtrl.text.toUpperCase();
    final expiry = _mmyyCtrl.text.isEmpty ? '03/27' : _mmyyCtrl.text;

    return Container(
      width: double.infinity,
      height: 210.h,
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4BBFAD), Color(0xFF2A8D79)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4BBFAD).withOpacity(0.45),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // ── decorative circles ──
          Positioned(
            top: -50, right: -10,
            child: Container(
              width: 180.w, height: 180.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08)),
            ),
          ),
          Positioned(
            top: 20, right: 60,
            child: Container(
              width: 140.w, height: 140.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06)),
            ),
          ),

          // ── card content ──
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row 1: BANK NAME + CARD NAME
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('BANK NAME',
                      style: AppTextStyles.medium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2)),
                  Text('CARD NAME',
                      style: AppTextStyles.medium.copyWith(
                          color: Colors.white70)),
                ],
              ),

              SizedBox(height: 14.h),

              // Row 2: chip + contactless
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Chip SVG
                  SvgPicture.asset(
                    'assets/icons/chip.svg', width: 42.w, height: 32.w,
                    colorFilter: const ColorFilter.mode(
                        Color(0xFFE5A100), BlendMode.srcIn),
                  ),
                  // Contactless SVG
                  SvgPicture.asset(
                    'assets/icons/wifi.svg',
                    width: 25.w,
                    height: 25.w,
                    colorFilter: const ColorFilter.mode(
                        Colors.white70, BlendMode.srcIn),
                  ),
                ],
              ),

              SizedBox(height: 14.h),

              // Card number
              Text(cardNum,
                  style: AppTextStyles.large.copyWith(
                      color: Colors.white,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w600)),

              SizedBox(height: 6.h),

              // Row 3: 01/23  03/27
              Row(
                children: [
                  Text('01/23',
                      style: AppTextStyles.school.copyWith(color: Colors.white70)),
                  SizedBox(width: 24.w),
                  Text(expiry,
                      style: AppTextStyles.school.copyWith(color: Colors.white70)),
                ],
              ),

              const Spacer(),

              // Row 4: CARDHOLDER NAME + mastercard
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(holder,
                      style: AppTextStyles.medium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8)),

                  // Mastercard SVG
                  SvgPicture.asset(
                    'assets/icons/mastercard.svg',
                    width: 48.w,
                    height: 30.w,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}