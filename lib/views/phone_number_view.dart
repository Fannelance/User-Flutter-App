import 'package:fannelance/core/constants.dart';
import 'package:fannelance/services/check_phone_number_service.dart';
import 'package:fannelance/widgets/authentication_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumberView extends StatefulWidget {
  const PhoneNumberView({
    super.key,
  });

  @override
  State<PhoneNumberView> createState() => PhoneNumberViewState();
}

class PhoneNumberViewState extends State<PhoneNumberView> {
  static TextEditingController phoneNumberController = TextEditingController();
  static String countryDialCode = '';

  @override
  void initState() {
    super.initState();
    countryDialCode = "20";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            box_95,
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.asset(
                      'assets/icons/electrician.png',
                    ),
                  ),
                ),
              ],
            ),

            box_25,

            IntlPhoneField(
              countries: const <Country>[
                Country(
                  name: "Egypt",
                  nameTranslations: {
                    "en": "Egypt",
                    "ar": "مصر",
                  },
                  flag: "🇪🇬",
                  code: "EG",
                  dialCode: "20",
                  minLength: 11,
                  maxLength: 11,
                ),
              ],
              disableLengthCheck: true,
              onCountryChanged: (value) {
                setState(
                  () => countryDialCode = value.dialCode,
                );
              },
              onSubmitted: (value) async {
                await CheckPhoneNumberService().checkPhoneNumberRequest(
                  context: context,
                );
                phoneNumberController.clear();
              },
              controller: phoneNumberController,
              textInputAction: TextInputAction.next,
              invalidNumberMessage: null,
              initialCountryCode: 'EG',
              dropdownTextStyle: const TextStyle(fontSize: 18),
              showCountryFlag: false,
              dropdownIconPosition: IconPosition.trailing,
              pickerDialogStyle: PickerDialogStyle(
                backgroundColor: kWhite,
              ),
              cursorColor: kBlack,
              dropdownDecoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
                  color: Colors.grey,
                )),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(19),
                    bottomLeft: Radius.circular(19)),
              ),
              flagsButtonPadding: const EdgeInsets.fromLTRB(20, 16, 0, 16),
              decoration: InputDecoration(
                prefix: const Row(mainAxisSize: MainAxisSize.min, children: [
                  VerticalDivider(
                    thickness: 1,
                    indent: 20,
                    color: Colors.grey,
                  )
                ]),
                labelStyle: const TextStyle(
                  fontSize: 32,
                ),
                counterText: '',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                hintText: 'Phone Number',
                border: phoneBorder,
                focusedBorder: phoneBorder.copyWith(
                  borderSide: const BorderSide(
                    color: kBlack,
                  ),
                ),
              ),
            ),
            box_20,
            //button
            AuthenticationButtonWidget(
              buttonText: 'Continue',
              buttonOnPressed: () async {
                await CheckPhoneNumberService().checkPhoneNumberRequest(
                  context: context,
                );
                phoneNumberController.clear();
              },
            ),
          ],
        ),
      ),
    ));
  }
}
