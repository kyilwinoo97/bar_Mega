import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/Toasts.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _getTextFields() {
    return Expanded(
      flex: 3,
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
          if(_nameController.text.trim().isEmpty || _passwordController.text.trim().isEmpty){
            Toasts.greenToast("Please fill out all fields!");
          }else{

          }
        });
      },
    );
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
