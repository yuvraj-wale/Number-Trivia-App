import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:number_trivia/core/error/exceptions.dart';

import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.

  Future<NumberTriviaModel> getRandomNumberTrivia();

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.

  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl(this.client);

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      // TODO: implement getConcreteNumberTrivia
      _getTriviaFromUrl('http://numbersapi.com/$number');

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      // TODO: implement getRandomNumberTrivia
      _getTriviaFromUrl('http://numbersapi.com/random');

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final httpUrl = Uri.parse(url);
    final Response = await client.get(
      httpUrl,
      headers: {'Content-Type': 'application/json'},
    );

    if (Response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(Response.body));
    } else {
      throw ServerException();
    }
  }
}
