import 'dart:io';

import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../z_widgets_comunes/utils/theme_login_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../userProfile/profile_screen.dart';

class ChangeUserInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChangeUserInfoPageState();
  }
}

class _ChangeUserInfoPageState extends State<ChangeUserInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();

  bool checkedValue = false;
  bool checkboxValue = false;

  void dispose() {
    super.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.resources.strings.changeUserInfoAppBar.toUpperCase(),
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
                                          .resources.strings.changeUserInfoName,
                                      context.resources.strings
                                          .changeUserInfoWritteName,
                                      context),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return context.resources.strings
                                      .changeUserInfoWritteName;
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
                                          .resources.strings.changeUserInfoNick,
                                      context.resources.strings
                                          .changeUserInfoWritteNick,
                                      context),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return context.resources.strings
                                      .changeUserInfoWritteNick;
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
                                          .changeUserInfoEmail,
                                      context.resources.strings
                                          .changeUserInfoWritteEmail,
                                      context),
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (val!.isNotEmpty &&
                                    !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                        .hasMatch(val)) {
                                  return context.resources.strings
                                      .changeUserInfoEnterValidEmail;
                                }
                                if (val == null || val.isEmpty) {
                                  return context.resources.strings
                                      .changeUserInfoEnterValidEmail;
                                }
                                return null;
                              },
                            ),
                            decoration:
                                ThemeLoginHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 30.0),
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
                                      .resources.strings.changeUserInfoRegister
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
