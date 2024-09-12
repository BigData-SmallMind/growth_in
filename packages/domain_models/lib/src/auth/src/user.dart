import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? image;
  final List<Company> companies;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.image,
    required this.companies,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        image,
      ];

  User copyWith ({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    List<Company>? companies,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      companies: companies ?? this.companies,
    );
  }

}
