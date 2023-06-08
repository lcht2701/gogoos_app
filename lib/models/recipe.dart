// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'ingredient.dart';
import 'review.dart';
import 'tutorial.dart';

class Recipe {
  final String id;
  final String title;
  final String photoUrl;
  final int calories;
  final int time;
  final String description;

  List<Ingredient>? ingredients;
  List<Tutorial>? tutorials;
  List<Review>? reviews;

  //recipe define
  final bool isTopRecipe;

  Recipe({
    required this.id,
    required this.title,
    required this.photoUrl,
    required this.calories,
    required this.time,
    required this.description,
    this.ingredients,
    this.tutorials,
    this.reviews,
    required this.isTopRecipe,
  });

  Recipe copyWith({
    String? id,
    String? title,
    String? photoUrl,
    int? calories,
    int? time,
    String? description,
    List<Ingredient>? ingredients,
    List<Tutorial>? tutorials,
    List<Review>? reviews,
    bool? isTopRecipe,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      photoUrl: photoUrl ?? this.photoUrl,
      calories: calories ?? this.calories,
      time: time ?? this.time,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      tutorials: tutorials ?? this.tutorials,
      reviews: reviews ?? this.reviews,
      isTopRecipe: isTopRecipe ?? this.isTopRecipe,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'photoUrl': photoUrl,
      'calories': calories,
      'time': time,
      'description': description,
      'ingredients': ingredients?.map((x) => x.toMap()).toList(),
      'tutorials': tutorials?.map((x) => x.toMap()).toList(),
      'reviews': reviews?.map((x) => x.toMap()).toList(),
      'isTopRecipe': isTopRecipe,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as String,
      title: map['title'] as String,
      photoUrl: map['photoUrl'] as String,
      calories: map['calories'] as int,
      time: map['time'] as int,
      description: map['description'] as String,
      ingredients: map['ingredients'] != null
          ? List<Ingredient>.from(
              (map['ingredients'] as List<int>).map<Ingredient?>(
                (x) => Ingredient.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      tutorials: map['tutorials'] != null
          ? List<Tutorial>.from(
              (map['tutorials'] as List<int>).map<Tutorial?>(
                (x) => Tutorial.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      reviews: map['reviews'] != null
          ? List<Review>.from(
              (map['reviews'] as List<int>).map<Review?>(
                (x) => Review.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      isTopRecipe: map['isTopRecipe'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) =>
      Recipe.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Recipe(id: $id, title: $title, photoUrl: $photoUrl, calories: $calories, time: $time, description: $description, ingredients: $ingredients, tutorials: $tutorials, reviews: $reviews, isTopRecipe: $isTopRecipe)';
  }

  @override
  bool operator ==(covariant Recipe other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.photoUrl == photoUrl &&
        other.calories == calories &&
        other.time == time &&
        other.description == description &&
        listEquals(other.ingredients, ingredients) &&
        listEquals(other.tutorials, tutorials) &&
        listEquals(other.reviews, reviews) &&
        other.isTopRecipe == isTopRecipe;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        photoUrl.hashCode ^
        calories.hashCode ^
        time.hashCode ^
        description.hashCode ^
        ingredients.hashCode ^
        tutorials.hashCode ^
        reviews.hashCode ^
        isTopRecipe.hashCode;
  }

  // Method to fetch ingredients for a specific recipe ID
  List<Ingredient> getIngredientsForRecipeId(String recipeId) {
    return ingredients!
        .where((ingredient) => ingredient.recipeId == recipeId)
        .toList();
  }

  // Method to fetch tutorials for a specific recipe ID
  List<Tutorial> getTutorialsForRecipeId(String recipeId) {
    return tutorials!
        .where((tutorial) => tutorial.recipeId == recipeId)
        .toList();
  }

  // Method to fetch reviews for a specific recipe ID
  List<Review> getReviewsForRecipeId(String recipeId) {
    return reviews!.where((review) => review.recipeId == recipeId).toList();
  }
}
