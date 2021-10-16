import 'package:dartz/dartz.dart';
import 'package:flutter_ayoub/core/error/failure.dart';
import 'package:flutter_ayoub/core/usecases/usecase.dart';
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

    void setUpInputConverterSuccess() {
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Right(tNumberParsed));
    }

    test(
        'should call the input converter to validate and converte the string to an insigned int',
        () async {
      //arrange
      setUpInputConverterSuccess();
      
      //** 
      when(mockGetConCreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumbertivia)); // added to avoid The method 'fold' was called on null error
      //** 
      
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
      final expected = [Error(message: INVALID_INPUT_FAILURE_MESSAGE)];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });

    test('should get data from the concrete use case', () async {
      //arrange
      setUpInputConverterSuccess();

      when(mockGetConCreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumbertivia));

      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockGetConCreteNumberTrivia(any));

      //assert
      verify(mockGetConCreteNumberTrivia(Params(number: tNumberParsed)));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully',
        () async {
      //arrange
      setUpInputConverterSuccess();

      when(mockGetConCreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumbertivia));
      //assert late
      final expected = [Loading(), Loaded(trivia: tNumbertivia)];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });

    test('should emit [Loading, Error] when getting data fails',
        () async {
      //arrange
      setUpInputConverterSuccess();

      when(mockGetConCreteNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert late
      final expected = [Loading(), Error(message: SERVER_FAILURE_MESSAGE)];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
   
    });
    test('should emit [Loading, Error] with q proper ,essqge for the fqilure zhen getting dqtq fqils',
        () async {
      //arrange
      setUpInputConverterSuccess();

      when(mockGetConCreteNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert late
      final expected = [Loading(), Error(message: CACHE_FAILURE_MESSAGE)];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });
  });
  
  group('GetTriviaForRandomNumber', () {
    final tNumbertivia = NumberTrivia(text: 'test trivia', number: 1);

    test('should get data from the Random use case', () async {
      //arrange
      

      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumbertivia));

      //act
      bloc.add(GetTriviaForRandomNumber());
      await untilCalled(mockGetRandomNumberTrivia(any));

      //assert
      verify(mockGetRandomNumberTrivia(NoParams()));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully',
        () async {
      //arrange
      

      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumbertivia));
      //assert late
      final expected = [Loading(), Loaded(trivia: tNumbertivia)];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(GetTriviaForRandomNumber());
    });

    test('should emit [Loading, Error] when getting data fails',
        () async {
      //arrange
      

      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert late
      final expected = [Loading(), Error(message: SERVER_FAILURE_MESSAGE)];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(GetTriviaForRandomNumber());
   
    });
    test('should emit [Loading, Error] with a proper message for the fqilure zhen getting dqtq fqils',
        () async {
      //arrange
      

      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert late
      final expected = [Loading(), Error(message: CACHE_FAILURE_MESSAGE)];
      expectLater(bloc.stream, emitsInOrder(expected));

      //act
      bloc.add(GetTriviaForRandomNumber());
    });
  });
}
