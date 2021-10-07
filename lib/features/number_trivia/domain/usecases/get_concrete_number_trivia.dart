import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:flutter_ayoub/core/error/failure.dart';
import 'package:flutter_ayoub/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_ayoub/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConCreteNumberTrivia {
  final NumberTriviaRepository repository;

  GetConCreteNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> execute({@required int number}) async {
    return await repository.getConcreteNumberTrivia(number);
  }
}
