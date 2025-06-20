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

    final result = await currentWeatherRepository.getWeather(cityName);

    result.fold(
      (failure) => emit(WeatherErrorState(errorMessage: failure.message)),
      (weather) => emit(WeatherSucessState(weatherModel: weather)),
    );
  }
}
