import 'package:bookreader/constants/constants.dart';
import 'package:bookreader/constants/e_nums.dart';
import 'package:bookreader/constants/error_handler.dart';
import 'package:bookreader/controller/auth_methods.dart';
import 'package:bookreader/custom_functions.dart/custom_functions.dart';
import 'package:bookreader/view/signup/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  bool obscure = true;
  void showInSnackBar(
      {String? text, Color bgColor = Colors.blue, BuildContext? context}) {
    FocusScope.of(context!).requestFocus(FocusNode());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: bgColor,
      duration: const Duration(seconds: 3),
    ));
  }

  emailLogIn(BuildContext context, String email, String password) async {
    CustomFunctions.showProgressBottomSheet(context, 'LOGGING IN');

    await Future.delayed(const Duration(seconds: 2));

    final EmailLogIn loginStatus =
        await AuthMethods.emailLogIn(context, email, password);

    ErrorHandler.emailLoginError(loginStatus);
    if (loginStatus == EmailLogIn.loggedIn) {
      Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
    } else if (loginStatus == EmailLogIn.emailNotVerified) {
      Navigator.pop(context);

      showInSnackBar(
        context: context,
        text: ErrorHandler.emailLoginError(loginStatus),
        bgColor: Colors.green,
      );
    } else {
      Navigator.pop(context);

      showInSnackBar(
        context: context,
        text: ErrorHandler.emailLoginError(loginStatus),
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignupPage()),
              );
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Signup",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
          // socialLogin()
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
                        controller: _emailController,
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
                        controller: _pwController,
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      emailLogIn(
                        context,
                        _emailController.text,
                        _pwController.text,
                      );
                    }
                  }
                },
                child: const Text("Login",
                    style: TextStyle(color: Colors.white70)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget socialLogin() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Column(
        children: [
          TextButton(
            onPressed: () async {
              // final SocialLogIn loginStatus =
              //     await FirebaseMethods.signInWithFacebook();

              // CustomFunctions.dialogOpen(
              //   title: 'Login Failed',
                // content: ErrorHandler.socialLogin(loginStatus),
              // );
            },
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
