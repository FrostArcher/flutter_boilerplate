import 'package:newappmytectra/utils/models/geo.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*Supported theme modes [0=> System default, 1=> Light, 2=> Dark]*/
const _THEME_MODE = 1;

/*Color code int value (decimal)*/
const _COLOR_SCHEME = 0;

/*Card corner radius*/
const _CORNER_RADIUS = 5.0;

/*Supported fonts [Fira Mono, Arquiecta, Sweet Sans, Josefin Sans, Baloo, Hind, Laila, null=> System default]*/
const _FONT_NAME = "Fira Sans";

/*Supported font scale factors [0.8=> Tiny, 0.9=> Small, 1.0=> Normal, 1.1=> Large, 1.2=> Huge]*/
const _FONT_SIZE = 1.0;

/*Supported languages [en=> English, hi=> हिन्दी (Hindi), kn=> ಕನ್ನಡ (Kannada), null=> System default]*/
const _LANGUAGE = null;

class Session {
  static late SharedPreferences _pref;

  static Future<SharedPreferences> init() async {
    var value = await SharedPreferences.getInstance();
    _pref = value;
    return _pref;
  }

  //App Settings
  static int get themeMode => _pref.getInt("app_ThemeMode") ?? _THEME_MODE;

  static int get colorScheme {
    var value = _pref.getInt("app_ColorScheme");
    if (value == null || value > 5) return _COLOR_SCHEME;
    return value;
  }

  static double get cornerRadius => _pref.getDouble("app_CornerRadius") ?? _CORNER_RADIUS;

  static String? get fontName => _pref.getString("app_FontName") ?? _FONT_NAME;

  static double get fontSize => _pref.getDouble("app_FontSize") ?? _FONT_SIZE;

  static String? get language => _pref.getString("app_Language") ?? _LANGUAGE;

  static set themeMode(int value) {
    _pref.setInt("app_ThemeMode", value);
  }

  static set colorScheme(int value) {
    _pref.setInt("app_ColorScheme", value);
  }

  static set cornerRadius(double value) {
    _pref.setDouble("app_CornerRadius", value);
  }

  static set fontName(String? value) {
    if (value == null) {
      _pref.remove("app_FontName");
      return;
    }
    _pref.setString("app_FontName", value);
  }

  static set fontSize(double value) {
    _pref.setDouble("app_FontSize", value);
  }

  static set language(String? value) {
    if (value == null) {
      _pref.remove("app_Language");
      return;
    }
    _pref.setString("app_Language", value);
  }

  //Authentication & Session
  static String? get token => _pref.getString("token");

  static String? get fcmToken => _pref.getString("fcmToken");

  static bool get isLoggedIn => token != null;

  static SessionUser get sessionUser => SessionUser(
    name: _pref.getString("profile_name"),
    username: _pref.getString("profile_username"),
    mobile: _pref.getString("profile_mobile"),
    totalRewards: num.parse((_pref.getInt("profile_total_rewards") ?? 0).toString()),
    email: _pref.getString("profile_email"),
  );

  static set token(String? token) {
    if (token == null) {
      _pref.remove("token");
      return;
    }
    _pref.setString('token', token);
  }

  static set fcmToken(String? token) {
    if (token == null) {
      _pref.remove("fcmToken");
      return;
    }
    _pref.setString('fcmToken', token);
  }

  static set userAddress(String? address) {
    if (address == null) {
      _pref.remove("userAddress");
      return;
    }
    _pref.setString("userAddress", address);
  }

  static String? get userAddress => _pref.getString("userAddress");

  static set sessionUser(SessionUser? user) {
    if (user == null) {
      _pref.remove("profile_name");
      _pref.remove("profile_username");
      return;
    }
    _pref.setString("profile_name", user.name ?? "");
    _pref.setString("profile_username", user.username ?? "");
    _pref.setString("profile_email", user.email ?? "");
    _pref.setString("profile_mobile", user.mobile ?? "");
    _pref.setInt("profile_total_rewards", (user.totalRewards ?? 0).toInt());
  }

  static logout() {
    token = null;
    sessionUser = null;
    fcmToken = null;
  }



  static set location(SessionLocation? latLong) {
    if (latLong?.lat == null || latLong?.long == null) {
      _pref.remove("lat");
      _pref.remove("long");
      return;
    }
    _pref.setDouble("lat", latLong!.lat!);
    _pref.setDouble("long", latLong.long!);
    if (latLong.title != null) _pref.setString("place_title", latLong.title!);
    if (latLong.address != null) _pref.setString("place_address", latLong.address!);
  }

  static SessionLocation? get location {
    var lat = _pref.getDouble("lat");
    var long = _pref.getDouble("long");
    var title = _pref.getString("place_title");
    var address = _pref.getString("place_address");
    if (lat == null || long == null) return null;
    return SessionLocation(lat, long, title: title, address: address);
  }
}

class SessionUser {
  final String? name;
  final String? username;
  final String? email;
  final String? mobile;
  final String? userName;
  final num? totalRewards;

  String get displayName {
    if (name == null) return "";
    var names = name?.split(" ") ?? [];
    if (names.length > 1) return names[0];
    return name ?? "";
  }

  SessionUser({this.email, this.mobile, this.userName, this.totalRewards, this.name, this.username});

  static SessionUser? fromJson(str) {
    if (str == null) return null;
    return SessionUser(
        name: str["first_name"] == "User" ? "" : "${str["first_name"]} ${str["last_name"]}",
        username: str["username"],
        email: str["email"] ?? "",
        mobile: str["mobile"] ?? "",
        totalRewards: str["total_rewards"] ?? 0);
  }
}

class SessionLocation {
  final String? title;
  final String? address;
  final double? lat;
  final double? long;

  SessionLocation(this.lat, this.long, {this.title, this.address});

  static SessionLocation? fromGeo(Geo? geo) {
    if (geo == null) return null;
    return SessionLocation(
      geo.latitude.toDouble(),
      geo.longitude.toDouble(),
    );
  }

  static SessionLocation? fromMap(Map? str) {
    if (str == null) return null;
    return SessionLocation(
      str["lat"],
      str["long"],
      title: str["title"],
      address: str["address"],
    );
  }
}
