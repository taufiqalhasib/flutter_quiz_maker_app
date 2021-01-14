import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_maker_app/helper/functions.dart';
import 'package:flutter_quiz_maker_app/services/auth.dart';
import 'package:flutter_quiz_maker_app/services/database.dart';
import 'package:flutter_quiz_maker_app/views/home.dart';
import 'package:flutter_quiz_maker_app/views/signup.dart';
import 'package:flutter_quiz_maker_app/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  String email, password;

  bool _isLoading = false;

  AuthService _authService = new AuthService();

  _signIn() async{
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading = true;
      });

      await _authService.signInEmailandPassword(email, password).then((value){
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
                  hintText: "Email"
                ),
                onChanged: (val){
                  email = val;
                },
                validator: (val){
                  return val.isEmpty ? "Enter email" : null;
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
                  return val.isEmpty ? "Enter password" : null;
                },
              ),
              SizedBox(height: 24),
              GestureDetector(
                onTap: (){
                  _signIn();
                },
                child: orangeButton(context, "Sign In", MediaQuery.of(context).size.width - 48, Colors.deepOrangeAccent)
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: TextStyle(fontSize: 15.5),),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text("Sign Up", style: TextStyle(fontSize: 15.5, decoration: TextDecoration.underline),)
                  )
                ],
              ),

              SizedBox(height: 60.0)
            ],
          ),
        ),
      ),
    );
  }
}
