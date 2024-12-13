import 'package:flutter/foundation.dart';

class QuizSubject{
  final String name;
  final String imageUrl;
  final List<String> topics;

  const QuizSubject({
    required this.name,
    required this.imageUrl,
    required this.topics
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is QuizSubject &&
              name == other.name &&
              imageUrl == other.imageUrl &&
              listEquals(topics, other.topics)
  ;

  @override
  int get hashCode => 0;
}