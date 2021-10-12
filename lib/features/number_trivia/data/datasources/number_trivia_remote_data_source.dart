import 'dart:convert';

import 'package:flutter_ayoub/core/error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({@required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async =>
     _getTriviaFromUrl('http://numberapi.com/$number');


  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async =>
     _getTriviaFromUrl('http://numberapi.com/random');
  

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'applicatiom/json'});
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
