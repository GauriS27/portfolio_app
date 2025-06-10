import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_app/core/string.dart';
import 'package:portfolio_app/core/ui.dart';
import 'package:portfolio_app/presentation/widget/vertical_spacer.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _username = TextEditingController();

  final _password = TextEditingController();

  final _firebase = FirebaseAuth.instance;

  bool _isLoginScreen = true;

  /// this will toggle the same scree

  void onSubmit() async {
    bool _isValid = _formKey.currentState!.validate();
    if (!_isValid) {
      return;
    }
    print(_email.text.toString() + _password.text.toString());

    /// authorize in firebase
    try {
      UserCredential user;

      /// toggle the functionality based on screens
      print(_isLoginScreen);
      if (_isLoginScreen) {
        user = await _firebase.signInWithEmailAndPassword(
            email: _email.text, password: _password.text);
      } else {
        user = await _firebase.createUserWithEmailAndPassword(
            email: _email.text.toString(), password: _password.text.toString());
        await FirebaseFirestore.instance
            .collection(userCollectionName)
            .doc(user.user!.uid.toString())
            .set({
          userCollectionEmailNode: _email.text,
          userCollectionUsernameNode: _username.text
        });
      }
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "Authentication Failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    var kTextTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              ColorConstant.scaffolfBgPrimaryColor,
              ColorConstant.scaffolfBgSecondaryColor,
              ColorConstant.scaffolfBgTernaryColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.5, 0.65]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              children: [
                VerticalSpacer(
                  boxHeight: 200,
                ),
                Center(
                  child: Text(
                    _isLoginScreen ? "Login" : "Signup",
                    style: GoogleFonts.capriola(
                        textStyle: kTextTheme.headlineLarge),
                  ),
                ),
                const VerticalSpacer(),

                /// Login form
                Card(
                  surfaceTintColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// email
                          TextFormField(
                            controller: _email,
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: kTextTheme.bodySmall,
                            ),
                            style: kTextTheme.bodySmall,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.toString().contains("@")) {
                                return "Please enter valid Email";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) {},
                          ),
                          Visibility(
                              visible: !_isLoginScreen,
                              child: const VerticalSpacer.medium()),
                          Visibility(
                            visible: !_isLoginScreen,
                            child: TextFormField(
                              controller: _username,
                              decoration: InputDecoration(
                                labelText: "Username",
                                labelStyle: kTextTheme.bodySmall,
                              ),
                              style: kTextTheme.bodySmall,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter valid Username";
                                } else if (value.trim().length < 6) {
                                  return "Username must be atleast 6 digit long";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const VerticalSpacer.medium(),
                          // password
                          TextFormField(
                            controller: _password,
                            decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: kTextTheme.bodyMedium),
                            keyboardType: TextInputType.emailAddress,
                            style: kTextTheme.bodySmall,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter valid passwrod";
                              } else if (value.length < 6 || value.isEmpty) {
                                return "Password must be 6 or more character long";
                              } else {
                                return null;
                              }
                            },
                          ),

                          const VerticalSpacer(),
                          const VerticalSpacer(),

                          /// login button
                          Row(
                            children: [
                              Expanded(
                                  child: TextButton(
                                      style: ButtonStyle(
                                        foregroundColor: WidgetStatePropertyAll(
                                            ColorConstant.whiteColor),
                                        backgroundColor: WidgetStatePropertyAll(
                                            ColorConstant.primaryColor),
                                      ),
                                      onPressed: onSubmit,
                                      child: Text(_isLoginScreen
                                          ? "Log in"
                                          : "Sign up"))),
                            ],
                          ),
                          const VerticalSpacer.small(),

                          Center(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _isLoginScreen = !_isLoginScreen;
                                });
                              },
                              child: Text(
                                !_isLoginScreen ? "Log in" : "Sign up",
                                style: kTextTheme.bodySmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const VerticalSpacer(),
              ]),
        ),
      ),
    );
  }
}
