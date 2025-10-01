import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/Provider/auth_provider.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/Helper/notification_helper.dart';
import 'package:jost_pay_wallet/common/splash.dart';
import 'package:jost_pay_wallet/constants/constants.dart';
import 'package:jost_pay_wallet/firebase_options.dart';
import 'package:jost_pay_wallet/utils/keep_alive_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'Provider/account_provider.dart';
import 'Provider/DashboardProvider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'Provider/InternetProvider.dart';


/// Getting available cameras for testing.
@visibleForTesting
List<CameraDescription> get cameras => _cameras;
List<CameraDescription> _cameras = <CameraDescription>[];
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a background message: ${message.messageId}");
// }
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
    //!===== Firebase ================
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // final firebaseMessaging = FirebaseMessaging.instance;
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground! $message');
    //   NotificationHelper().handleMessage(message);
    // });
    // await firebaseMessaging.getAPNSToken();
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
  // await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.playIntegrity,
  //   appleProvider: AppleProvider.appAttest,
  //   webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  // );
  const fatalError = true;
  // Non-async exceptions
  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  late Future<void> initializeFlutterFireFuture;
  bool crashlyticsEnabled = true;
  // Define an async function to initialize FlutterFire
  Future<void> _initializeFlutterFire() async {
    if (kDebugMode) {
      // Force enable crashlytics collection enabled if we're testing it.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      crashlyticsEnabled = true;
    } else {
      // Else only enable it in non-debug builds.
      // You could additionally extend this to allow users to opt-in.
      const enabled = !kDebugMode;
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(enabled);
      crashlyticsEnabled = enabled;
    }
  }



  @override
  void initState() {
    super.initState();
    initializeFlutterFireFuture = _initializeFlutterFire();
    getToken();
    WidgetsBinding.instance.addObserver(this);

  }

  final box = Hive.box(kAppName);
  String token = '';
  String pinEnabled = '';
  bool isExistingUser = false;

  FutureOr getToken() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final fcm = FirebaseMessaging.instance.getToken();
      fcm.then((value) {
        log('Firebase Token: $value');
        box.put(kDeviceToken, value);
      });
      token = await box.get(kAccessToken, defaultValue: '');
      isExistingUser = await box.get(kExistingUser, defaultValue: false);
      pinEnabled = box.get(isPinEnabled, defaultValue: "");
      if (mounted) {
        setState(() {});
      }
    });
  }
  // This widget is the root of your application.
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
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


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
