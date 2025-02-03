import 'package:flutter/material.dart';
import 'package:weather_app/helper/text_style_helper.dart';

import '../../../../helper/color_helper.dart';

@immutable
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.textHint,
    required this.textController,
    required this.textFieldSuffix,
    required this.validatorFunction,
    this.onChangedFunction,
    this.textFieldPrefix = const SizedBox(
      width: 1,
    ),
    this.isfilled = false,
    this.fillColorTextField = Colors.white,
  });
  final TextEditingController textController;
  final Widget? textFieldSuffix;
  final Widget? textFieldPrefix;
  final String textHint;

  final String? Function(String?)? validatorFunction;
  final Function(String)? onChangedFunction;

  final bool isfilled;
  final Color fillColorTextField;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: textController,
        decoration: InputDecoration(
          prefixIcon: textFieldPrefix,
          hintText: textHint,
          hintStyle: TextStyleHelper.textStylefontSize18
              .copyWith(color: ColorHelper.blue),
          filled: isfilled,
          fillColor: fillColorTextField,
          suffixIcon: textFieldSuffix,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: ColorHelper.blue,
              width: 2,
            ),
          ),
          enabledBorder: InputBorder.none,
        ),
        validator: validatorFunction,
        onChanged: onChangedFunction,
      ),
    );
  }
}
