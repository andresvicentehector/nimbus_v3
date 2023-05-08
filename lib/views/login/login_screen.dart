import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:Nimbus/views/forgotPassword/forgot_password_screen.dart';
import 'package:Nimbus/views/userProfile/profile_screen.dart';
import 'package:Nimbus/views/register/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../z_widgets_comunes/utils/theme_login_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Key _formKey = GlobalKey<FormState>();
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();

  void dispose() {
    super.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode1.unfocus();
        _focusNode2.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
                      margin: EdgeInsets.fromLTRB(
                          20, 10, 20, 10), // This will be the login form
                      child: Column(
                        children: [
                          Text(
                            context.resources.strings.loginScreenWellcome,
                            style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                fontFamily: context.resources.fonts.tittle),
                          ),
                          Text(
                            context.resources.strings.loginScreenSingIn,
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily:
                                    context.resources.fonts.fontRegular),
                          ),
                          SizedBox(height: 30.0),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Container(
                                    child: TextField(
                                      focusNode: _focusNode1,
                                      decoration: ThemeLoginHelper()
                                          .textInputDecoration(
                                              context.resources.strings
                                                  .loginScreenUserName,
                                              context.resources.strings
                                                  .loginScreenInsertUserName,
                                              context),
                                    ),
                                    decoration: ThemeLoginHelper()
                                        .inputBoxDecorationShaddow(),
                                  ),
                                  SizedBox(height: 30.0),
                                  Container(
                                    child: TextField(
                                      focusNode: _focusNode2,
                                      obscureText: true,
                                      decoration: ThemeLoginHelper()
                                          .textInputDecoration(
                                              context.resources.strings
                                                  .loginScreenPassword,
                                              context.resources.strings
                                                  .loginScreenInsertPassword,
                                              context),
                                    ),
                                    decoration: ThemeLoginHelper()
                                        .inputBoxDecorationShaddow(),
                                  ),
                                  SizedBox(height: 15.0),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgotPasswordPage()),
                                        );
                                      },
                                      child: Text(
                                        context.resources.strings
                                            .loginScreenForgotPassword,
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: ThemeLoginHelper()
                                        .buttonBoxDecoration(context),
                                    child: ElevatedButton(
                                      style: ThemeLoginHelper().buttonStyle(),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(40, 10, 40, 10),
                                        child: Text(
                                          context.resources.strings
                                              .loginScreenSignIn
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: context
                                                  .resources.fonts.tittle,
                                              color: Colors.white),
                                        ),
                                      ),
                                      onPressed: () {
                                        //After successful login we will redirect to profile page. Let's create profile page now
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfilePage()));
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                    //child: Text('Don\'t have an account? Create'),
                                    child: Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: context.resources.strings
                                              .loginScreenDontHaveAnAcount),
                                      TextSpan(
                                        text: context.resources.strings
                                            .loginScreenCreateAnAcount,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegistrationPage()));
                                          },
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      ),
                                    ])),
                                  ),
                                  SizedBox(height: 25.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          decoration: ThemeLoginHelper()
                                              .buttonBoxDecoration(
                                                  context,
                                                  Colors.grey.value.toString(),
                                                  Colors.grey.value.toString()),
                                          width: 300,
                                          height: 80,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                  // decoration: BoxDecoration(color: Colors.blue),
                                                  child: Image.network(
                                                      'http://pngimg.com/uploads/google/google_PNG19635.png',
                                                      fit: BoxFit.cover)),
                                              SizedBox(
                                                width: 15.0,
                                              ),
                                              Text(
                                                context.resources.strings
                                                    .loginScreenAccessWithGoogle,
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return ThemeLoginHelper()
                                                    .alertDialog(
                                                        "Google Plus",
                                                        "You tap on GooglePlus social icon.",
                                                        context);
                                              },
                                            );
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
