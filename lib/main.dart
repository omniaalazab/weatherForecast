import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/current_weather_repo.dart';
import 'package:weather_app/data/repository/notification_repo.dart';
import 'package:weather_app/data/repository/report_weather_per_hour.dart';
import 'package:weather_app/firebase_options.dart';
import 'package:weather_app/presentation/bloc/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/presentation/bloc/notification/notification_cubit.dart';
import 'package:weather_app/presentation/bloc/report_weather_10_days_cubit/report_weather_10_days_cubit.dart';
import 'package:weather_app/presentation/bloc/report_weather_per_hour_cubit/report_weather_per_hour_cubit.dart';

import 'presentation/ui/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  getToken();
  runApp(const MyApp());
}

getToken() async {
  try {
    String? myToken = await FirebaseMessaging.instance.getToken();
    // String token = await Candidate().getToken();
    log("==================================");
    log('$myToken');
  } catch (e) {
    log(e.toString());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => WeatherCubit(
                  currentWeatherRepository: CurrentWeatherRepository())),
          BlocProvider(
            create: (context) => ReportWeatherPerHourCubit(
                reportWeatherRepository: ReportWeatherForecastRepository()),
          ),
          BlocProvider(
            create: (context) => ReportWeather10DaysCubit(
                reportWeatherRepository: ReportWeatherForecastRepository()),
          ),
          BlocProvider(
            create: (context) => NotificationCubit(NotificationRepository()),
          )
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Home(),
        ));
  }
}
