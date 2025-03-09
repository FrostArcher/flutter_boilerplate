import 'package:flutter/material.dart';
import 'package:newappmytectra/utils/dbhelper.dart';
import 'package:newappmytectra/utils/session.dart';

Future<String> initAll() async {
  WidgetsFlutterBinding.ensureInitialized();
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