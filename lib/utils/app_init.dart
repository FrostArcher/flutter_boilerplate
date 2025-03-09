import 'package:flutter/material.dart';
import 'package:newappmytectra/entry/domain/ticket_provider.dart';
import 'package:newappmytectra/entry/domain/user_provider.dart';
import 'package:newappmytectra/utils/dbhelper.dart';
import 'package:newappmytectra/utils/service_locator.dart';
import 'package:newappmytectra/utils/session.dart';

void setupDependencies() {
  serviceLocator.registerSingleton<TicketProvider>(TicketProvider());
  serviceLocator.registerLazySingleton<UserProvider>(() => UserProvider());
}

Future<String> initAll() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  try {
    await DBHelper.initDB();
    await DBHelper.init();
    print("Database initialized successfully");
  } catch (e) {
    print("Error initializing database: $e");
  }

  var pref;
  do {
    pref = await Session.init();
  } while (pref == null);
  return "/";
}