import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/* ************************* instants ************************* */

const kSecureStorage = FlutterSecureStorage();

/* ************************* Colors ************************* */

const kGrey3 = Color(0xff333333);
const kGrey5 = Color(0xff555555);
const kGrey6 = Color(0xff666666);
const kGrey7 = Color(0xff777777);
const kGrey8 = Color(0xff888888);
const kGrey9 = Color(0xff999999);
const kGreyE8 = Color(0xffE8E8E8);
const kGreyC8 = Color(0xffC8C8C8);
const kBlack = Colors.black;
const kWhite = Colors.white;
const kGreen = Color(0xff5ABA93);
const kPrimaryColor = Color(0xff1498B7);
const kRedEc = Color(0xffEC2632);
const kAmber = Colors.amber;


/* ************************* Borders ************************* */

const accountBorder = UnderlineInputBorder(
  borderSide: BorderSide(color: kGrey8),
);

const searchFieldBorder = OutlineInputBorder(
  borderRadius: kBorder16,
  borderSide: BorderSide(
    color: kGrey9,
    width: 0.3,
  ),
);

const phoneBorder = OutlineInputBorder(
  borderRadius: kBorder16,
  borderSide: BorderSide(color: kGrey8),
);

const authenticationBorder = OutlineInputBorder(
  borderRadius: kBorder16,
  borderSide: BorderSide(color: kGreyC8),
);

const kBorder8 = BorderRadius.all(Radius.circular(8));
const kBorder20 = BorderRadius.all(Radius.circular(20));
const kBorder19 = BorderRadius.all(Radius.circular(19));
const kBorder16 = BorderRadius.all(Radius.circular(16));
const kBorder12 = BorderRadius.all(Radius.circular(12));
const kBorder10 = BorderRadius.all(Radius.circular(10));
const kBorderV10 = BorderRadius.vertical(bottom: Radius.circular(10));

/* ************************* Fonts ************************* */

const String kBold = 'Gilroy-Bold';
const String kSemiBold = 'Gilroy-SemiBold';

const underlineStyle = TextStyle(
  shadows: [
    Shadow(
      offset: Offset(0, -4),
      color: kGrey5,
    )
  ],
  color: Colors.transparent,
  decoration: TextDecoration.underline,
  decorationColor: kGrey5,
  decorationThickness: 1.5,
  fontSize: 20,
);

/* ************************* Sized Boxes ************************* */

const box_5 = SizedBox(height: 5);
const box_10 = SizedBox(height: 10);
const box_15 = SizedBox(height: 15);
const box_20 = SizedBox(height: 20);
const box_25 = SizedBox(height: 25);
const box_30 = SizedBox(height: 30);
const box_35 = SizedBox(height: 35);
const box_40 = SizedBox(height: 40);
const box_50 = SizedBox(height: 50);
const box_60 = SizedBox(height: 60);
const box_70 = SizedBox(height: 70);
const box_80 = SizedBox(height: 80);
const box_95 = SizedBox(height: 95);
const box_100 = SizedBox(height: 100);