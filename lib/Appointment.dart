class Appointment {
  final String name;
  final String referenceNumber;
  final String category;
  final DateTime dateTime;
    String? location;
  final String email;
  final String phone;
  final String nationality;
  final String passportNumber;

  Appointment({
    required this.name,
    required this.referenceNumber,
    required this.category,
    required this.dateTime,
    required this.location,
    required this.email,
    required this.phone,
    required this.nationality,
    required this.passportNumber,
  });
}