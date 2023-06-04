// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TutorialStep {
  String step;
  String description;
  TutorialStep({
    required this.step,
    required this.description,
  });

  TutorialStep copyWith({
    String? step,
    String? description,
  }) {
    return TutorialStep(
      step: step ?? this.step,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'step': step,
      'description': description,
    };
  }

  factory TutorialStep.fromMap(Map<String, dynamic> map) {
    return TutorialStep(
      step: map['step'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TutorialStep.fromJson(String source) =>
      TutorialStep.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TutorialStep(step: $step, description: $description)';

  @override
  bool operator ==(covariant TutorialStep other) {
    if (identical(this, other)) return true;

    return other.step == step && other.description == description;
  }

  @override
  int get hashCode => step.hashCode ^ description.hashCode;
}
