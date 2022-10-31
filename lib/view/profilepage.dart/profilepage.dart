import 'dart:io';

import 'package:bookreader/constants/constants.dart';
import 'package:bookreader/controller/auth_methods.dart';
import 'package:bookreader/controller/firebase_methods.dart';
import 'package:bookreader/model/bookmodel.dart';
import 'package:bookreader/model/usermodel.dart';
import 'package:bookreader/view/login/loginpage.dart';
import 'package:bookreader/view/wallet/wallet_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Uuid _uuid = const Uuid();
  AppUser? userdata;

  List<BookModel>? bookdata;

  @override
  void initState() {
    super.initState();
    getUserdata();
    getBookData();
  }

  getUserdata() async {
    var data = await AuthMethods.getUserDetails();
    setState(() {
      userdata = data;
    });
  }

  getBookData() async {
    var data = await FirebaseMethods.getAllBooks();
    setState(() {
      bookdata = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          dialogboxforlogoutandlogin();
        },
        label: const Text("Logout"),
        icon: const Icon(Icons.exit_to_app),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple,
                  Colors.deepPurpleAccent,
                ],
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                GestureDetector(
                  onTap: () async {
                    List<BookModel> booklist = getModelBookList();
                    for (int i = 0; i < booklist.length; i++) {
                      String uid = _uuid.v4();
                      await FirebaseMethods.setBook(
                          docId: uid, bookdata: booklist[i]);
                      Future.delayed(const Duration(seconds: 2));
                    }
                  },
                  child: const CircleAvatar(
                    radius: 65.0,
                    backgroundImage: AssetImage(
                        'assets/books/an_anonymous_girl_by_greer_hendricks.jpg'),
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  userdata?.username ?? "Loading...",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  userdata?.email ?? "Loading...",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Card(
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Information",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Divider(
                      color: Colors.grey[300],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.attach_money_rounded,
                          color: Colors.blueAccent[400],
                          size: 35,
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Total Coins",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            Text(
                              userdata?.totalCoins.toString() ?? "Loading...",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[400],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          color: Colors.yellowAccent[400],
                          size: 35,
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Total Liked Books",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            Text(
                              "5",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[400],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.pinkAccent[400],
                          size: 35,
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Favorite Books",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            Text(
                              "10",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[400],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.pages,
                          color: Colors.lightGreen[400],
                          size: 35,
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Total Purchased Pages",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            Text(
                              "500",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[400],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const WalletPage()));
            },
            child: Card(
              margin: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.wallet_giftcard,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Center(
                        child: Text(
                      "Wallet",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
