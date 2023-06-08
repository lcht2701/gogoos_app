// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Tutorial {
  String id;
  String step;
  String description;
  String? recipeId;
  Tutorial({
    required this.id,
    required this.step,
    required this.description,
    this.recipeId,
  });

  Tutorial copyWith({
    String? id,
    String? step,
    String? description,
    String? recipeId,
  }) {
    return Tutorial(
      id: id ?? this.id,
      step: step ?? this.step,
      description: description ?? this.description,
      recipeId: recipeId ?? this.recipeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'step': step,
      'description': description,
      'recipeId': recipeId,
    };
  }

  factory Tutorial.fromMap(Map<String, dynamic> map) {
    return Tutorial(
      id: map['id'] as String,
      step: map['step'] as String,
      description: map['description'] as String,
      recipeId: map['recipeId'] != null ? map['recipeId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tutorial.fromJson(String source) =>
      Tutorial.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Tutorial(id: $id, step: $step, description: $description, recipeId: $recipeId)';
  }

  @override
  bool operator ==(covariant Tutorial other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.step == step &&
        other.description == description &&
        other.recipeId == recipeId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        step.hashCode ^
        description.hashCode ^
        recipeId.hashCode;
  }
}
