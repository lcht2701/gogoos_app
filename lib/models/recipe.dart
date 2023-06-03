// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:gogoos_app/models/user.dart';

import 'ingredient.dart';

class Recipe {
  String id;
  String name;
  String description;
  double rating;
  int cookingTime;
  int serving;
  String imgUrl;
  //sub-collection
  AppUser user;
  List<Ingredient> ingredients;
  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.rating,
    required this.cookingTime,
    required this.serving,
    required this.imgUrl,
    required this.user,
    required this.ingredients,
  });

  Recipe copyWith({
    String? id,
    String? name,
    String? description,
    double? rating,
    int? cookingTime,
    int? serving,
    String? imgUrl,
    AppUser? user,
    List<Ingredient>? ingredients,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      cookingTime: cookingTime ?? this.cookingTime,
      serving: serving ?? this.serving,
      imgUrl: imgUrl ?? this.imgUrl,
      user: user ?? this.user,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'rating': rating,
      'cookingTime': cookingTime,
      'serving': serving,
      'imgUrl': imgUrl,
      'user': user.toMap(),
      'ingredients': ingredients.map((x) => x.toMap()).toList(),
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      rating: map['rating'] as double,
      cookingTime: map['cookingTime'] as int,
      serving: map['serving'] as int,
      imgUrl: map['imgUrl'] as String,
      user: AppUser.fromMap(map['user'] as Map<String, dynamic>),
      ingredients: List<Ingredient>.from(
        (map['ingredients'] as List<int>).map<Ingredient>(
          (x) => Ingredient.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) =>
      Recipe.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Recipe(id: $id, name: $name, description: $description, rating: $rating, cookingTime: $cookingTime, serving: $serving, imgUrl: $imgUrl, user: $user, ingredients: $ingredients)';
  }

  @override
  bool operator ==(covariant Recipe other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.rating == rating &&
        other.cookingTime == cookingTime &&
        other.serving == serving &&
        other.imgUrl == imgUrl &&
        other.user == user &&
        listEquals(other.ingredients, ingredients);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        rating.hashCode ^
        cookingTime.hashCode ^
        serving.hashCode ^
        imgUrl.hashCode ^
        user.hashCode ^
        ingredients.hashCode;
  }
}
