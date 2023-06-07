// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Review {
  String id;
  String username;
  String review;
  Review({
    required this.id,
    required this.username,
    required this.review,
  });

  Review copyWith({
    String? id,
    String? username,
    String? review,
  }) {
    return Review(
      id: id ?? this.id,
      username: username ?? this.username,
      review: review ?? this.review,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'review': review,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as String,
      username: map['username'] as String,
      review: map['review'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Review(id: $id, username: $username, review: $review)';

  @override
  bool operator ==(covariant Review other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.review == review;
  }

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ review.hashCode;
}
