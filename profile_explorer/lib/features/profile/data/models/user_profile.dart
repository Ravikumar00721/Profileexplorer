import 'package:flutter/foundation.dart';

@immutable
class UserProfile {
  final String id;        // login.uuid
  final String firstName; // name.first
  final String city;      // location.city
  final int age;          // dob.age
  final String imageUrl;  // picture.large

  const UserProfile({
    required this.id,
    required this.firstName,
    required this.city,
    required this.age,
    required this.imageUrl,
  });

  /// CopyWith (hand-written)
  UserProfile copyWith({
    String? id,
    String? firstName,
    String? city,
    int? age,
    String? imageUrl,
  }) {
    return UserProfile(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      city: city ?? this.city,
      age: age ?? this.age,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  /// JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      city: json['city'] as String,
      age: (json['age'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'city': city,
    'age': age,
    'imageUrl': imageUrl,
  };

  /// Mapper from RandomUser raw JSON (kept from your version)
  factory UserProfile.fromRandomUser(Map<String, dynamic> json) {
    return UserProfile(
      id: json['login']?['uuid'] as String,
      firstName: json['name']?['first'] as String,
      city: json['location']?['city'] as String,
      age: (json['dob']?['age'] as num).toInt(),
      imageUrl: json['picture']?['large'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UserProfile &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              firstName == other.firstName &&
              city == other.city &&
              age == other.age &&
              imageUrl == other.imageUrl;

  @override
  int get hashCode =>
      id.hashCode ^ firstName.hashCode ^ city.hashCode ^ age.hashCode ^ imageUrl.hashCode;

  @override
  String toString() =>
      'UserProfile(id: $id, firstName: $firstName, city: $city, age: $age, imageUrl: $imageUrl)';
}
