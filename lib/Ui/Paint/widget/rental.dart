class RentalData {
  final String time, total, carType, image;
  final int rentType;
  final num price15;
  final DateTime date;

  RentalData(
      {required this.date,
      required this.time,
      required this.total,
      required this.price15,
      required this.carType,
      required this.image,
      required this.rentType});
}
