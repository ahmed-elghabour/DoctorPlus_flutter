class DoctorWorkingHours {
  late List<String> days;
  late List<String> endTimes;
  late List<String> startTimes;

  DoctorWorkingHours({
    required this.days,
    required this.endTimes,
    required this.startTimes,
  });

  factory DoctorWorkingHours.fromJson(Map<String, dynamic> json) {
    return DoctorWorkingHours(
      days: List<String>.from(json['days']),
      endTimes: List<String>.from(json['endTimes']),
      startTimes: List<String>.from(json['startTimes']),
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
