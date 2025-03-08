import 'package:flutter/material.dart';
import 'package:newappmytectra/utils/navutils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await Future.delayed(Duration(seconds: 1));
      NavUtils.pushTo(context, '/home');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Center(child: Text("Splash Screen",style: theme.textTheme.titleSmall,),)
    );
  }
}
