class Trip {

  final int id;
  final String destination;
  final String startDate;
  final String endDate;
  final String activities;

  Trip({
    required this.id,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.activities,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {

    return Trip(
      id: json['id'],
      destination: json['destination'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      activities: json['activities'],
    );
  }
}