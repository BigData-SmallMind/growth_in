class Company {
  const Company({
    required this.id,
    required this.name,
    required this.sector,
    this.isSelected = false,
    this.profileImage,
    this.email,
  });

  final int id;
  final String name;
  final String sector;
  final bool isSelected;
  final String? profileImage;
  final String? email;

  Company copyWith({
    int? id,
    String? name,
    String? sector,
    bool? isSelected,
    String? profileImage,
    String? email,
  }) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      sector: sector ?? this.sector,
      isSelected: isSelected ?? this.isSelected,
      profileImage: profileImage ?? this.profileImage,
      email: email ?? this.email,
    );
  }
}
