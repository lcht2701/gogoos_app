// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppUser {
  final String username;
  final String name;
  final String email;
  final String profileImg;
  final String phoneNumber;
  AppUser({
    required this.username,
    required this.name,
    required this.email,
    required this.profileImg,
    required this.phoneNumber,
  });

  AppUser copyWith({
    String? username,
    String? name,
    String? email,
    String? profileImg,
    String? phoneNumber,
  }) {
    return AppUser(
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImg: profileImg ?? this.profileImg,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'name': name,
      'email': email,
      'profileImg': profileImg,
      'phoneNumber': phoneNumber,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      username: map['username'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profileImg: map['profileImg'] as String,
      phoneNumber: map['phoneNumber'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(username: $username, name: $name, email: $email, profileImg: $profileImg, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.name == name &&
        other.email == email &&
        other.profileImg == profileImg &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        name.hashCode ^
        email.hashCode ^
        profileImg.hashCode ^
        phoneNumber.hashCode;
  }
}