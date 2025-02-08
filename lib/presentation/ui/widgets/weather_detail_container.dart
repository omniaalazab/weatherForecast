import 'package:flutter/material.dart';
import 'package:weather_app/extensions/media_query_values.dart';
import 'package:weather_app/presentation/ui/widgets/weather_datail_column.dart';

import '../../../helper/color_helper.dart';

class WeatherForecastDetailsIn10DaysContainer extends StatelessWidget {
  const WeatherForecastDetailsIn10DaysContainer({
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
    return Container(
        padding: EdgeInsets.all(context.screenHeight / 100),
        margin: EdgeInsets.all(context.screenHeight / 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorHelper.cyan,
        ),
        child: WeatherForcastDetailsIn10DaysColumn(
          temp: temp,
          time: time,
          weatherStateImagePath: weatherStateImagePath,
        ));
  }
}
