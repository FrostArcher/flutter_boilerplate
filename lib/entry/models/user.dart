import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class User {

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String address;

  @HiveField(2)
  final String phoneNumber; // Unique phone number

  User({
    required this.name,
    required this.address,
    required this.phoneNumber,
  });
}