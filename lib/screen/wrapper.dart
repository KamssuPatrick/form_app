import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:form_app/screen/accueil/accueil_screen.dart';
import 'package:form_app/screen/page_debut/login_screen.dart';


import 'package:shared_preferences/shared_preferences.dart';



class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String userEmail;
  String typeUser;
  SharedPreferences preferences;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
    // _loadScreen();

  }


  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);

    print("patrick Wrapper ${userEmail}");

    //return either Home or Authentificate widget
    // print("patrick Wrapperss ${getUserInfo()}");
    // if (userEmail == null) {
    //   return LoginPage();
    // } else {
    //   // print("patriqsdck Wrapper ${getUserInfo()}");
    //   // return Admin();
    //  return HomePage(email: userEmail,);
    // }

    if( userEmail == "" || userEmail == null)
    {
      print("patrick Wrapper ${typeUser}");
      print("patrick Wrapper ${userEmail}");
      return loginScreen();
    }
    else
    {
      return AccueilScreen();
    }


    // return LoginScreen();
  }




  Future<String> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print("icic_______${prefs.getString("UserUid")}");

    setState(() {
      userEmail = prefs.getString("email");
      typeUser = prefs.getString("statut");
    });
  }
}





