import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:rash7ly/components/buttons/main_button.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';

class OtpPin extends StatefulWidget {
  const OtpPin({super.key});

  @override
  State<OtpPin> createState() => _OtpPinState();
}

class _OtpPinState extends State<OtpPin> {
  var focusNode = FocusNode();
  var formKey = GlobalKey<FormState>();
  String? message;

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = AppColors.lightBlueColor;
    const fillColor = Color(0xFFF1F1F3);

    final defaultPinTheme = PinTheme(
      width: 80,
      height: 70,
      textStyle: TextStyles.getSize18(
        color: AppColors.blackColor,
        fontSize: 26,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: fillColor,
      ),
    );

    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              length: 4,
              enableInteractiveSelection: true,
              controller: TextEditingController(),
              focusNode: focusNode,
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => const SizedBox(width: 15),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter OTP';
                }
                return null;
              },
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: focusedBorderColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: focusedBorderColor, width: 1.5),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: fillColor,
                  border: Border.all(color: focusedBorderColor, width: 1.5),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent, width: 1.5),
              ),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(message!, style: TextStyles.getSize18(color: Colors.red)),
              ],
            ),
          ],
          SizedBox(height: 40),
          MainButton(text: 'Submit', onPressed: () {}, height: 65),
        ],
      ),
    );
  }
}
