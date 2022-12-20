// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/failiures.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class getRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {

  final numberTriviaRepository repository;

  getRandomNumberTrivia(
    this.repository,
  );

  Future<Either<Failiure, NumberTrivia>> call(NoParams params) async {
    return repository.getRandomNumberTrivia();
  }
}
