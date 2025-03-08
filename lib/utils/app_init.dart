import 'package:flutter/material.dart';
import 'package:newappmytectra/utils/session.dart';

Future<String> initAll() async {
  WidgetsFlutterBinding.ensureInitialized();

  var pref;
  do {
    pref = await Session.init();
  } while (pref == null);
  return "/";
}