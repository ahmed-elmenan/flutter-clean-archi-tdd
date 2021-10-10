import 'dart:convert';

import 'package:flutter_ayoub/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:matcher/matcher.dart';
import 'package:flutter_ayoub/core/error/exceptions.dart';
import 'package:flutter_ayoub/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

main() {
  NumberTriviaRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('''should perform a get request on a URL with number
        being on the endpoint and with application/json header''', () async {
      //arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
      //act
      dataSource.getConcreteNumberTrivia(tNumber);

      //assert
      verify(mockHttpClient.get(Uri.parse('http://numberapi.com/$tNumber'),
          headers: {'Content-Type': 'applicatiom/json'}));
    });

    test('should retrin NumberTrivia when the response code is 200 (success)',
        () async {
      //arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));

      //act
      final result = await dataSource.getConcreteNumberTrivia(tNumber);

      //assert
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a server exception when the response are 404 or other',
        () async {
      //arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));
      
      //act
      final call = dataSource.getConcreteNumberTrivia;

      //assert
      expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
