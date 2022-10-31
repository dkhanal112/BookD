import 'dart:io';

import 'package:bookreader/constants/constants.dart';
import 'package:bookreader/controller/auth_methods.dart';
import 'package:bookreader/model/usermodel.dart';
import 'package:bookreader/view/login/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  AppUser? userdata;
 
  

  @override
  void initState() {
    super.initState();
    getUserdata();

  }

  getUserdata()async{
      var data= await  AuthMethods.getUserDetails();
      setState(() {
        userdata = data;
      });
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(elevation: 5,
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage(
                        "assets/logo.png",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      userdata?.username ?? "Loading....",
                      style: kfont.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(60)),
                color: kPrimaryColor,
              ),
              height: 200,
            ),
            const SizedBox(
              height: 15,
            ),
            ListTile(
              title: Text(
                "Home",
                style:
                    kfont.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              leading: const Icon(Icons.home),
            ),
            ListTile(
              title: Text(
                "Books",
                style:
                    kfont.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              leading: const Icon(Icons.book),
            ),
            ListTile(
              title: Text(
                "Library",
                style:
                    kfont.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              leading: const Icon(Icons.library_books),
            ),
          ],
        ),
        Column(children: [
          ListTile(
            onTap: () {
              dialogboxforlogoutandlogin();
            },
            leading: const Icon(Icons.logout),
            title: Text(
              "Logout",
              style: kfont.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ])
      ],
    ));
  }

  dialogboxforlogoutandlogin() {
    return showDialog(
        context: context,
        builder: (context) {
          return Platform.isIOS
              ? CupertinoAlertDialog(
                  title: Text(
                    "Log Out",
                    style: kfont.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  content: Text(
                    "Are you sure to log out?",
                    style: kfont.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'No',
                        style: kfont.copyWith(
                          color: Colors.green,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (Route<dynamic> route) => false);
                      },
                      child: Text(
                        'Yes',
                        style: kfont.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                )
              : AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  title: Text(
                    "Log Out",
                    style: kfont.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  content: Text(
                    "Are you sure to log out?",
                    style: kfont.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'No',
                        style: kfont.copyWith(
                          color: Colors.green,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (Route<dynamic> route) => false);
                      },
                      child: Text(
                        'Yes',
                        style: kfont.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                );
        });
  }
}
