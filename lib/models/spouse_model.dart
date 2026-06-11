class SpouseModel {
  final String id;
  final String name;
  final String phone;
  final String relationship;

  const SpouseModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.relationship,
  });

  SpouseModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? relationship,
  }) {
    return SpouseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      relationship: relationship ?? this.relationship,
    );
  }
}