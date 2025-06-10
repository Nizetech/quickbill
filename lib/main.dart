import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/Provider/auth_provider.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Authentication/SignInScreen.dart';
import 'package:jost_pay_wallet/Ui/Static/onboarding_screen.dart';
import 'package:jost_pay_wallet/bottom_nav.dart';
import 'package:jost_pay_wallet/constants/constants.dart';
import 'package:provider/provider.dart';
// import 'package:uni_links/uni_links.dart';

import 'Provider/account_provider.dart';
import 'Provider/DashboardProvider.dart';
import 'Provider/InternetProvider.dart';

// bool _initialUriIsHandled = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  // await InAppWebViewController.setWebContentsDebuggingEnabled(true);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Hive.initFlutter();
  await Hive.openBox(kAppName);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // StreamSubscription? _sub;
  // void _handleIncomingLinks() {
  //   if (!kIsWeb) {
  //     // It will handle app links while the app is already started - be it in
  //     // the foreground or in the background.
  //     // _sub = uriLinkStream.listen((Uri? uri) {
  //     //   if (!mounted) return;
  //     //   // print('got uri: $uri');
  //     //   Utils.wcUrlVal = '$uri';
  //     // }, onError: (Object err) {
  //     //   // print("error----"+err.toString());
  //     // });
  //   }
  // }

  // Future<void> _handleInitialUri() async {
  //   // In this example app this is an almost useless guard, but it is here to
  //   // show we are not going to call getInitialUri multiple times, even if this
  //   // was a weidget that will be disposed of (ex. a navigation route change).
  //   // print("initial-------------"+_initialUriIsHandled.toString());
  //   if (!_initialUriIsHandled) {
  //     // _initialUriIsHandled = true;
  //     // final uri = await getInitialUri();
  //     // if (uri == null) {
  //     //   // print('no initial uri');
  //     // } else {
  //     //   // print('got initial uri: $uri');
  //     //   Utils.wcUrlVal = '$uri';
  //     // }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    getToken();
    // _handleInitialUri();
    // _handleIncomingLinks();
  }

  final box = Hive.box(kAppName);

  String token = '';
  bool isExistingUser = false;

  FutureOr getToken() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      token = await box.get(kAccessToken, defaultValue: '');
      isExistingUser = await box.get(kExistingUser, defaultValue: false);
      log(token);
      setState(() {});
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // log('My token is $token');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
        ChangeNotifierProvider(create: (context) => AccountProvider()),
        ChangeNotifierProvider(create: (context) => InternetProvider()),
        ChangeNotifierProvider(create: (context) => ServiceProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return ScreenUtilInit(
          useInheritedMediaQuery: true,
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'JostPayWallet',
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            home:
                token.isNotEmpty
                ? const BottomNav()
                : isExistingUser
                    ? SignInScreen()
                    : const OnboardingScreen(),
          ),
        );
      }),
    );
  }
}
