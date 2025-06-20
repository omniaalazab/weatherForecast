import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/notification_repo.dart';
import 'package:weather_app/extensions/media_query_values.dart';
import 'package:weather_app/extensions/navigation_extension.dart';
import 'package:weather_app/helper/color_helper.dart';
import 'package:weather_app/helper/text_style_helper.dart';
import 'package:weather_app/presentation/ui/screens/weather_forecast_report.dart';
import 'package:weather_app/presentation/ui/widgets/bottom_sheet_notification.dart';
import 'package:weather_app/presentation/ui/widgets/common_widget/custom_elelvated_button.dart';
import 'package:weather_app/presentation/ui/widgets/common_widget/custom_text_form_field.dart';
import 'package:weather_app/presentation/bloc/notification/notification_cubit.dart';

import '../../../core/text_constant.dart';
import '../../bloc/get_weather_cubit/get_weather_cubit.dart';
import '../../bloc/get_weather_cubit/get_weather_state.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textController = TextEditingController();
  late NotificationCubit _notificationCubit;

  @override
  void initState() {
    super.initState();

    _notificationCubit = NotificationCubit(NotificationRepository())
      ..initialize();

    context
        .read<WeatherCubit>()
        .getWeather(textController.text == "" ? "cairo" : textController.text);
  }

  @override
  void dispose() {
    _notificationCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: context.screenHeight,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [ColorHelper.lightBlue, ColorHelper.blue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.screenWidth / 100,
            vertical: context.screenHeight / 100,
          ),
          child: BuildUIContentColumn(textController: textController),
        ),
      ),
    );
  }
}

class BuildUIContentColumn extends StatelessWidget {
  const BuildUIContentColumn({
    super.key,
    required this.textController,
  });

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, GetWeatherStates>(
      builder: (context, state) {
        if (state is WeatherLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WeatherErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(state.errorMessage),
                SizedBox(height: 2),
                CustomElevatedButton(
                    widthButton: context.screenWidth / 2,
                    buttonText: "Try again",
                    onPressedFunction: () {
                      context.push(Home());
                    })
              ],
            ),
          );
        } else if (state is WeatherSucessState) {
          return Column(
            children: [
              SizedBox(
                height: context.screenHeight / 40,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      textHint: TextConstant.textHint,
                      textController: textController,
                      textFieldSuffix: IconButton(
                          icon: const Icon(
                            Icons.search_rounded,
                          ),
                          onPressed: () {
                            context
                                .read<WeatherCubit>()
                                .getWeather(textController.text);
                          }),
                      validatorFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return TextConstant.textFieldValidator;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: context.screenWidth / 100,
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_active_rounded),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => const BottomSheetNotification(),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: context.screenHeight / 100,
              ),
              WeatherIamgeRow(
                weatherImagePath: state.weatherModel.current.condition.icon,
              ),
              WeatherDetailContainer(
                location: state.weatherModel.location.name,
                date: state.weatherModel.forecast.forecastDays[0].date,
                temp: state.weatherModel.current.tempC,
                weatherState: state.weatherModel.current.condition.text,
                humidity: state.weatherModel.current.humidity,
                windKph: state.weatherModel.current.windKph,
              ),
              SizedBox(
                height: context.screenHeight / 20,
              ),
              CustomElevatedButton(
                buttonText: TextConstant.forecastReport,
                arrowIcon: const Icon(Icons.keyboard_arrow_up_rounded),
                onPressedFunction: () {
                  context.push(WeatherForecastReport(
                    cityName: textController.text == ""
                        ? "cairo"
                        : textController.text,
                  ));
                },
                widthButton: context.screenWidth / 2,
              ),
            ],
          );
        } else {
          return const Center(child: Text(TextConstant.noDataReturned));
        }
      },
    );
  }
}

class WeatherDetailContainer extends StatelessWidget {
  const WeatherDetailContainer({
    required this.location,
    required this.date,
    required this.temp,
    required this.weatherState,
    required this.humidity,
    required this.windKph,
    super.key,
  });
  final String date;
  final String location;
  final double temp;
  final String weatherState;
  final int humidity;
  final double windKph;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.screenHeight / 50),
      margin: EdgeInsets.all(context.screenHeight / 50),
      decoration: BoxDecoration(
        color: ColorHelper.cyan,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(" $location", style: TextStyleHelper.textStylefontSize18),
          Text("${TextConstant.today}, $date",
              style: TextStyleHelper.textStylefontSize18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$temp", style: TextStyleHelper.textStylefontSize100),
              Text("°", style: TextStyleHelper.textStylefontSize72),
            ],
          ),
          Text(weatherState,
              style: TextStyleHelper.textStylefontSize24
                  .copyWith(fontWeight: FontWeight.bold)),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          WindHumdRow(
            text: TextConstant.wind,
            value: "$windKph KM/H",
            icon: Icons.storm_outlined,
          ),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          WindHumdRow(
            text: TextConstant.humd,
            value: "$humidity %",
            icon: Icons.water_drop_outlined,
          ),
        ],
      ),
    );
  }
}

class WindHumdRow extends StatelessWidget {
  const WindHumdRow(
      {super.key, required this.text, required this.value, required this.icon});
  final String text;
  final String value;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: context.screenWidth / 10,
        ),
        Icon(
          icon,
          color: ColorHelper.white,
        ),
        text == TextConstant.humd
            ? SizedBox(
                width: context.screenWidth / 1000,
              )
            : SizedBox(
                width: context.screenWidth / 20,
              ),
        Text(text, style: TextStyleHelper.textStylefontSize18),
        text == TextConstant.humd
            ? SizedBox(
                width: context.screenWidth / 1000,
              )
            : SizedBox(
                width: context.screenWidth / 20,
              ),
        Text("|", style: TextStyleHelper.textStylefontSize18),
        SizedBox(
          width: context.screenWidth / 100,
        ),
        Text(value, style: TextStyleHelper.textStylefontSize18),
        SizedBox(
          width: context.screenWidth / 10,
        ),
      ],
    );
  }
}

class WeatherIamgeRow extends StatelessWidget {
  const WeatherIamgeRow({
    required this.weatherImagePath,
    super.key,
  });
  final String weatherImagePath;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          'http:$weatherImagePath',
          width: context.screenWidth / 4,
          height: context.screenHeight / 4,
        ),
      ],
    );
  }
}
