import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:portfolio_app/presentation/screen/chat.dart";
import "package:portfolio_app/presentation/screen/home.dart";
import "package:portfolio_app/presentation/screen/login.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen() : super();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.asset(
        "asset/logo.png",
        height: 250,
      ),
    ));
  }
}
