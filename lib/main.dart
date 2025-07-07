// ignore_for_file: await_only_futures, deprecated_member_use
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:imechano/localization/app_localization.dart';
import 'package:imechano/ui/common/globals.dart';
import 'package:imechano/ui/privacy_disp.dart';
import 'package:imechano/ui/provider/invoice_balance_provider.dart';
import 'package:imechano/ui/provider/notification_count_provider.dart'; 
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/screens/bottombar/job_card_details.dart';
import 'package:imechano/ui/screens/my_account/home.dart';
import 'package:imechano/ui/screens/select_car/view/edit_details_screen.dart';
import 'package:imechano/ui/share_preferences/pref_key.dart';
import 'package:imechano/ui/share_preferences/preference.dart';
import 'package:imechano/ui/styling/global.dart';
import 'package:imechano/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ui/screens/auth/sign_in/view/sign_in_screen.dart';
import '../ui/screens/auth/sign_up/view/sign_up_screen.dart';
import '../ui/screens/select_car/view/select_your_car_screen.dart';
import '../ui/screens/auth/landing/view/sign_in_sign_up_landing_screen.dart';
import '../ui/screens/language/view/language_choose_screen.dart';
import '../ui/screens/on_boarding/view/on_boarding_screen.dart';
import '../ui/screens/splash/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_options.dart';

import 'ui/screens/bottombar/bottom_bar.dart';

import 'ui/screens/my_account/progress_report_active.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  log('Handling a background message ${message.messageId}');
}

// /// Create a [AndroidNotificationChannel] for heads up notifications
// late AndroidNotificationChannel channel;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.max,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

int? initScreen;
Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // //===========CRASHLYTICS==========

  // // Pass all uncaught "fatal" errors from the framework to Crashlytics
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // FirebaseCrashlytics.instance.crash();
  FlutterNativeSplash.removeAfter(initialization);

  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);

  final Directory appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  AppModel appLanguage = AppModel();
  await Hive.openBox('imechano').then(
    (value) => runApp(
      ChangeNotifierProvider(
        create: (context) => AppModel(),
        child: IMechanoApp(
          prefs: value,
          appLanguage: "en",
        ),
      ),
    ),
  );
}

Future<void> initialization(BuildContext context) async {
  // This is where you can initialize the resources needed by your app while
  // the splash screen is displayed.  Remove the following example because
  // delaying the user experience is a bad design practice!
  // ignore_for_file: avoid_print
  log('ready in 3...');
  await Future.delayed(const Duration(milliseconds: 500));
  log('ready in 2...');
  await Future.delayed(const Duration(milliseconds: 500));
  log('ready in 1...');
  await Future.delayed(const Duration(milliseconds: 500));
  log('go!');
}

class IMechanoApp extends StatefulWidget {
  final GlobalKey<NavigatorState> key = new GlobalKey<NavigatorState>();

  IMechanoApp({required this.prefs, required this.appLanguage});
  final Box prefs;
  final String appLanguage;
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }

  @override
  _IMechanoAppState createState() => _IMechanoAppState(prefs: prefs);
}

class _IMechanoAppState extends State<IMechanoApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  _IMechanoAppState({required this.prefs});
  Box prefs;
  AppModel appModel = new AppModel();
  void notification() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    log('User granted permission: ${settings.authorizationStatus}');
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @override
  void initState() {
    super.initState();
    _initAppTheme();
    log("Printing TOKEN");
    _firebaseMessaging.getToken().then((value) => log(value.toString()));
    notification();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      log("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      // log('getInitialMessage data: ${message!.data}');
      log("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      if (message != null) {
        Utils.handleNotificationNavigation(context, message, null);
      }
    });

    // onMessage: When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      log("onMessage data: ${message.data}");
      log("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~cdfdfds~~~~~~~~~~~~~~~~~~~~");
      Utils.handleNotificationNavigation(context, message, null);
    });

    // replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      log("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      log('onMessageOpenedApp data: $message');
      log("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      Utils.handleNotificationNavigation(context, message, null);
    });
  }

  void _initAppTheme() async {
    appModel.darkTheme = await appModel.appPreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context, listen: true);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Consumer<AppModel>(
        builder: (context, value, child) {
          appModel.fetchLocale();

          return ScreenUtilInit(
            designSize: Size(360, 690),
            builder: () =>
                Consumer<AppModel>(builder: (context, appLang, child) {
              return MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                      create: (_) => NotificationCountProvider()),
                  ChangeNotifierProvider(
                      create: (_) => InvoiceBalanceProvider())
                ],
                child: GetMaterialApp(
                  title: 'iMechano',
                  locale: appModel.appLocal,
                  localizationsDelegates: [
                    AppLocalization.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: [
                    const Locale('ar'), // Arabic
                    const Locale('en'), // English
                  ],
                  debugShowCheckedModeBanner: false,
                  home: _dicedeScreen(prefs),
                  theme:
                      appModel.darkTheme ? buildDarkTheme() : buildLightTheme(),
                  // theme: ThemeData(
                  //   //fontFamily: 'Poppins',
                  //   primarySwatch: customBlueSwatch,
                  //   // visualDensity: VisualDensity.adaptivePlatformDensity,
                  // ),
                  getPages: [
                    GetPage(name: '/', page: () => SplashScreen()),
                    GetPage(name: '/sign-in', page: () => SignInScreen()),
                    GetPage(name: '/sign-up', page: () => SignUpScreen()),
                    GetPage(
                        name: '/on-boarding', page: () => OnBoardingScreen()),
                    GetPage(
                        name: '/choose-language',
                        page: () => LanguageChooseScreen()),
                    GetPage(
                        name: '/PrivacyPolicyScreene',
                        // page: () => PrivacyPolicyScreen()),
                        page: () =>
                            PolicyScreen(mdFileName: 'term_privacy.md')),
                    GetPage(
                        name: '/EditDetailsScreene',
                        page: () => EditDetailsScreen(id: '')),
                    GetPage(
                      name: '/sign-in-sign-up-landing',
                      page: () => SignInSignUpLandingScreen(),
                    ),
                    GetPage(
                        name: '/select-your-car',
                        page: () => SelectYourCarScreen(type: AddCarType.add)),
                  ],
                  routes: {
                    'home': (context) => SignInSignUpLandingScreen(),
                    'onboard': (context) => SplashScreen(),
                  },
                ),
              );
            }),
          );
        },
      ),
    );
  }

  ThemeData buildLightTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      buttonColor: Colors.redAccent,
      cardColor: Colors.white,
      backgroundColor: Colors.white,
      primaryColor: Colors.red,
      accentColor: Colors.redAccent,
      scaffoldBackgroundColor: Colors.white,
    );
  }

  ThemeData buildDarkTheme() {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      buttonColor: Colors.blueAccent,
      cardColor: Colors.grey[800],
      backgroundColor: Colors.grey[800],
      primaryColor: Colors.blue[900],
      accentColor: Colors.blueAccent,
      scaffoldBackgroundColor: Colors.grey[900],
    );
  }

  Widget _dicedeScreen(Box prefs) {
    PrefObj.preferences = prefs;
    // ignore: unused_local_variable
    final userStr = prefs.containsKey(PrefKeys.USER_DATA) ? true : false;
    final appStart =
        PrefObj.preferences!.containsKey(PrefKeys.APPSTARTED) ? true : false;
    log("appStart Lgoin");
    log(appStart.toString());
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SplashScreen(),
    );
  }
}
