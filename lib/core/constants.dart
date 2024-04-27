import 'package:flutter/material.dart';

const grey3 = Color(0xff333333);
const grey5 = Color(0xff555555);
const grey7 = Color(0xff777777);
const grey9 = Color(0xff999999);
const black = Color(0xff000000);
const white = Color(0xffffffff);
const grey8 = Color(0xff888888);
const greyE8 = Color(0xffE8E8E8);
const greyC8 = Color(0xffC8C8C8);
const green = Colors.green;
const blue = Colors.blue;
const pink = Colors.pink;
const focusedBorderColor = Color(0xff17AB90);
const redAccent = Color(0xffFF5252);
const redEc = Color(0xffEC2632);

//borders
const accountBorder = UnderlineInputBorder(
  borderSide: BorderSide(color: grey8),
);

const searchFieldBorder = OutlineInputBorder(
  borderRadius: border16,
  borderSide: BorderSide(
    color: grey9,
    width: 0.2,
  ),
);

const phoneBorder = OutlineInputBorder(
  borderRadius: border16,
  borderSide: BorderSide(color: grey8),
);
const authenticationBorder = OutlineInputBorder(
  borderRadius: border16,
  borderSide: BorderSide(color: greyC8),
);

const border10 = BorderRadius.vertical(
  bottom: Radius.circular(10),
);
const border20 = BorderRadius.all(
  Radius.circular(20),
);
const border19 = BorderRadius.all(
  Radius.circular(19),
);
const border16 = BorderRadius.all(
  Radius.circular(16),
);
const border8 = BorderRadius.all(
  Radius.circular(8),
);
const border12 = BorderRadius.all(
  Radius.circular(12),
);

//fonts
const String bold = 'Gilroy-Bold';

const underlineStyle = TextStyle(
  shadows: [Shadow(offset: Offset(0, -4),color: grey5,)],
  color: Colors.transparent,
  decoration: TextDecoration.underline,
  decorationColor: grey5,
  decorationThickness: 1.5,
  fontSize: 20,
);

//sized boxes
const box_5 = SizedBox(
  height: 5,
);
const box_10 = SizedBox(
  height: 10,
);
const box_15 = SizedBox(
  height: 15,
);
const box_20 = SizedBox(
  height: 20,
);
const box_25 = SizedBox(
  height: 25,
);
const box_30 = SizedBox(
  height: 30,
);
const box_35 = SizedBox(
  height: 35,
);
const box_40 = SizedBox(
  height: 40,
);
const box_50 = SizedBox(
  height: 50,
);
const box_100 = SizedBox(
  height: 100,
);
const box_80 = SizedBox(
  height: 80,
);
const box_70 = SizedBox(
  height: 70,
);
const box_60 = SizedBox(
  height: 60,
);
const box_95 = SizedBox(
  height: 95,
);
