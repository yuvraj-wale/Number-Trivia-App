import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/failiures.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

abstract class numberTriviaRepository {
  Future<Either<Failiure,NumberTrivia>> getRandomNumberTrivia();
  Future<Either<Failiure,NumberTrivia>> getConcreteNumberTrivia(int n);
}
