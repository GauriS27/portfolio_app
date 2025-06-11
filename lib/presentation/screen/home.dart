import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_app/core/string.dart';
import 'package:portfolio_app/core/ui.dart';
import 'package:portfolio_app/data/chatroom_model.dart';
import 'package:portfolio_app/logic/functions.dart';
import 'package:portfolio_app/presentation/screen/chat.dart';
import 'package:portfolio_app/presentation/screen/login.dart';
import 'package:portfolio_app/presentation/widget/experience_timeine.dart';
import 'package:portfolio_app/presentation/widget/vertical_spacer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  var uuid = Uuid();

  final List<String> skills = [
    "Dart",
    "HTML/CSS",
    "Flutter",
    "Firebase",
    "BLoC",
    "Provider",
    "Riverpod",
    "Git",
    "Figma",
    "Canva",
    "Android",
  ];

  Future<ChatroomModel> getChatRoom() async {
    var currentUserId = FirebaseAuth.instance.currentUser!.uid;

    ChatroomModel chatroom;

    /// check in firebase that does there any chatroom exists with senderId
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(chatCollection)
        .where(chatParticipantIdNode, isEqualTo: currentUserId)
        .get();

    if (snapshot.docs.length > 0) {
      /// get that chatroom
      var dataMap = snapshot.docs[0].data();

      chatroom = ChatroomModel.fromMap(dataMap as Map<String, dynamic>);
      print("Chatroom exists");
    } else {
      ChatroomModel newchatroom;
      var username = await getUserName();
      newchatroom = ChatroomModel(
          chatroomId: uuid.v1(),
          participantId: currentUserId,
          participantName: username);
      await FirebaseFirestore.instance
          .collection(chatCollection)
          .doc(newchatroom.chatroomId)
          .set(newchatroom.toMap());
      chatroom = newchatroom;
      print("CHatroom created");
    }
    return chatroom;
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
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Center(
          child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              children: [
                const VerticalSpacer(),
                RichText(
                  text: TextSpan(
                    text: 'Hello,\n',
                    style: GoogleFonts.calistoga(
                        textStyle:
                            kTextTheme.headlineSmall!.copyWith(height: 1.5)),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Good Morning',
                        style: GoogleFonts.calistoga(
                            textStyle: kTextTheme.headlineMedium),
                      ),
                    ],
                  ),
                ),
                const VerticalSpacer(),

                /// Avatar
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    image: DecorationImage(
                        image: AssetImage("asset/images/avatar.png"),
                        fit: BoxFit.contain),
                  ),
                ),
                const VerticalSpacer(),
                Center(
                  child: Text(
                    "Gauri Salgaonkar",
                    style: GoogleFonts.capriola(
                        textStyle: kTextTheme.headlineLarge),
                  ),
                ),
                const VerticalSpacer.small(),
                Center(
                  child: Text(
                    "FLUTTER DEVELOPER",
                    style: kTextTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                ),
                const VerticalSpacer(),

                /// professional summary
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const VerticalSpacer.small(),
                        Center(
                          child: Text(
                            "PROFESSIONAL SUMMARY",
                            style: kTextTheme.bodySmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const VerticalSpacer.small(),
                        Text(
                          "Flutter Developer with 4+ years of experience in building scalable Android applications using Flutter, Firebase, and REST APIs. Strong background in UI/UX design, state management (Provider, BLoC), and deploying apps to the Play Store.",
                          style: kTextTheme.bodySmall!,
                          textAlign: TextAlign.center,
                        ),
                        const VerticalSpacer.medium(),
                      ],
                    ),
                  ),
                ),
                const VerticalSpacer(),

                /// Technical skill
                Center(
                  child: Text(
                    "TECHNICAL SKILLS",
                    style: kTextTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const VerticalSpacer(),
                Wrap(
                  spacing: 5,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: skills.map((skill) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorConstant.primaryColor),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        skill,
                        style: kTextTheme.bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                ),
                const VerticalSpacer(),
                const VerticalSpacer.small(),

                /// Work Experience
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      // shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      children: [
                        const VerticalSpacer.medium(),
                        Center(
                          child: Text(
                            "Work Experience".toUpperCase(),
                            style: kTextTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const VerticalSpacer(),

                        ///  Experience timeline widget
                        const ExperienceTimeine(
                            company_name:
                                "Intermind Digital Solutions - Mumbai",
                            designation: "Flutter Developer",
                            duration: "Mar 2023 - Jan 2025"),
                        const ExperienceTimeine(
                            company_name: "Hamiters - Mumbai",
                            designation:
                                "Web Developer and Mobile App Developer",
                            duration: "Jan 2021 - Nov 2022"),
                        const ExperienceTimeine(
                          company_name: "Hamiters (Internship) - Mumbai",
                          designation: "Web Developer",
                          duration: "Jan 2021 - Nov 2022",
                          isLast: true,
                        ),
                        const VerticalSpacer.small(),
                      ],
                    ),
                  ),
                ),
                const VerticalSpacer(),
                const VerticalSpacer(),

                Text(
                  "About Me".toUpperCase(),
                  style: kTextTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const VerticalSpacer(),

                Row(
                  children: [
                    Image.asset(
                      "asset/icons/Mappin.png",
                      height: 25,
                    ),
                    Container(
                      color: Colors.transparent,
                      width: 5,
                    ),
                    Text(
                      "Mumbai, India",
                      style: kTextTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const VerticalSpacer(),

                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        launchUrl(
                          Uri.parse('mailto:gauri27salgaonkar@gmail.com'),
                        );
                      },
                      child: Icon(
                        Icons.mail_outline_outlined,
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        launchUrl(
                          Uri.parse(
                              "https://www.linkedin.com/in/gauri-s-0babbb158"),
                          webOnlyWindowName: '_blank',
                        );
                      },
                      child: Image.asset(
                        "asset/icons/linkedin.png",
                        height: 25,
                      ),
                    ),
                  ],
                ),
                const VerticalSpacer(),

                InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: Text(
                    "Logout",
                    style: kTextTheme.displaySmall!
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                ),
                const VerticalSpacer(), const VerticalSpacer(),
              ]),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
          child: FloatingActionButton(
            backgroundColor: ColorConstant.greenColor.withOpacity(0.7),
            child: Image.asset(
              "asset/icons/Chat.png",
              height: 35,
            ),
            onPressed: () async {
              /// check if chatroom already exists
              var currentUser = FirebaseAuth.instance.currentUser;
              if (currentUser != null) {
                ChatroomModel chatroom = await getChatRoom();
                print(chatroom.participantId);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        chatroom: chatroom,
                      ),
                    ));
              } else {
                var snackBar = SnackBar(
                    duration: Duration(seconds: 1),
                    content: Text('Kindly login to continue chat'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
              }
            },
          ),
        ),
      ),
    );
  }
}
