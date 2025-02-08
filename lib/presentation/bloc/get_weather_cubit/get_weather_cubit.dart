import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/current_weather_repo.dart';
import 'package:weather_app/presentation/bloc/get_weather_cubit/get_weather_state.dart';

import '../../../data/models/weather_model.dart';

class WeatherCubit extends Cubit<GetWeatherStates> {
  final CurrentWeatherRepository currentWeatherRepository;

  WeatherCubit({required this.currentWeatherRepository})
      : super(WeatherInitialState());
  WeatherModel? weathermodel;
  Future<void> getWeather(String cityName) async {
    emit(WeatherLoadingState());
    try {
      final WeatherModel weatherModel =
          await currentWeatherRepository.getWeather(cityName);
      emit(WeatherSucessState(weatherModel: weatherModel));
    } catch (e) {
      emit(WeatherErrorState("Failed to fetch weather data :$e.toString()"));
    }
  }
}
