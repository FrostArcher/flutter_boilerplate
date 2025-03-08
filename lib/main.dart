import 'package:flutter/material.dart';
import 'package:newappmytectra/app.dart';
import 'package:newappmytectra/utils/app_init.dart';

void main() async{
  await initAll();
  runApp(const LandingScreen());
}
