import 'package:bookreader/constants/e_nums.dart';
import 'package:bookreader/constants/constants.dart';
import 'package:bookreader/constants/error_handler.dart';
import 'package:bookreader/controller/auth_methods.dart';
import 'package:bookreader/controller/firebase_methods.dart';
import 'package:bookreader/custom_functions.dart/custom_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _username = TextEditingController();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscure = true;
  bool isRegistering = false;
  bool pwTapped = false;
  bool exists = false;

  void showInSnackBar({String? text, Color bgColor = Colors.blue}) {
    FocusScope.of(context).requestFocus(FocusNode());

    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          // fontFamily: "WorkSansSemiBold",
        ),
      ),
      backgroundColor: bgColor,
      duration: const Duration(seconds: 3),
    ));
  }

  emailSignUp(String email, String password, String username) async {
    CustomFunctions.showProgressBottomSheet(context, 'SIGNING UP');
    final EmailSignUp signupStatus =
        await AuthMethods.emailSignUp(context, email, password, username);
    Navigator.pop(context);
    if (signupStatus == EmailSignUp.signedUp) {
      showInSnackBar(
        text: 'Account created. Verify your email and sign in.',
        bgColor: Colors.green,
      );
    } else {
      showInSnackBar(
        text: ErrorHandler.emailSignUpError(signupStatus),
        bgColor: Colors.red,
      );
    }
  }

  Widget _buildPageContent(BuildContext context) {
    return Container(
      color: Colors.blue.shade100,
      child: ListView(
        children: <Widget>[
   
          const SizedBox(
            height: 10.0,
          ),
          const SizedBox(
            height: 80.0,
          ),
          _buildLoginForm(),
          // socialLogin(),
        ],
      ),
    );
  }

  Widget socialLogin() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Column(
        children: [
          const Text("Or",style: TextStyle(color: Colors.black54),),
          const Text("Try signing in with", style:  TextStyle(color: Colors.black54),),
        const  SizedBox(height: 10,),
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.facebook, color: Colors.white),
                SizedBox(width: 10.0),
                Text("Login with Facebook",
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.g_mobiledata, color: Colors.white),
                SizedBox(width: 10.0),
                Text("Login with Google",
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: RoundedDiagonalPathClipper(),
            child: Container(
              height: 400,
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 90.0,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: _username,
                        validator: (val) {
                          if (val!.trim().isEmpty) {
                            return 'Username cannot be empty';
                          } else {
                            return null;
                          }
                        },
                        style: kfont.copyWith(color: kPrimaryColor),
                        decoration: InputDecoration(
                            hintText: "Username",
                            labelStyle: kfont.copyWith(
                                color: kPrimaryColor.withOpacity(0.5)),
                            hintStyle: kfont.copyWith(
                                color: kPrimaryColor.withOpacity(0.5)),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.email,
                              color: kPrimaryColor,
                            )),
                      )),
                  Container(
                    child: Divider(
                      color: kPrimaryColor.withOpacity(.5),
                    ),
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 10.0),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: _email,
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val!)
                              ? null
                              : "Invalid Email";
                        },
                        style: kfont.copyWith(color: kPrimaryColor),
                        decoration: InputDecoration(
                            hintText: "Email address",
                            labelStyle: kfont.copyWith(
                                color: kPrimaryColor.withOpacity(0.5)),
                            hintStyle: kfont.copyWith(
                                color: kPrimaryColor.withOpacity(0.5)),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.email,
                              color: kPrimaryColor,
                            )),
                      )),
                  Container(
                    child: Divider(
                      color: kPrimaryColor.withOpacity(.5),
                    ),
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 10.0),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: _password,
                        validator: (val) {
                          return val!.length < 8
                              ? 'Password must have at least 8 characters'
                              : null;
                        },
                        obscureText: obscure,
                        style: kfont.copyWith(color: kPrimaryColor),
                        decoration: InputDecoration(
                          hintText: "Password",
                          labelStyle: kfont.copyWith(
                              color: kPrimaryColor.withOpacity(0.5)),
                          hintStyle: kfont.copyWith(
                              color: kPrimaryColor.withOpacity(0.5)),
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.lock,
                            color: kPrimaryColor,
                          ),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                              child: obscure
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: kPrimaryColor,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: kPrimaryColor,
                                    )),
                        ),
                      )),
                  Container(
                    child: Divider(
                      color: kPrimaryColor.withOpacity(.5),
                    ),
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 10.0),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40.0,
                backgroundColor: kPrimaryColor.withOpacity(0.85),
                child: const Icon(Icons.person),
              ),
            ],
          ),
          SizedBox(
            height: 420,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                    )),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      exists = false;
                    });
                    bool a = await FirebaseMethods.usernameChecker(
                        _username.text.toLowerCase());
                    if (a) {
                      setState(() {
                        exists = true;
                      });
                    }
                    if (_formKey.currentState!.validate()) {
                      emailSignUp(_email.text, _password.text,
                          _username.text.toLowerCase());

                      _username.clear();
                      _email.clear();
                      _password.clear();
                    }
                  }
                },
                child: const Text("Sign Up",
                    style: TextStyle(color: Colors.white70)),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: _buildPageContent(context),
      ),
    );
  }
}
