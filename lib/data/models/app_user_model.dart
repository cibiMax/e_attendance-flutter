class AppUserModel {
  AppUserModel({
    required this.email,
    this.userKey,
    this.department,
    this.role,
  });

  final String email;
  final String? userKey;
  final String? department;
  final String? role;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'userKey': userKey,
      'department': department,
      'role': role,
    };
  }

  factory AppUserModel.fromMap(Map<String, dynamic> map) {
    return AppUserModel(
      email: map['email'] as String,
      userKey: map['userKey'] as String?,
      department: map['department'] as String?,
      role: map['role'] as String?,
    );
  }
}
