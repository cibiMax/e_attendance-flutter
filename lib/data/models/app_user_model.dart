class AppUserModel {
  AppUserModel({
    required this.email,
    this.userKey,
    this.departmentKey,
    this.role,
  });

  final String email;
  final String? userKey;
  final String? departmentKey;
  final String? role;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'userKey': userKey,
      'departmentKey': departmentKey,
      'role': role,
    };
  }

  factory AppUserModel.fromMap(Map<String, dynamic> map) {
    return AppUserModel(
      email: map['email'] as String,
      userKey: map['userKey'] as String?,
      departmentKey: map['departmentKey'] as String?,
      role: map['role'] as String?,
    );
  }
}
