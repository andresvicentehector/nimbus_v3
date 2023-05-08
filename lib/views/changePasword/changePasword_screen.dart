import 'package:Nimbus/template/AppContextExtension.dart';

import 'package:Nimbus/views/userProfile/profile_screen.dart';
import 'package:flutter/material.dart';
import '../z_widgets_comunes/utils/theme_login_helper.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();

  void dispose() {
    super.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? previousPasword;
    return GestureDetector(
      onTap: () {
        _focusNode1.unfocus();
        _focusNode2.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.resources.strings.changePasswordAppBar.toUpperCase(),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: context.resources.fonts.tittle),
          ),
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
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
                            context.resources.strings.changePasswordTittle,
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontFamily: context.resources.fonts.tittle),
                          ),
                          Text(
                            context.resources.strings.changePasswordSubTittle,
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
                                    child: TextFormField(
                                      focusNode: _focusNode1,
                                      obscureText: true,
                                      decoration: ThemeLoginHelper()
                                          .textInputDecoration(
                                              context.resources.strings
                                                  .changePasswordPassword,
                                              context.resources.strings
                                                  .changePasswordEnterPassword,
                                              context),
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return context.resources.strings
                                              .registerScreenEnterValidPassword;
                                        }
                                        if (!RegExp(
                                                r'^(?=.*?[A-Z])(?=.*?[0-9]).{8,}$')
                                            .hasMatch(val)) {
                                          return context.resources.strings
                                              .registerScreenEnterValidPasswordMayusAndNumber;
                                        }

                                        previousPasword = val;
                                        return null;
                                      },
                                    ),
                                    decoration: ThemeLoginHelper()
                                        .inputBoxDecorationShaddow(),
                                  ),
                                  SizedBox(height: 30.0),
                                  Container(
                                    child: TextFormField(
                                      focusNode: _focusNode2,
                                      obscureText: true,
                                      decoration: ThemeLoginHelper()
                                          .textInputDecoration(
                                              context.resources.strings
                                                  .changePasswordRepeatPassword,
                                              context.resources.strings
                                                  .changePasswordRepeatPassword,
                                              context),
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return context.resources.strings
                                              .registerScreenEnterValidPassword;
                                        }
                                        if (val != previousPasword) {
                                          return context.resources.strings
                                              .registerScreenPasswordDontMatch;
                                        }
                                        return null;
                                      },
                                    ),
                                    decoration: ThemeLoginHelper()
                                        .inputBoxDecorationShaddow(),
                                  ),
                                  SizedBox(height: 15.0),
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
                                              .changePasswordChange
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
                                        if (_formKey.currentState!.validate()) {
                                          //After successful login we will redirect to profile page. Let's create profile page now
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilePage()));
                                        }
                                      },
                                    ),
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
