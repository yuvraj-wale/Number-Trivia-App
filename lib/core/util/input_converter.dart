import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/failiures.dart';
import 'package:number_trivia/core/error/failiures.dart';

import '../error/failiures.dart';

class inputConverter {
  Either<Failiure, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailiure());
    }
  }
}

class InvalidInputFailiure extends Failiure {}

