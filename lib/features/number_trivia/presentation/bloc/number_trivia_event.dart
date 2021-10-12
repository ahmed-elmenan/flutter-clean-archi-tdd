part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  List propreties = const <dynamic>[];
  NumberTriviaEvent([propreties]);

  @override
  List<Object> get props => propreties;
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String nmuberString;

  GetTriviaForConcreteNumber(this.nmuberString) : super([nmuberString]);
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {
  GetTriviaForRandomNumber();
}
