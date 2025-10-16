
class ClockInOutModel {
  final String userKey;
  final String? department;
  final String? duration;
  final String? date;
  final String? key;
  final String? clockInTime;
  final String? clockOutTime;
  final String? clockInLocation;
  final String? clockOutLocation;
  final String? email;
  final String? status;

  const ClockInOutModel({
    required this.userKey,
    this.department,
    this.duration,
    this.date,
    this.key,
    this.clockInTime,
    this.clockOutTime,
    this.clockInLocation,
    this.clockOutLocation,
    this.email,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userKey': userKey,
      'duration': duration,
      'date': date,
      'key': key,
      'clockInTime': clockInTime,
      'clockOutTime': clockOutTime,
      'clockInLocation': clockInLocation,
      'clockOutLocation': clockOutLocation,
      'department': department,
      'email': email,
      'status': status,
    };
  }

  factory ClockInOutModel.fromMap(Map<String, dynamic> map) {
    return ClockInOutModel(
      userKey: map['userKey'] as String,
      duration: map['duration'] as String?,
      date: map['date'] as String?,
      key: map['key'] as String?,
      clockInTime: map['clockInTime'] as String?,
      clockOutTime: map['clockOutTime'] as String?,
      clockInLocation: map['clockInLocation'] as String?,
      clockOutLocation: map['clockOutLocation'] as String?,
      department: map['department'] as String?,
      email: map['email'] as String?,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }
}
