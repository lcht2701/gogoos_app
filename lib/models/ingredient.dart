// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Ingredient {
  String id;
  String name;
  String? amount;
  String? unit;
  String? recipeId;
  Ingredient({
    required this.id,
    required this.name,
    this.amount,
    this.unit,
    this.recipeId,
  });

  Ingredient copyWith({
    String? id,
    String? name,
    String? amount,
    String? unit,
    String? recipeId,
  }) {
    return Ingredient(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      recipeId: recipeId ?? this.recipeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'amount': amount,
      'unit': unit,
      'recipeId': recipeId,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'] as String,
      name: map['name'] as String,
      amount: map['amount'] != null ? map['amount'] as String : null,
      unit: map['unit'] != null ? map['unit'] as String : null,
      recipeId: map['recipeId'] != null ? map['recipeId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ingredient.fromJson(String source) =>
      Ingredient.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Ingredient(id: $id, name: $name, amount: $amount, unit: $unit, recipeId: $recipeId)';
  }

  @override
  bool operator ==(covariant Ingredient other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.amount == amount &&
        other.unit == unit &&
        other.recipeId == recipeId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        amount.hashCode ^
        unit.hashCode ^
        recipeId.hashCode;
  }
}
