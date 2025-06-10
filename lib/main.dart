import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_app/core/ui.dart';
import 'package:portfolio_app/firebase_options.dart';
import 'package:portfolio_app/presentation/screen/chat.dart';
import 'package:portfolio_app/presentation/screen/home.dart';
import 'package:portfolio_app/presentation/screen/login.dart';
import 'package:portfolio_app/presentation/screen/splash.dart';

/// Creates different shades of color depending on our given color
var kColorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromRGBO(243, 91, 151, 100));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
      theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          textTheme: TextTheme(
              headlineLarge: TextStyles.headingLarge,
              headlineMedium: TextStyles.headingMedium,
              headlineSmall: TextStyles.headingSmall,
              titleLarge: TextStyles.titleLarge,
              titleMedium: TextStyles.titleMedium,
              titleSmall: TextStyles.titleSmall,
              bodyLarge: TextStyles.bodyLarge,
              bodyMedium: TextStyles.bodyMedium,
              bodySmall: TextStyles.bodySmall,
              displayLarge: TextStyles.displayLarge,
              displayMedium: TextStyles.displayMedium,
              displaySmall: TextStyles.displaySmall),
          cardTheme: CardTheme(
              color: ColorConstant.greyColor, margin: EdgeInsets.zero),
          buttonTheme: ButtonThemeData(
              buttonColor: ColorConstant.primaryColor,
              textTheme: ButtonTextTheme.normal)

          // scaffoldBackgroundColor: Gradient(colors: [])
          // appBarTheme: AppBarTheme().copyWith(
          //     backgroundColor: kColorScheme.onPrimaryContainer,
          //      titleTextStyle: TextStyle(color: kColorScheme.onPrimary))
          ),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            }
            if (snapshot.hasData) {
              return HomeScreen();
            }
            return LoginScreen();
          })));
}
