


class ClockInOutEntity {
  final String userKey;
  final String? duration;
  final String? date;
  final String? key;
  final String? clockInTime;
  final String? clockOutTime;
  final String? clockInLocation;
  final String? clockOutLocation;
  final String? email;

  ClockInOutEntity({
    required this.userKey,
    required this.duration,
    required this.date,
    required this.key,
    required this.clockInTime,
    required this.clockOutTime,
    required this.clockInLocation,
    required this.clockOutLocation,
    required this.email,
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
      'email': email,
    };
  }

  factory ClockInOutEntity.fromMap(Map<String, dynamic> map) {
    return ClockInOutEntity(
      userKey: map['userKey'] as String,
      duration: map['duration'] != null ? map['duration'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      key: map['key'] != null ? map['key'] as String : null,
      clockInTime: map['clockInTime'] != null ? map['clockInTime'] as String : null,
      clockOutTime: map['clockOutTime'] != null ? map['clockOutTime'] as String : null,
      clockInLocation: map['clockInLocation'] != null ? map['clockInLocation'] as String : null,
      clockOutLocation: map['clockOutLocation'] != null ? map['clockOutLocation'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  }
