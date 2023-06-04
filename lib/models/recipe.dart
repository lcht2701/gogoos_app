// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'ingredient.dart';
import 'review.dart';
import 'tutorial_step.dart';

class Recipe {
  String title;
  String photo;
  String calories;
  String time;
  String description;

  List<Ingredient> ingredients;
  List<TutorialStep> tutorial;
  List<Review> reviews;
  Recipe({
    required this.title,
    required this.photo,
    required this.calories,
    required this.time,
    required this.description,
    required this.ingredients,
    required this.tutorial,
    required this.reviews,
  });

  Recipe copyWith({
    String? title,
    String? photo,
    String? calories,
    String? time,
    String? description,
    List<Ingredient>? ingredients,
    List<TutorialStep>? tutorial,
    List<Review>? reviews,
  }) {
    return Recipe(
      title: title ?? this.title,
      photo: photo ?? this.photo,
      calories: calories ?? this.calories,
      time: time ?? this.time,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      tutorial: tutorial ?? this.tutorial,
      reviews: reviews ?? this.reviews,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'photo': photo,
      'calories': calories,
      'time': time,
      'description': description,
      'ingredients': ingredients.map((x) => x.toMap()).toList(),
      'tutorial': tutorial.map((x) => x.toMap()).toList(),
      'reviews': reviews.map((x) => x.toMap()).toList(),
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      title: map['title'] as String,
      photo: map['photo'] as String,
      calories: map['calories'] as String,
      time: map['time'] as String,
      description: map['description'] as String,
      ingredients: List<Ingredient>.from(
        (map['ingredients'] as List<int>).map<Ingredient>(
          (x) => Ingredient.fromMap(x as Map<String, dynamic>),
        ),
      ),
      tutorial: List<TutorialStep>.from(
        (map['tutorial'] as List<int>).map<TutorialStep>(
          (x) => TutorialStep.fromMap(x as Map<String, dynamic>),
        ),
      ),
      reviews: List<Review>.from(
        (map['reviews'] as List<int>).map<Review>(
          (x) => Review.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) =>
      Recipe.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Recipe(title: $title, photo: $photo, calories: $calories, time: $time, description: $description, ingredients: $ingredients, tutorial: $tutorial, reviews: $reviews)';
  }

  @override
  bool operator ==(covariant Recipe other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.photo == photo &&
        other.calories == calories &&
        other.time == time &&
        other.description == description &&
        listEquals(other.ingredients, ingredients) &&
        listEquals(other.tutorial, tutorial) &&
        listEquals(other.reviews, reviews);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        photo.hashCode ^
        calories.hashCode ^
        time.hashCode ^
        description.hashCode ^
        ingredients.hashCode ^
        tutorial.hashCode ^
        reviews.hashCode;
  }
}
