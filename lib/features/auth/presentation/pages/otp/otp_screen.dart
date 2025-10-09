import 'package:flutter/material.dart';
import 'package:rash7ly/components/appbar/arrow_back_app_bar.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/auth/presentation/widgets/header_text.dart';
import 'package:rash7ly/features/auth/presentation/widgets/otp_input.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: ArrowBackAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50),
                HeaderText(
                  title: 'OTP Verification',
                  subtitle:
                      'Please check your email www.xxx@xxxl.com to see the verification code',
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Otp Code',
                      style: TextStyles.getSize24(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const OtpPin(),
                const SizedBox(height: 20),
                resendCodeTimer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row resendCodeTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Resend code in',
          style: TextStyles.getSize16(color: AppColors.greyColor),
        ),
        Text('00:00', style: TextStyles.getSize16(color: AppColors.greyColor)),
      ],
    );
  }
}
