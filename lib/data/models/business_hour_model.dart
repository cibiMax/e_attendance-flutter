class BusinessHourModel {
  final String day;
  final String from; // e.g., "09:30 AM"
  final String to;   // e.g., "05:30 PM"

  const BusinessHourModel({
    required this.day,
    required this.from,
    required this.to,
  });

  Map<String, dynamic> toMap() => {
        'day': day,
        'from': from,
        'to': to,
      };

  factory BusinessHourModel.fromMap(Map<String, dynamic> map) {
    return BusinessHourModel(
      day: map['day'] ?? '',
      from: map['from'] ?? '',
      to: map['to'] ?? '',
    );
  }
}
