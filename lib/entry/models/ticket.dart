import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Ticket {
  @HiveField(0)
  final String ticketNumber;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  String status;

  @HiveField(4)
  final String userPhone; // The userId referencing the User table

  @HiveField(5)
  final DateTime createdTime;

  @HiveField(6)
  DateTime updatedTime;

  @HiveField(7)
  final double serviceEstimationPrice;

  @HiveField(8)
  final int serviceEstimationDays;

  @HiveField(7)
  final bool underWarranty;


  Ticket({
    required this.ticketNumber,
    required this.title,
    required this.description,
    required this.status,
    required this.userPhone,
    required this.createdTime,
    required this.updatedTime,
    required this.serviceEstimationPrice,
    required this.serviceEstimationDays,
    required this.underWarranty
  });
}

