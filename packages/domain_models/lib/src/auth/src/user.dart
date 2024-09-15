import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final int countryCode;
  final String? image;
  final List<Company> companies;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.countryCode,
    this.image,
    required this.companies,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        countryCode,
        phone,
        image,
      ];

  User copyWith({
    int? id,
    String? name,
    String? email,
    int? countryCode,
    String? phone,
    String? image,
    List<Company>? companies,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      countryCode: countryCode ?? this.countryCode,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      companies: companies ?? this.companies,
    );
  }
}
