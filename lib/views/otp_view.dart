import 'package:fannelance/core/constants.dart';
import 'package:fannelance/services/check_phone_number_service.dart';
import 'package:fannelance/services/verify_otp_service.dart';
import 'package:fannelance/widgets/app_bar_sub_widget.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OTPView extends StatefulWidget {
  final String nextPage;
  const OTPView({
    Key? key,
    required this.nextPage,
  }) : super(key: key);

  @override
  State<OTPView> createState() => OTPViewState();
}

class OTPViewState extends State<OTPView> {
  final focusNode = FocusNode();
  String pinController = '';

  @override
  void initState() {
    super.initState();
    pinController = '';
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final defaultPinTheme = PinTheme(
      width: screenWidth / 7,
      height: screenWidth / 7,
      textStyle: const TextStyle(
        fontSize: 22,
      ),
      decoration: BoxDecoration(
        borderRadius: kBorder19,
        border: Border.all(color: kGrey8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyBorderWith(
      border: Border.all(color: kFocusedBorderColor),
    );

    return Scaffold(
      appBar: const AppBarSubWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            box_20,
            //title
            SizedBox(
              width: screenWidth / 1.4,
              child: Text(
                'Verify your phone number',
                style: TextStyle(
                  fontSize: screenWidth / 11,
                  height: 1.1,
                  fontFamily: kBold,
                ),
              ),
            ),
            box_15,
            //note
            Row(
              children: [
                Flexible(
                  child: Text(
                    'We sent an SMS with a 5-digit code to XXX XXXX X'
                    '${CheckPhoneNumberService.phoneNumber.substring(10)}',
                    maxLines: 3,
                    style: TextStyle(
                      color: kGrey7,
                      height: 1.4,
                      fontSize: screenWidth / 21,
                    ),
                  ),
                ),
              ],
            ),

            box_30,

            //pins
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    length: 5,
                    autofocus: true,
                    focusNode: focusNode,
                    onTapOutside: (pointer) {
                      focusNode.unfocus();
                    },
                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsRetrieverApi,
                    listenForMultipleSmsOnAndroid: true,
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {
                      setState(
                        () => pinController = pin,
                      );
                      VerifyOtpService().verifyOtpRequest(
                        pinController: pinController,
                        context: context,
                        nextPage: widget.nextPage,
                      );
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            bottom: 9,
                          ),
                          width: 22,
                          height: 1,
                          color: kBlack,
                        ),
                      ],
                    ),
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: focusedPinTheme,
                  ),
                ),
              ],
            ),

            box_30,

            //send again
            Row(
              children: [
                Text(
                  "Didn't recieve a code? ",
                  style: TextStyle(
                    color: kGrey5,
                    fontSize: screenWidth / 22,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Resend',
                    style: TextStyle(
                      fontSize: screenWidth / 22,
                      color: kFocusedBorderColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
