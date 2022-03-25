import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class loginCard extends StatelessWidget {
  bool passwordInvisible = true;

  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;
  // final String? errorText;

   loginCard({Key key, this.controllerEmail, this.controllerPassword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Connexion",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(45),
                    fontFamily: "Poppins-Bold",
                    letterSpacing: .6)),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Text("Email",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: ScreenUtil().setSp(26))),
            TextField(
              controller: controllerEmail,
              decoration: InputDecoration(
                  hintText: "Entrez votre Email",
                  errorText: _errorText,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Text("Mot de passe",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: ScreenUtil().setSp(26))),
            TextFormField(
              obscureText: true,
              controller: controllerPassword,
              decoration: InputDecoration(
                errorText: _errorText,
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordInvisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black,
                    ), onPressed: () {  },
                  ),
                  hintText: "Entrez votre mot de passe",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(35),
            ),
          ],
        ),
      ),
    );
  }

  String get _errorText {
    // at any time, we can get the text from _controller.value.text
    final textEmail = controllerEmail.value.text;
    final textPassword = controllerPassword.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (textEmail.isEmpty) {
      return 'Ne peut être vide';
    }
    if (textPassword.length < 6) {
      return 'Mot de passe trop court';
    }
    // return null if the text is valid
    return null;
  }
}
