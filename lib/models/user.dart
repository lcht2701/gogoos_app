import 'dart:convert';

import 'package:gogoos_app/models/role.dart';

class AppUser {
  final String id;
  final String username;
  final String name;
  final String email;
  final String profileImg;
  final String phoneNumber;
  final UserRole role;

  AppUser({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.profileImg,
    required this.phoneNumber,
    required this.role,
  });

  AppUser copyWith({
    String? id,
    String? username,
    String? name,
    String? email,
    String? profileImg,
    String? phoneNumber,
    UserRole? role,
  }) {
    return AppUser(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImg: profileImg ?? this.profileImg,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'profileImg': profileImg,
      'phoneNumber': phoneNumber,
      'role': role.toString().split('.').last, // Store role as string
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as String,
      username: map['username'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profileImg: map['profileImg'] as String,
      phoneNumber: map['phoneNumber'] as String,
      role: UserRole.values.firstWhere(
        (role) => role.toString().split('.').last == map['role'],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(id: $id, username: $username, name: $name, email: $email, profileImg: $profileImg, phoneNumber: $phoneNumber, role: $role)';
  }

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.name == name &&
        other.email == email &&
        other.profileImg == profileImg &&
        other.phoneNumber == phoneNumber &&
        other.role == role;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        name.hashCode ^
        email.hashCode ^
        profileImg.hashCode ^
        phoneNumber.hashCode ^
        role.hashCode;
  }
}
