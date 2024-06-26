class DoctorWorkingHours {
  late List<String> days;
  late String endTimes, startTimes;

  DoctorWorkingHours({
    required this.days,
    required this.endTimes,
    required this.startTimes,
  });

  factory DoctorWorkingHours.fromJson(Map<String, dynamic> json) {
    return DoctorWorkingHours(
      endTimes: json['endTimes'],
      startTimes: json['startTimes'],
      days: List<String>.from(json['days']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'days': days,
      'endTimes': endTimes,
      'startTimes': startTimes,
    };
  }
}
