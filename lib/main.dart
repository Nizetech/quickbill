import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/Provider/auth_provider.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/common/splash.dart';
import 'package:jost_pay_wallet/constants/constants.dart';
import 'package:jost_pay_wallet/utils/keep_alive_state.dart';
import 'package:provider/provider.dart';
import 'Provider/account_provider.dart';
import 'Provider/DashboardProvider.dart';
import 'Provider/InternetProvider.dart';
/// Getting available cameras for testing.
@visibleForTesting
List<CameraDescription> get cameras => _cameras;
List<CameraDescription> _cameras = <CameraDescription>[];
void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();
  } on CameraException catch (e) {
    print(e.code);
    print(e.description);
  }
  await ScreenUtil.ensureScreenSize();
  startKeepAlive();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Hive.initFlutter();
  await Hive.openBox(kAppName);
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {


  @override
  void initState() {
    super.initState();
    getToken();
    WidgetsBinding.instance.addObserver(this);

  }

  final box = Hive.box(kAppName);
  String token = '';
  String pinEnabled = '';
  bool isExistingUser = false;

  FutureOr getToken() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      token = await box.get(kAccessToken, defaultValue: '');
      isExistingUser = await box.get(kExistingUser, defaultValue: false);
      pinEnabled = box.get(isPinEnabled, defaultValue: "");
      if (mounted) {
        setState(() {});
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'JostPay',
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            home: SplashScreen(),
          ),
        );
      }),
    );
  }
}
