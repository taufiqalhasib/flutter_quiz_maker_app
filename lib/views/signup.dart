import 'package:flutter/material.dart';
import 'package:flutter_quiz_maker_app/helper/functions.dart';
import 'package:flutter_quiz_maker_app/services/auth.dart';
import 'package:flutter_quiz_maker_app/views/home.dart';
import 'package:flutter_quiz_maker_app/views/signin.dart';
import 'package:flutter_quiz_maker_app/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  String name, email, password;

  bool _isLoading = false;

  AuthService _authService = new AuthService();

  _signUp() async{
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading = true;
      });

      Map<String, String> userData = {
        "name" : name,
        "email" : email,
        "type" : "user",
      };

      await _authService.signUpWithEmailandPassword(email, password, userData).then((value){
        if(value != null){

          setState(() {
            _isLoading = false;
          });

          HelperFunctions.saveUserLoggedInDetails(isLoggedIn: true);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Home())
          );
        }
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        centerTitle: true,
      ),
      body: _isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Name"
                ),
                onChanged: (val){
                  name = val;
                },
                validator: (val){
                  return val.isEmpty ? "Enter name" : null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Email"
                ),
                onChanged: (val){
                  email = val;
                },
                validator: (val){
                    return validateEmail(email) ? null : "Enter correct email";
                },
              ),
              SizedBox(height: 6),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Password"
                ),
                obscureText: true,
                onChanged: (val){
                  password = val;
                },
                validator: (val){
                  return (val.length < 6) ? "Password length must be 6 characters" : null;
                },
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: (){
                  _signUp();
                },
                child: orangeButton(context, "Sign Up", MediaQuery.of(context).size.width - 48, Colors.deepOrangeAccent)
              ),
              SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?", style: TextStyle(fontSize: 15.5),),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => SignIn()));
                    },
                    child: Text("Sign In", style: TextStyle(fontSize: 15.5, decoration: TextDecoration.underline),)
                  )
                ],
              ),

              SizedBox(height: 40.0)
            ],
          ),
        ),
      ),
    );
  }
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}