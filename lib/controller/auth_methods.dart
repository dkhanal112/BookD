import 'package:bookreader/constants/e_nums.dart';
import 'package:bookreader/constants/constants.dart';
import 'package:bookreader/custom_functions.dart/custom_functions.dart';
import 'package:bookreader/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final CollectionReference _usersCollection =
      firestore.collection(kUsersCollection);

  static User getCurrentUser() {
    User? currentUser;
    currentUser = _auth.currentUser;
    return currentUser!;
  }

  static Future<AppUser> getUserDetails() async {
    User _currentUser = getCurrentUser();

    DocumentSnapshot documentSnapshot = await firestore
        .collection(kUsersCollection)
        .doc(_currentUser.uid)
        .get();
    AppUser _user =
        AppUser.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    return _user;
  }

  static Future<AppUser?> getUserDetailsById(id) async {
    try {
      DocumentSnapshot documentSnapshot = await _usersCollection.doc(id).get();
      return AppUser.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> authenticateUser(User user) async {
    QuerySnapshot result = await firestore
        .collection(kUsersCollection)
        .where("uid", isEqualTo: user.uid)
        .get();

    final List<DocumentSnapshot> docs = result.docs;

    //if user is registered then length of list > 0 or else less than 0
    return docs.isEmpty ? true : false;
  }

  static Future<bool> addNewUserToDb(AppUser newUser) async {
    try {
      await firestore
          .collection(kUsersCollection)
          .doc(newUser.uid)
          .set(newUser.toMap(newUser) as Map<String, dynamic>);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<EmailLogIn> emailLogIn(
      BuildContext context, String email, String password) async {
    try {
      var authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (authResult.user!.emailVerified) {
        var partner = await getUserDetails();
        debugPrint(partner.email);

        return EmailLogIn.loggedIn;
      } else {
        bool resend = await CustomFunctions.dialogOpen(
          context: context,
          title: 'Verify your email',
          content: 'Resend verification link?',
        );
        if (resend) {
          await authResult.user!.sendEmailVerification();
          await signOut();
          return EmailLogIn.emailNotVerified;
        } else {
          return EmailLogIn.verifyEmailFirst;
        }
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return EmailLogIn.invalidEmail;

        case 'wrong-password':
          return EmailLogIn.wrongPassword;

        case 'user-not-found':
          return EmailLogIn.userNotFound;

        case 'user-disabled':
          return EmailLogIn.userDisabled;

        case 'too-many-requests':
          return EmailLogIn.tooManyRequests;

        default:
          return EmailLogIn.otherError;
      }
    } catch (e) {
      return EmailLogIn.otherError;
    }
  }

  static Future<void> signOut({context}) async {
    try {
      _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<EmailSignUp> emailSignUp(BuildContext context, String email,
      String password, String username) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) async {
        await result.user!.sendEmailVerification();

        if (result.user != null) {
          await authenticateUser(result.user!).then((isNewUser) async {
            if (isNewUser) {
              AppUser _user = AppUser(
                  uid: result.user!.uid,
                  email: email,
                  username: username,
                  totalCoins: 0);
              await addNewUserToDb(_user);
            }
          });
        }
      });
      await signOut();
      return EmailSignUp.signedUp;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          return EmailSignUp.weakPassword;
        case 'invalid-email':
          return EmailSignUp.invalidEmail;
        case 'email-already-in-use':
          return EmailSignUp.emailAlreadyInUse;
        default:
          return EmailSignUp.otherError;
      }
    } catch (e) {
      return EmailSignUp.otherError;
    }
  }

 
}
