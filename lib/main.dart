import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Static/onboarding_screen.dart';
import 'package:provider/provider.dart';
// import 'package:uni_links/uni_links.dart';

import 'Provider/Account_Provider.dart';
import 'Provider/BuySellProvider.dart';
import 'Provider/DashboardProvider.dart';
import 'Provider/ExchangeProvider.dart';
import 'Provider/InternetProvider.dart';
import 'Provider/Token_Provider.dart';
import 'Provider/Transection_Provider.dart';

bool _initialUriIsHandled = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? _sub;
  void _handleIncomingLinks() {
    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      // _sub = uriLinkStream.listen((Uri? uri) {
      //   if (!mounted) return;
      //   // print('got uri: $uri');
      //   Utils.wcUrlVal = '$uri';
      // }, onError: (Object err) {
      //   // print("error----"+err.toString());
      // });
    }
  }

  Future<void> _handleInitialUri() async {
    // In this example app this is an almost useless guard, but it is here to
    // show we are not going to call getInitialUri multiple times, even if this
    // was a weidget that will be disposed of (ex. a navigation route change).
    // print("initial-------------"+_initialUriIsHandled.toString());
    if (!_initialUriIsHandled) {
      // _initialUriIsHandled = true;
      // final uri = await getInitialUri();
      // if (uri == null) {
      //   // print('no initial uri');
      // } else {
      //   // print('got initial uri: $uri');
      //   Utils.wcUrlVal = '$uri';
      // }
    }
  }

  @override
  void initState() {
    super.initState();

    _handleInitialUri();
    _handleIncomingLinks();
  }

  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
        ChangeNotifierProvider(create: (context) => AccountProvider()),
        ChangeNotifierProvider(create: (context) => InternetProvider()),
        ChangeNotifierProvider(create: (context) => TokenProvider()),
        ChangeNotifierProvider(create: (context) => TransectionProvider()),
        ChangeNotifierProvider(create: (context) => BuySellProvider()),
        ChangeNotifierProvider(create: (context) => ExchangeProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return ScreenUtilInit(
          useInheritedMediaQuery: true,
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'JostPayWallet',
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const OnboardingScreen(),
          ),
        );
      }),
    );
  }
}
