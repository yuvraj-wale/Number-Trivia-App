// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class messageDisplay extends StatelessWidget {
  final String message;

  const messageDisplay({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
   Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: const TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
