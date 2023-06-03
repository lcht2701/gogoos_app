// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Unit {
  String id;
  String name;
  Unit({
    required this.id,
    required this.name,
  });

  Unit copyWith({
    String? id,
    String? name,
  }) {
    return Unit(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Unit.fromJson(String source) =>
      Unit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Unit(id: $id, name: $name)';

  @override
  bool operator ==(covariant Unit other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
