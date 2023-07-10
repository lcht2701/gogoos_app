// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:gogoos_app/models/role.dart';

class AppUser {
  final String id;
  final String username;
  final String name;
  final String email;
  final String profileImg;
  final String phoneNumber;
  final UserRole role;

  List<String>? myRecipes;
  List<String>? savedRecipes;

  AppUser({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.profileImg,
    required this.phoneNumber,
    required this.role,
    this.myRecipes,
    this.savedRecipes,
  });

  AppUser copyWith({
    String? id,
    String? username,
    String? name,
    String? email,
    String? profileImg,
    String? phoneNumber,
    UserRole? role,
    List<String>? myRecipes,
    List<String>? savedRecipes,
  }) {
    return AppUser(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImg: profileImg ?? this.profileImg,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      myRecipes: myRecipes ?? this.myRecipes,
      savedRecipes: savedRecipes ?? this.savedRecipes,
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
      'role': role.toString().split('.').last,
      'myRecipes': myRecipes,
      'savedRecipes': savedRecipes,
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
      myRecipes: map['myRecipes'] != null
          ? List<String>.from(map['myRecipes'] as List<String>)
          : null,
      savedRecipes: map['savedRecipes'] != null
          ? List<String>.from(map['savedRecipes'] as List<String>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(id: $id, username: $username, name: $name, email: $email, profileImg: $profileImg, phoneNumber: $phoneNumber, role: $role, myRecipes: $myRecipes, savedRecipes: $savedRecipes)';
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
        other.role == role &&
        listEquals(other.myRecipes, myRecipes) &&
        listEquals(other.savedRecipes, savedRecipes);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        name.hashCode ^
        email.hashCode ^
        profileImg.hashCode ^
        phoneNumber.hashCode ^
        role.hashCode ^
        myRecipes.hashCode ^
        savedRecipes.hashCode;
  }
}
