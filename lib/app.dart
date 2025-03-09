import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newappmytectra/entry/presentation/homescreen.dart';
import 'package:newappmytectra/entry/presentation/splash.dart';
import 'package:newappmytectra/utils/app_settings.dart';
import 'package:newappmytectra/utils/app_styles.dart';
import 'package:newappmytectra/utils/extensions.dart';
import 'package:newappmytectra/utils/localizations.dart';
import 'package:newappmytectra/utils/navutils.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  final String? initialRoute;

  const LandingScreen({Key? key, this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: kSwatch[900],
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppSettings>(create: (_) => AppSettings()),
        // ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        // ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        // ChangeNotifierProvider<ConnectivityProvider>(create: (_) => ConnectivityProvider()),
        // ChangeNotifierProvider<ProductProvider>(create: (_) => ProductProvider()),
        // ChangeNotifierProvider<AddressProvider>(create: (_) => AddressProvider()),
        // ChangeNotifierProvider<OrderProvider>(create: (_) => OrderProvider()),
        // ChangeNotifierProvider<ProfileProvider>(create: (_) => ProfileProvider()),
        // ChangeNotifierProvider<NotificationProvider>(create: (_) => NotificationProvider()),
      ],
      child: Consumer<AppSettings>(
        builder: (_, AppSettings settings, __) {
          AppTheme appTheme = AppTheme(settings);
          return MaterialApp(
            theme: appTheme.theme,
            // darkTheme: appTheme.darkTheme,
            // themeMode: settings.themeMode,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('hi', 'IN'),
              Locale('kn', 'IN'),
            ],
            locale: settings.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
            ],
            navigatorKey: NavUtils.navKey,
            routes: {
              '/': (context) => const SplashScreen(),
              '/home': (context) => HomeScreen(),
            },
            debugShowCheckedModeBanner: false,
            initialRoute: "/",
            onGenerateTitle: (context) => "appName".tr(context),
          );
        },

      ),
    );
  }
}
