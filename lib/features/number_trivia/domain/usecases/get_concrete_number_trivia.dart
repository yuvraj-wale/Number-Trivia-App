import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/error/failiures.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class getConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final numberTriviaRepository repository;

  getConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failiure, NumberTrivia>> call(Params params) async {
    return repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({required this.number});

  @override
  // TODO: implement props
  List<Object> get props => [number];
}
