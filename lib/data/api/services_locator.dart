import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/data/api/weather_api_services.dart';
import 'package:weather_app/data/repository/current_weather_repo.dart';
import 'package:weather_app/data/repository/report_weather_per_hour.dart';

final getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => WeatherGetAPIServices(getIt()));
  getIt.registerLazySingleton(() => CurrentWeatherRepository(getIt()));
  getIt.registerLazySingleton(() => ReportWeatherForecastRepository(getIt()));
}
