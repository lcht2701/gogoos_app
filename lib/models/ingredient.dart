// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'unit.dart';

class Ingredient {
  String id;
  String name;
  String imgUrl;
  double amount;
  Unit unit;
  Ingredient({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.amount,
    required this.unit,
  });

  Ingredient copyWith({
    String? id,
    String? name,
    String? imgUrl,
    double? amount,
    Unit? unit,
  }) {
    return Ingredient(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
      'amount': amount,
      'unit': unit.toMap(),
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'] as String,
      name: map['name'] as String,
      imgUrl: map['imgUrl'] as String,
      amount: map['amount'] as double,
      unit: Unit.fromMap(map['unit'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Ingredient.fromJson(String source) =>
      Ingredient.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Ingredient(id: $id, name: $name, imgUrl: $imgUrl, amount: $amount, unit: $unit)';
  }

  @override
  bool operator ==(covariant Ingredient other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.imgUrl == imgUrl &&
        other.amount == amount &&
        other.unit == unit;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imgUrl.hashCode ^
        amount.hashCode ^
        unit.hashCode;
  }
}
