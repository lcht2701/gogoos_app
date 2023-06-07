// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Tutorial {
  String id;
  String step;
  String description;
  Tutorial({
    required this.id,
    required this.step,
    required this.description,
  });

  Tutorial copyWith({
    String? id,
    String? step,
    String? description,
  }) {
    return Tutorial(
      id: id ?? this.id,
      step: step ?? this.step,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'step': step,
      'description': description,
    };
  }

  factory Tutorial.fromMap(Map<String, dynamic> map) {
    return Tutorial(
      id: map['id'] as String,
      step: map['step'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tutorial.fromJson(String source) =>
      Tutorial.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Tutorial(id: $id, step: $step, description: $description)';

  @override
  bool operator ==(covariant Tutorial other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.step == step &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ step.hashCode ^ description.hashCode;
}
