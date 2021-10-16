import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_ayoub/core/network/network_info.dart';
import 'package:flutter_ayoub/core/util/input_converter.dart';
import 'package:flutter_ayoub/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_ayoub/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_ayoub/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_ayoub/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_ayoub/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_ayoub/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(() =>
      NumberTriviaBloc(concrete: sl(), inputConverter: sl(), random: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetConCreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(() =>
      NumberTriviaRepositoryImpl(
          remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // Data
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());

}
