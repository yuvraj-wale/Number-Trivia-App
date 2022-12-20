// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/error/failiures.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/core/util/input_converter.dart';

import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivis.dart';

import '../../domain/usecases/get_concrete_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final getConcreteNumberTrivia GetConcreteNumberTrivia;
  final getRandomNumberTrivia GetRandomNumberTrivia;
  final inputConverter InputConverter;

  NumberTriviaBloc(
      {required getConcreteNumberTrivia concrete,
      required getRandomNumberTrivia random,
      required this.InputConverter})
      : GetConcreteNumberTrivia = concrete,
        GetRandomNumberTrivia = random,
        super(Empty());

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is getTriviaForConcreteNumber) {
      final inputEither =
          InputConverter.stringToUnsignedInteger(event.numberSting);

      yield* inputEither.fold((failure) async* {
        yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
      }, (integer) async* {
        yield Loading();
        final failiureOrTrivia = await GetConcreteNumberTrivia(
          Params(number: integer),
        );
        yield* _eitherLoadedOrErrorState(failiureOrTrivia);
      });
    } else if (event is getTrivaFromRandomNumber) {
      yield Loading();
      final failiureOrTrivia = await GetRandomNumberTrivia(NoParams());
      yield* _eitherLoadedOrErrorState(failiureOrTrivia);
    }
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
    Either<Failiure, NumberTrivia> failureOrTrivia,
  ) async* {
    yield failureOrTrivia.fold(
      (failure) => Error(message: _mapFailiureToMessage(failure)),
      (trivia) => Loaded(trivia: trivia),
    );
  }

  String _mapFailiureToMessage(Failiure failure) {
    switch (failure.runtimeType) {
      case ServerFailiure:
        return SERVER_FAILURE_MESSAGE;
      case CasheFailiure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'unexpecteed error';
    }
  }
}
