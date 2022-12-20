import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'dart:convert';

class NumberTriviaModel extends NumberTrivia {
  final String text;
  final int number;

  NumberTriviaModel({
    required this.text,
    required this.number,
  }) : super(text: text, number: number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(text: json['text'], number: (json['number']as num).toInt());
  }

  Map<String,dynamic>toJson() => {
    'text': text,
    'number': number,
  };
}
