
import 'dart:io';

import 'package:bar_mega/common/Utils.dart';
import 'package:bar_mega/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/Toasts.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  _getTextFields() {
    return Expanded(
      flex: 6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField(
            hintText: 'Name',
            inputType: TextInputType.text,
            controller: _nameController,
            imgUrl: 'assets/images/user.png',
          ),
          const SizedBox(
            height: 30.0,
          ),
          CustomTextFormField(
            hintText: 'Password',
            inputType: TextInputType.visiblePassword,
            controller: _passwordController,
            obscureText: true,
            imgUrl: 'assets/images/password.png',
          ),
        ],
      ),
    );
  }

  _getSubmitButton() {
    return CustomElevatedButton(
      label: 'Log In',
      onPressed: () {
        setState(() {
          if (_nameController.text.trim().isEmpty ||
              _passwordController.text.trim().isEmpty) {
            Toasts.greenToast("Please fill out all fields!");
          } else {
            Utils.checkInternetConnection(context).then((value) => {
                  if (!value)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: const Duration(milliseconds: 500),
                        content: Text("No Internet Connection"),
                      )),
                    } else
                    {
                      getUserFromFireStore(),
                    }
                });
          }
        });
      },
    );
  }
  var model;

  @override
  void initState() {
    getUserLogin();
    initDeviceInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          width: size.width / 2.5,
          height: size.height / 1.5,
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Image.asset(
                    'assets/images/logo_bar_mega.png',
                    fit: BoxFit.cover,
                    height: 100,
                  )),
              _getTextFields(),
              _getSubmitButton()
            ],
          ),
        ),
      ),
    );
  }

  getUserFromFireStore() async{

    QuerySnapshot querySnapshot =  await FirebaseFirestore.instance
        .collection(Utils.firestore_collection)
        .where("name",isEqualTo: _nameController.text)
        .where("pwd",isEqualTo: this._passwordController.text)
        .get();
    if(querySnapshot.docs.isNotEmpty){
      querySnapshot.docs.forEach((element) {
        String userId = element.id;
        bool isActive = element.get("isActive");
        if(isActive){
          Toasts.greenToast("Your account was already login \n on another device!");
        }else{
          setUserToSharedPreference(userId);
          updateFireStoreData(userId);
        }
      });
    }else{
      Toasts.greenToast("Incorrect User Name or Password!");
    }
  }

  void setUserToSharedPreference(String userId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("IsLogin", true);
    prefs.setString("UserId", userId);
  }

  void updateFireStoreData(String userId) {
    FirebaseFirestore.instance
        .collection(
        Utils.firestore_collection)
        .doc(userId)
        .update({
      "isActive": true,
      "model":model

    }).then((_) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          Home()), (Route<dynamic> route) => false);
    });
  }

  void getUserLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool("IsLogin");
    if(isLogin){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          Home()), (Route<dynamic> route) => false);
    }
  }

  void initDeviceInfo() async{
    if(Platform.isAndroid){
      var build = await deviceInfoPlugin.androidInfo;
      model = build.model;
    }else if(Platform.isIOS){
      var build = await deviceInfoPlugin.iosInfo;
      model = build.model;
    }
  }
}

const kHintTextStyle =
    TextStyle(fontSize: 16.0, letterSpacing: 1.3, color: Colors.green);
const kBodyTextStyle = TextStyle(fontSize: 16.0, color: Colors.green);

const kOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide.none);

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {this.hintText,
      this.imgUrl,
      this.controller,
      this.inputType,
      this.obscureText = false});

  final String hintText;
  final String imgUrl;
  final TextEditingController controller;
  final TextInputType inputType;
  bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      keyboardType: TextInputType.text,
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(10.0),
        border: kOutlineInputBorder,
        enabledBorder: kOutlineInputBorder,
        focusedBorder: kOutlineInputBorder,
        hintText: hintText,
        hintStyle: kHintTextStyle,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(imgUrl, width: 40.0, height: 40.0),
        ),
      ),
      style: kBodyTextStyle,
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton(
      {this.label, this.onPressed, this.bgColor = Colors.green});

  final String label;
  final Function() onPressed;
  Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0.0),
            backgroundColor: MaterialStateProperty.all(bgColor),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ))),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(letterSpacing: 1.3, fontSize: 17.0),
        ),
      ),
    );
  }
}
