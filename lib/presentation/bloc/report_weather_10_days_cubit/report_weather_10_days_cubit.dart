import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/report_weather_per_hour.dart';
import 'package:weather_app/presentation/bloc/report_weather_10_days_cubit/report_weather_10_days_state.dart';

import '../../../data/models/weather_model.dart';

class ReportWeather10DaysCubit extends Cubit<ReportWeather10DaysStates> {
  final ReportWeatherForecastRepository reportWeatherRepository;

  ReportWeather10DaysCubit({required this.reportWeatherRepository})
      : super(ReportWeatherInitial10DaysState());
  WeatherModel? weathermodel;

  Future<void> getReportWeather10Day(String cityName, int day) async {
    emit(ReportWeatherLoading10DaysState());
    try {
      final WeatherModel weatherModel =
          await reportWeatherRepository.getWeatherForecast(cityName, day);
      emit(ReportWeatherSucess10DaysState(weatherModel: weatherModel));
    } catch (e) {
      emit(ReportWeatherError10DaysState(
          "Failed to fetch weather data :$e.toString()"));
    }
  }
}
