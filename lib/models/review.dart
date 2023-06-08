// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Review {
  String id;
  String username;
  String review;
  String? recipeId;
  Review({
    required this.id,
    required this.username,
    required this.review,
    this.recipeId,
  });

  Review copyWith({
    String? id,
    String? username,
    String? review,
    String? recipeId,
  }) {
    return Review(
      id: id ?? this.id,
      username: username ?? this.username,
      review: review ?? this.review,
      recipeId: recipeId ?? this.recipeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'review': review,
      'recipeId': recipeId,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as String,
      username: map['username'] as String,
      review: map['review'] as String,
      recipeId: map['recipeId'] != null ? map['recipeId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Review(id: $id, username: $username, review: $review, recipeId: $recipeId)';
  }

  @override
  bool operator ==(covariant Review other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.review == review &&
        other.recipeId == recipeId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        review.hashCode ^
        recipeId.hashCode;
  }
}
