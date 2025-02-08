import 'package:flutter/material.dart';
import 'package:weather_app/extensions/media_query_values.dart';

import '../../../helper/text_style_helper.dart';

class WeatherForcastDetailsIn10DaysColumn extends StatelessWidget {
 const WeatherForcastDetailsIn10DaysColumn({
    required this.temp,
    required this.time,
    required this.weatherStateImagePath,
    super.key,
  });
 final int temp;
  final String weatherStateImagePath;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("$temp °C", style: TextStyleHelper.textStylefontSize18),
        Image.network(
          "http:$weatherStateImagePath",
          height: context.screenHeight / 12,
          width: context.screenWidth / 12,
        ),
        Text(time, style: TextStyleHelper.textStylefontSize18),
      ],
    );
  }
}
