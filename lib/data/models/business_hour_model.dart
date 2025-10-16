
class BusinessHourModel {
  BusinessHourModel({
    required this.fromTime,
    required this.fromHrs,
    required this.fromMin,
    required this.toHrs,
    required this.toMin,
    required this.day,
  });

  final String fromTime;
  final int fromHrs;
  final int fromMin;
  final int toHrs;
  final int toMin;
  final String day;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fromTime': fromTime,
      'fromHrs': fromHrs,
      'fromMin': fromMin,
      'toHrs': toHrs,
      'toMin': toMin,
      'day': day,
    };
  }

  factory BusinessHourModel.fromMap(Map<String, dynamic> map) {
    return BusinessHourModel(
      fromTime: map['fromTime'] as String,
      fromHrs: map['fromHrs'] as int,
      fromMin: map['fromMin'] as int,
      toHrs: map['toHrs'] as int,
      toMin: map['toMin'] as int,
      day: map['day'] as String,
    );
  }
}
