import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:portfolio_app/core/string.dart';

Future<String> getUserName() async {
  String username = "";
  try {
    QuerySnapshot querySnapShot =
        await FirebaseFirestore.instance.collection(userCollectionName).get();

    for (var queryData in querySnapShot.docs) {
      if (queryData.id == FirebaseAuth.instance.currentUser!.uid) {
        print("queryData getUserName ${queryData.data()}");
        Map<String, dynamic> userMap = queryData.data() as Map<String, dynamic>;
        username = userMap[userCollectionUsernameNode];
        print("queryData getUserName ${username}");
        break;
      }
    }
    return username;
  } on FirebaseException catch (e) {
    print("Errorr ..........  $e");
    return username;
  }
}

Future<String> getUserEmail() async {
  String email = "";
  try {
    QuerySnapshot querySnapShot =
        await FirebaseFirestore.instance.collection(userCollectionName).get();

    for (var queryData in querySnapShot.docs) {
      print("queryData ${queryData.id}");
      if (queryData.id == FirebaseAuth.instance.currentUser!.uid) {
        Map<String, dynamic> userMap = queryData.data() as Map<String, dynamic>;
        email = userMap[userCollectionEmailNode];
        break;
      }
    }
    return email;
  } on FirebaseException catch (e) {
    print("Errorr ..........  $e");
    return email;
  }
}
