class ChildModel {
  final String id;
  final String fullName;
  final String schoolName;
  final String grade;
  final String relationship;
  final String? photoPath;

  const ChildModel({
    required this.id,
    required this.fullName,
    required this.schoolName,
    required this.grade,
    required this.relationship,
    this.photoPath,
  });


  ChildModel copyWith({
    String? fullName,
    String? schoolName,
    String? grade,
    String? relationship,
    String? photoPath,
  }) {
    return ChildModel(
      id: id,
      fullName: fullName ?? this.fullName,
      schoolName: schoolName ?? this.schoolName,
      grade: grade ?? this.grade,
      relationship: relationship ?? this.relationship,
      photoPath: photoPath ?? this.photoPath,
    );
  }
}