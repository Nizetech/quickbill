class RentalData {
  final String time, total, carType, image;
  final int rentType;
  final DateTime date;

  RentalData(
      {required this.date,
      required this.time,
      required this.total,
      required this.carType,
      required this.image,
      required this.rentType});
}
