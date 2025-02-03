import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/text_constant.dart';
import 'package:weather_app/data/Repository/report_weather_per_hour.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/extensions/media_query_values.dart';
import 'package:weather_app/extensions/navigation_extension.dart';
import 'package:weather_app/helper/color_helper.dart';
import 'package:weather_app/helper/text_style_helper.dart';
import 'package:weather_app/presentation/view/screens/home.dart';

import 'package:weather_app/presentation/view/widgets/weather_detail_container.dart';
import 'package:weather_app/presentation/view_model/report_weather_10_days_cubit/report_weather_10_days_cubit.dart';
import 'package:weather_app/presentation/view_model/report_weather_10_days_cubit/report_weather_10_days_state.dart';
import 'package:weather_app/presentation/view_model/report_weather_per_hour_cubit/report_weather_per_hour_state.dart';

import '../../view_model/report_weather_per_hour_cubit/report_weather_per_hour_cubit.dart';

class WeatherForecastReport extends StatefulWidget {
  const WeatherForecastReport({super.key, required this.cityName});
  final String cityName;
  @override
  State<WeatherForecastReport> createState() => _WeatherForecastReportState();
}

class _WeatherForecastReportState extends State<WeatherForecastReport> {
  final ScrollController _scrollController = ScrollController();
  @override
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    context.read<ReportWeatherPerHourCubit>().getReportWeatherPerHour(
          widget.cityName,
          1,
        );

    context.read<ReportWeather10DaysCubit>().getReportWeather10Day(
          widget.cityName,
          10,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<ReportWeatherPerHourCubit, ReportWeatherStates>(
          builder: (context, state) {
        if (state is ReportWeatherLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ReportWeatherErrorState) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else if (state is ReportWeatherSucessState) {
          return Container(
            height: context.screenHeight,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [ColorHelper.lightBlue, ColorHelper.blue],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.screenWidth / 30,
                vertical: context.screenHeight / 50,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: context.screenHeight / 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.push(const Home());
                        },
                        icon: Icon(Icons.arrow_back_ios_rounded,
                            color: ColorHelper.white),
                      ),
                      Text("back", style: TextStyleHelper.textStylefontSize24)
                    ],
                  ),
                  SizedBox(
                    height: context.screenHeight / 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(TextConstant.today,
                          style: TextStyleHelper.textStylefontSize24),
                      Text(state.hourList[0].time,
                          style: TextStyleHelper.textStylefontSize18),
                    ],
                  ),
                  SizedBox(
                    height: context.screenHeight / 20,
                  ),
                  SizedBox(
                    height: context.screenHeight / 4,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 24,
                      itemBuilder: (BuildContext context, int index) {
                        return WeatherForecastDetailsIn10DaysContainer(
                          temp: state.hourList[index].tempC.toInt(),
                          time: '$index:00',
                          weatherStateImagePath: state.hourList[index].icon,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: context.screenHeight / 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(TextConstant.nextForecast,
                          style: TextStyleHelper.textStylefontSize24),
                    ],
                  ),
                  SizedBox(
                    height: context.screenHeight / 50,
                  ),
                  BlocBuilder<ReportWeather10DaysCubit,
                      ReportWeather10DaysStates>(builder: (context, state) {
                    if (state is ReportWeatherLoading10DaysState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ReportWeatherError10DaysState) {
                      return Center(child: Text(state.errorMessage));
                    } else if (state is ReportWeatherSucess10DaysState) {
                      final forecastDays =
                          state.weatherModel.forecast.forecastDays;

                      return SizedBox(
                        height: context.screenHeight / 3,
                        child: Scrollbar(
                          controller: _scrollController,
                          thumbVisibility: true,
                          child: ForecastListView(
                              scrollController: _scrollController,
                              forecastDays: forecastDays),
                        ),
                      );
                    } else {
                      return const Text(TextConstant.nodatafound);
                    }
                  }),
                ],
              ),
            ),
          );
        } else {
          return const Text(TextConstant.nodatafound);
        }
      }),
    );
  }
}

class ForecastListView extends StatelessWidget {
  const ForecastListView({
    super.key,
    required ScrollController scrollController,
    required this.forecastDays,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<ForecastDay> forecastDays;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      itemCount: forecastDays.length,
      itemBuilder: (BuildContext context, int index) {
        log('${forecastDays.length}');
        final dayForecast = forecastDays[index];

        final date = DateTime.parse(dayForecast.date);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("${date.day}/${date.month}",
                style: TextStyleHelper.textStylefontSize18),
            Image.network(
              'http:${dayForecast.day.condition.icon}',
              height: context.screenHeight / 15,
              width: context.screenWidth / 12,
            ),
            Text("${dayForecast.day.maxtempC}°C",
                style: TextStyleHelper.textStylefontSize18),
          ],
        );
      },
    );
  }
}
