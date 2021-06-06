import 'dart:convert';
import 'package:flutter/material.dart';

class Review {
  String author_name;
  String profile_photo_url;
  double rating;
  String time;
  String text;
  Review({
    @required this.author_name,
    @required this.profile_photo_url,
    @required this.rating,
    @required this.time,
    @required this.text,
  });

  Map<String, dynamic> toMap() {
    return {
      'author_name': author_name,
      'profile_photo_url': profile_photo_url,
      'rating': rating,
      'time': time,
      'text': text,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      author_name: map['author_name'],
      profile_photo_url: map['profile_photo_url'],
      rating: map['rating'],
      time: map['time'],
      text: map['text'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));
}
