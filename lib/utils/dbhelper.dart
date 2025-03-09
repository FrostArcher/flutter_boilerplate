import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newappmytectra/entry/domain/ticket_adapter.dart';
import 'package:newappmytectra/entry/domain/user_adapter.dart';
import 'package:newappmytectra/entry/models/ticket.dart';
import 'package:newappmytectra/entry/models/user.dart';

class DBHelper {
  static Future<dynamic> initDB() async {
    await Hive.initFlutter();

    // Register Hive adapters (to store custom objects)
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(TicketAdapter());
  }

  static const String userBoxName = 'users';
  static const String ticketBoxName = 'tickets';
  static const String adminBoxName = 'admin';

  // Initialize Hive boxes
  static Future<void> init() async {
    await Hive.openBox<User>(userBoxName);
    await Hive.openBox<Ticket>(ticketBoxName);
    // await Hive.openBox<AdminModel>(adminBoxName);
    final user = User(
      name: 'John Doe',
      address: 'Purulia',
      phoneNumber: '1234567890',
    );
    addUser(user);
  }

  // Add a user
  static Future<void> addUser(User user) async {
    final box = Hive.box<User>(userBoxName);
    await box.put(user.phoneNumber, user);
    print(user.phoneNumber);
  }

  // Add a ticket
  static Future<void> addTicket(Ticket ticket) async {
    final box = Hive.box<Ticket>(ticketBoxName);
    await box.add(ticket);
  }

  // Get all tickets
  static List<Ticket> getTickets() {
    final box = Hive.box<Ticket>(ticketBoxName);
    return box.values.toList();
  }

  // Get all users
  static List<User> getUsers() {
    final box = Hive.box<User>(userBoxName);
    return box.values.toList();
  }

  // Update ticket status
  static Future<void> updateTicketStatus(int ticketKey, String status) async {
    final box = Hive.box<Ticket>(ticketBoxName);
    Ticket ticket = box.get(ticketKey)!;
    ticket.status = status;
    await box.put(ticketKey, ticket);
  }

  static Future<void> updateTicket(key, Ticket ticket) async {
    final box = Hive.box<Ticket>(ticketBoxName);
    await box.put(key, ticket);
  }

  static Future<void> updateUser(User user) async {
    final box = Hive.box<User>(userBoxName);
    await box.put(user.phoneNumber, user);
  }

  static bool checkIfUserPresent(String userPhone) {
    final box = Hive.box<User>(userBoxName);
    for(var element in box.values.toList()){
      if(element.phoneNumber == userPhone){
        return true;
      }
    }
    return false;
  }

  static bool checkIfPresent(String ticketNumber) {
    final box = Hive.box<Ticket>(ticketBoxName);
    for(var element in box.values.toList()){
      if(element.ticketNumber == ticketNumber){
        return true;
      }
    }
    return false;
  }


  static Future<void> clear() async{
    final ticketBox = Hive.box<Ticket>(ticketBoxName);
    final usersBox = Hive.box<Ticket>(userBoxName);
    await ticketBox.clear();
    await usersBox.clear();
  }
}