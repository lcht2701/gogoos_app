// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Ingredient {
  String name;
  double amount;
  String unit;
  Ingredient({
    required this.name,
    required this.amount,
    required this.unit,
  });

  Ingredient copyWith({
    String? name,
    double? amount,
    String? unit,
  }) {
    return Ingredient(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'amount': amount,
      'unit': unit,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      name: map['name'] as String,
      amount: map['amount'] as double,
      unit: map['unit'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ingredient.fromJson(String source) =>
      Ingredient.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Ingredient(name: $name, amount: $amount, unit: $unit)';

  @override
  bool operator ==(covariant Ingredient other) {
    if (identical(this, other)) return true;

    return other.name == name && other.amount == amount && other.unit == unit;
  }

  @override
  int get hashCode => name.hashCode ^ amount.hashCode ^ unit.hashCode;
}
