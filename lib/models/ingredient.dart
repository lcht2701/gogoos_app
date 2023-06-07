// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Ingredient {
  String id;
  String name;
  int amount;
  String unit;
  Ingredient({
    required this.id,
    required this.name,
    required this.amount,
    required this.unit,
  });

  Ingredient copyWith({
    String? id,
    String? name,
    int? amount,
    String? unit,
  }) {
    return Ingredient(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'amount': amount,
      'unit': unit,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'] as String,
      name: map['name'] as String,
      amount: map['amount'] as int,
      unit: map['unit'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ingredient.fromJson(String source) =>
      Ingredient.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Ingredient(id: $id, name: $name, amount: $amount, unit: $unit)';
  }

  @override
  bool operator ==(covariant Ingredient other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.amount == amount &&
        other.unit == unit;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ amount.hashCode ^ unit.hashCode;
  }
}
