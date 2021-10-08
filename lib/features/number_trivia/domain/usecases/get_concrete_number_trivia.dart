import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:meta/meta.dart';
import '../../../../core/error/failure.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetConCreteNumberTrivia implements UseCase<NumberTrivia, Params>{
  final NumberTriviaRepository repository;

  GetConCreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({this.number});

  @override
  List<Object> get props => [number];
}
