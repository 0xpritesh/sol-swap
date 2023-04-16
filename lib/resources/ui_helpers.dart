import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Widget hSpaceTiny = SizedBox(width: 5.0);
const Widget hSpaceSmall = SizedBox(width: 10.0);
const Widget hSpaceMedium = SizedBox(width: 25.0);
const Widget hSpaceLarge = SizedBox(width: 40.0);
const Widget hSpaceMassive = SizedBox(width: 50.0);

const Widget vSpaceTiny = SizedBox(height: 5.0);
const Widget vSpaceSmall = SizedBox(height: 10.0);
const Widget vSpaceMedium = SizedBox(height: 25.0);
const Widget vSpaceLarge = SizedBox(height: 80.0);
const Widget vSpaceMassive = SizedBox(height: 120.0);

Widget spacedDivider = Column(
  children: const <Widget>[
    vSpaceMedium,
    Divider(color: Colors.blueGrey, height: 5.0),
    vSpaceMedium,
  ],
);

Widget verticalSpace(double height) => SizedBox(height: height);

extension CustomContext on BuildContext {
  double screenHeight({double percent = 1}) =>
      MediaQuery.of(this).size.height * percent;

  double screenWidth({double percent = 1}) =>
      MediaQuery.of(this).size.width * percent;
}

double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
Widget emptyBox() => const SizedBox.shrink();

AppBar noTitleAppBar({bool isLight = true, bool leading = true}) {
  return AppBar(
    automaticallyImplyLeading: leading,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0,
    // ignore: deprecated_member_use
    brightness: isLight ? Brightness.light : Brightness.dark,
  );
}

showInfoMessage({required message, title}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: Colors.green,
    colorText: Colors.white,
    shouldIconPulse: true,
    snackPosition: SnackPosition.TOP,
    animationDuration: const Duration(microseconds: 25),
    icon: const Icon(
      Icons.cancel,
      size: 18,
      color: Colors.white,
    ),
  );
}

// Screen Size helpers

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;

double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;
