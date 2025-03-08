import 'package:flutter/material.dart';

class NavUtils {
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  // Pushes to the route specified
  static pushTo(context, String strPageName, {var arguments}) async {
    return await Navigator.pushNamed(context, strPageName, arguments: arguments);
  }

  static pushToParams(context, String strPageName, {var parameters}) async {
    return await Navigator.pushNamed(context, strPageName, arguments: parameters);
  }

  // Pop the top view
  static pop(context, {var result}) async {
    Navigator.pop(context, result);
  }

  // Pops to a particular view
  static popTo(context,String strPageName) {
    Navigator.popAndPushNamed(context, strPageName);
  }

  static pushReplace(context, String strPageName, {var arguments}) {
    Navigator.pushReplacementNamed (context,strPageName, arguments: arguments);
  }

  static pushPage(Widget page, context){
    Navigator.push(context, MaterialPageRoute(builder: (_)=> page));
  }
}