import 'package:carpooling/data/app_data.dart';
import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_text_field.dart';

// ── Formatters ──────────────────────────────────────────────────────────────

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write('  ');
      buffer.write(digits[i]);
    }
    final formatted = buffer.toString();
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    String formatted = digits;
    if (digits.length >= 3) {
      formatted =
      '${digits.substring(0, 2)}/${digits.substring(2, digits.length.clamp(0, 4))}';
    }
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

// ── Screen ───────────────────────────────────────────────────────────────────

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
    // load saved data
    final card = AppData().cardData.value;
    _holderCtrl.text = card['holder'] ?? '';
    _cardCtrl.text   = card['number'] ?? '';
    _mmyyCtrl.text   = card['expiry'] ?? '';
    _cvvCtrl.text    = card['cvv']    ?? '';

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

  void _save() {
    if (_holderCtrl.text.trim().isEmpty ||
        _cardCtrl.text.trim().isEmpty ||
        _mmyyCtrl.text.trim().isEmpty ||
        _cvvCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please fill all fields'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
          ));
      return;
    }

    AppData().cardData.value = {
      'holder': _holderCtrl.text.trim(),
      'number': _cardCtrl.text.trim(),
      'expiry': _mmyyCtrl.text.trim(),
      'cvv':    _cvvCtrl.text.trim(),
    };

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Card saved successfully'),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r)),
        ));
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

            // Card Holder
            AppTextField(
                hintText: 'Card Holder',
                controller: _holderCtrl,
                keyboardType: TextInputType.name,
                fillColor: const Color(0xFFF9FAFB),
                borderRadius: 10.r),
            SizedBox(height: 16.h),

            // Card Number
            AppTextField(
                hintText: 'Card Number',
                controller: _cardCtrl,
                keyboardType: TextInputType.number,
                fillColor: const Color(0xFFF9FAFB),
                borderRadius: 10.r,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(22),
                  CardNumberFormatter(),
                ]),
            SizedBox(height: 16.h),

            // MM/YY + CVV
            Row(
              children: [
                Expanded(
                    child: AppTextField(
                        hintText: 'MM/YY',
                        controller: _mmyyCtrl,
                        keyboardType: TextInputType.number,
                        fillColor: Colors.white,
                        borderRadius: 10.r,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          ExpiryFormatter(),
                        ])),
                SizedBox(width: 16.w),
                Expanded(
                    child: AppTextField(
                        hintText: 'CVV',
                        controller: _cvvCtrl,
                        keyboardType: TextInputType.number,
                        fillColor: Colors.white,
                        borderRadius: 10.r,
                        obscureText: true,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(3),
                          FilteringTextInputFormatter.digitsOnly,
                        ])),
              ],
            ),
            SizedBox(height: 24.h),

            PrimaryButton(text: 'Update', onPressed: _save),
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
      height: 270.h,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
          color: const Color(0xFF3B8677),
          borderRadius: BorderRadius.circular(12.r)),
      child: Stack(
        children: [
          // ── decorative circles ──
          Positioned(
            top: -50, right: -10,
            child: Container(
              width: 180.w, height: 180.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08)),
            ),
          ),
          Positioned(
            top: 20, right: 60,
            child: Container(
              width: 140.w, height: 140.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.06)),
            ),
          ),


          // ── card content ──
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('BANK NAME', style: AppTextStyles.card),
                  Text('CARD NAME',
                      style: AppTextStyles.hintText.copyWith(color: Colors.white)),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset('assets/icons/chip.svg',
                      width: 42.w, height: 32.w),
                  SvgPicture.asset('assets/icons/wifi.svg',
                      width: 25.w, height: 25.w),
                ],
              ),
              SizedBox(height: 13.h),
              Text(cardNum, style: AppTextStyles.cardNumber),
              SizedBox(height: 13.h),
              Row(
                children: [
                  Text('01/23',
                      style: AppTextStyles.address.copyWith(color: Colors.white)),
                  SizedBox(width: 56.w),
                  Text(expiry,
                      style: AppTextStyles.address.copyWith(color: Colors.white)),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(holder,
                      style: AppTextStyles.social.copyWith(color: Colors.white)),
                  SvgPicture.asset('assets/icons/mastercard.svg',
                      width: 48.w, height: 30.w),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}