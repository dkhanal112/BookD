import 'dart:async';

import 'package:bookreader/constants/constants.dart';
import 'package:bookreader/model/bookmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseMethods {
  static final _firestore = FirebaseFirestore.instance;
  // static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<bool> usernameChecker(String username) async {
    var a = await _firestore
        .collection(kUsersCollection)
        .where("username", isEqualTo: username)
        .get();

    return a.docs.isEmpty ? true : false;
  }

  static setBook({String? docId, BookModel? bookdata}) async {
    await _firestore
        .collection(kBookCollection)
        .doc(docId)
        .set(bookdata!.toJson());
  }

  static Future<List<BookModel>> getAllBooks() async {
    List<BookModel> books = [];
    QuerySnapshot data = await _firestore.collection(kBookCollection).get();

    for (var value in data.docs) {
      books.add(BookModel.fromJson(value.data() as Map<String, dynamic>));
    }
    return books;
  }
  //   static Future<SocialLogIn> signInWithFacebook() async {
  //   try {
  //     final LoginResult facebookloginresult =
  //         await FacebookAuth.instance.login();

  //     // Create a credential from the access token
  //     final OAuthCredential credential = FacebookAuthProvider.credential(
  //       facebookloginresult.accessToken!.token,
  //     );
  //     // Once signed in, return the UserCredential
  //     final creds = await _auth.signInWithCredential(credential);
  //     if (creds.user != null) {
  //       await _createNewUser(creds.user!,
  //           isFb: true, fbToken: facebookloginresult.accessToken!.token);

  //       return SocialLogIn.loggedIn;
  //     }

  //   } catch (e) {
  //     return SocialLogIn.otherError;
  //   }

  //   throw{
  //   SocialLogIn.otherError,
  //   };

  // }

  // static Future<void> _createNewUser(User user,
  //     {bool isFb = false, String? fbToken}) async {
  //   DocumentSnapshot document =
  //       await _firestore.collection(kUsersCollection).doc(user.uid).get();

  //   if (!document.exists) {
  //     String? imageUrl = '';
  //     if (isFb) {
  //       final graphResponse = await http.get(Uri.parse(
  //           'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=$fbToken'));
  //       final responseBody = json.decode(graphResponse.body);
  //       imageUrl = responseBody['picture']['data']['url'].toString();
  //     }
  //     {
  //       imageUrl = user.photoURL;
  //     }

  //     final AppUser newUser = AppUser(
  //       uid: user.uid,
  //       username: user.displayName,
  //       profilePhoto: imageUrl ?? user.photoURL,
  //       email: user.email,
  //       totalCoins: 0,
  //     );

  //     await _createUserInDatabase(newUser);
  //   }
  // }

  // static Future<void> _createUserInDatabase(AppUser user) async {
  //   await _firestore
  //       .collection(kUsersCollection)
  //       .doc(user.uid)
  //       .set(user.toMap(user) as Map<String, dynamic>);
  // }
}
