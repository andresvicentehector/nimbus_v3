import 'dart:io';

import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../z_widgets_comunes/utils/theme_login_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../userProfile/profile_screen.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();
  final _focusNode4 = FocusNode();
  final _focusNode5 = FocusNode();

  bool checkedValue = false;
  bool checkboxValue = false;

  void dispose() {
    super.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? previousPasword;

    File? _image;

    Future<void> _pickImage() async {
      final picker = ImagePicker();
      final pickedFile =
          await picker.pickImage(source: ImageSource.gallery, maxWidth: 800);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        }
      });
    }

    return GestureDetector(
      onTap: () {
        _focusNode1.unfocus();
        _focusNode2.unfocus();
        _focusNode3.unfocus();
        _focusNode4.unfocus();
        _focusNode5.unfocus();
      },
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(25, 90, 25, 10),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _pickImage();
                            },
                            child: Stack(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 5, color: Colors.white),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 20,
                                          offset: const Offset(5, 5),
                                        ),
                                      ],
                                    ),
                                    child: _image != null
                                        ? Image.file(
                                            _image!,
                                            width: 80.0,
                                          )
                                        : Icon(
                                            Icons.person,
                                            color: Colors.grey.shade300,
                                            size: 80.0,
                                          )),
                                Container(
                                  padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                  child: Icon(
                                    Icons.add_circle,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 25.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: TextFormField(
                              focusNode: _focusNode1,
                              decoration: ThemeLoginHelper()
                                  .textInputDecoration(
                                      context
                                          .resources.strings.registerScreenName,
                                      context.resources.strings
                                          .registerScreenWritteName,
                                      context),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return context.resources.strings
                                      .registerScreenWritteName;
                                }
                                return null;
                              },
                            ),
                            decoration:
                                ThemeLoginHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: TextFormField(
                              focusNode: _focusNode2,
                              decoration: ThemeLoginHelper()
                                  .textInputDecoration(
                                      context
                                          .resources.strings.registerScreenNick,
                                      context.resources.strings
                                          .registerScreenWritteNick,
                                      context),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return context.resources.strings
                                      .registerScreenWritteNick;
                                }
                                return null;
                              },
                            ),
                            decoration:
                                ThemeLoginHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 30.0),
                          Container(
                            child: TextFormField(
                              decoration: ThemeLoginHelper()
                                  .textInputDecoration(
                                      context.resources.strings
                                          .registerScreenEmail,
                                      context.resources.strings
                                          .registerScreenWritteEmail,
                                      context),
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (val!.isNotEmpty &&
                                    !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                        .hasMatch(val)) {
                                  return context.resources.strings
                                      .registerScreenEnterValidEmail;
                                }
                                if (val == null || val.isEmpty) {
                                  return context.resources.strings
                                      .registerScreenEnterValidEmail;
                                }
                                return null;
                              },
                            ),
                            decoration:
                                ThemeLoginHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 30.0),
                          Container(
                            child: TextFormField(
                              obscureText: true,
                              decoration: ThemeLoginHelper()
                                  .textInputDecoration(
                                      context.resources.strings
                                          .registerScreenPassword,
                                      context.resources.strings
                                          .registerScreenWrittePassword,
                                      context),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return context.resources.strings
                                      .registerScreenEnterValidPassword;
                                }
                                if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9]).{8,}$')
                                    .hasMatch(val)) {
                                  return context.resources.strings
                                      .registerScreenEnterValidPasswordMayusAndNumber;
                                }

                                previousPasword = val;
                                return null;
                              },
                            ),
                            decoration:
                                ThemeLoginHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 30.0),
                          Container(
                            child: TextFormField(
                              obscureText: true,
                              decoration: ThemeLoginHelper()
                                  .textInputDecoration(
                                      context.resources.strings
                                          .registerScreenRepeatPassword,
                                      context.resources.strings
                                          .registerScreenWritteRepeatPassword,
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
                            decoration:
                                ThemeLoginHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 15.0),
                          FormField<bool>(
                            builder: (state) {
                              return Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: checkboxValue,
                                          onChanged: (value) {
                                            setState(() {
                                              checkboxValue = value!;
                                              state.didChange(value);
                                            });
                                          }),
                                      GestureDetector(
                                        onTap: () {
                                          // ignore: deprecated_member_use
                                          launch(
                                              'https://www.nimbuswalls.com/Terminos.html');
                                        },
                                        child: Text(
                                          context.resources.strings
                                              .registerScreenAcceptTerms,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      state.errorText ?? '',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).colorScheme.error,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                            validator: (value) {
                              if (!checkboxValue) {
                                return context.resources.strings
                                    .registerScreenYouMustAcceptTerms;
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 20.0),
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
                                      .resources.strings.registerScreenRegister
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
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => ProfilePage()),
                                      (Route<dynamic> route) => false);
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
