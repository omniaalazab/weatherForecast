import 'package:flutter/material.dart';

import 'package:weather_app/helper/color_helper.dart';

import '../../../../helper/text_style_helper.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.buttonText,
      this.arrowIcon = const SizedBox(
        height: 1,
      ),
      required this.onPressedFunction,
      this.buttonWidget = const SizedBox(
        width: .5,
        height: .5,
      ),
      this.sideColor,
      this.alignButton = MainAxisAlignment.center,
      this.widthButton = double.infinity});
  final String buttonText;
  final Widget? buttonWidget;
  final Color? sideColor;
  final double widthButton;
  final Function()? onPressedFunction;
  final MainAxisAlignment alignButton;
  final Widget arrowIcon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedFunction,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(widthButton, 55),
        backgroundColor: ColorHelper.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: SizedBox(
        width: widthButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              buttonText,
              style: TextStyleHelper.textStylefontSize18.copyWith(
                color: ColorHelper.darkBlue,
              ),
            ),
            arrowIcon,
          ],
        ),
      ),
    );
  }
}
