class Company {
  const Company({
    required this.id,
    required this.name,
    required this.sector,
    required this.isClosed,
    this.isSelected = false,
    this.profileImage,
    this.email,
  });

  final int id;
  final String name;
  final String sector;
  final bool isClosed;
  final bool isSelected;
  final String? profileImage;
  final String? email;

  Company copyWith({
    int? id,
    String? name,
    String? sector,
    bool? isClosed,
    bool? isSelected,
    String? profileImage,
    String? email,
  }) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      isClosed: isClosed ?? this.isClosed,
      sector: sector ?? this.sector,
      isSelected: isSelected ?? this.isSelected,
      profileImage: profileImage ?? this.profileImage,
      email: email ?? this.email,
    );
  }
}
