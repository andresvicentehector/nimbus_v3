import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../z_widgets_comunes/utils/theme_login_helper.dart';
import '../login/login_screen.dart';
import '../z_widgets_comunes/utils/login_header_widget.dart';
import 'forgot_password_verification_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 300;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: _headerHeight,
            child: HeaderWidget(_headerHeight, true, Icons.password_rounded),
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.resources.strings.forgotPasswordtittle,
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                          // textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          context.resources.strings.forgotPasswordsubtittle,
                          style: TextStyle(
                            // fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          // textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          context.resources.strings.forgotPasswordText,
                          style: TextStyle(

                              // fontSize: 20,
                              ),
                          // textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                            decoration: ThemeLoginHelper().textInputDecoration(
                                context.resources.strings.forgotPasswordEmail,
                                context.resources.strings
                                    .forgotPasswordEmailDescription,
                                context),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return context.resources.strings
                                    .forgotPasswordEmailCantBeEmpty;
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                  .hasMatch(val)) {
                                return context.resources.strings
                                    .forgotPasswordEmailValidation;
                              }
                              return null;
                            },
                          ),
                          decoration:
                              ThemeLoginHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 40.0),
                        Container(
                          decoration:
                              ThemeLoginHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeLoginHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                context
                                    .resources.strings.forgotPasswordSendButton
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: context.resources.fonts.tittle,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordVerificationPage()),
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: context.resources.strings
                                      .forgotPasswordRemember),
                              TextSpan(
                                text: context
                                    .resources.strings.forgotPasswordLogin,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                    );
                                  },
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
