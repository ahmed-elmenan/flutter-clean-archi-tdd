import 'package:dartz/dartz.dart';
import 'package:flutter_ayoub/core/util/input_converter.dart';
import 'package:flutter_ayoub/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_ayoub/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_ayoub/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_ayoub/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockGetConCreteNumberTrivia extends Mock
    implements GetConCreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

main() {
  NumberTriviaBloc bloc;
  MockGetConCreteNumberTrivia mockGetConCreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConCreteNumberTrivia = MockGetConCreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
        concrete: mockGetConCreteNumberTrivia,
        random: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test('testState should be empty', () {
    // assert
    expect(bloc.state, equals(Empty()));
  });

  group('GetTriviaFroConcreteNumber', () {
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumbertivia = NumberTrivia(text: 'test trivia', number: 1);
    test(
        'should call the input converter to validate and converte the string to an insigned int',
        () async {
      //arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Right(tNumberParsed));

      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(
          mockInputConverter.stringToUnsignedInteger(tNumberString));

      //assert
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('should emit [Error] when the input is invalid', () async {
      //arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));

      //assert later
      final expected = [Empty(), Error(message: INVALID_INPUT_FAILURE_MESSAGE)];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));

      
    });
  });
}
