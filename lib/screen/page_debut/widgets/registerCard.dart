import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class registerCard extends StatefulWidget {
    final TextEditingController controllerNom;
    final TextEditingController? controllerEmail;
    final TextEditingController? controllerPassword;


   registerCard({Key? key, required this.controllerNom, this.controllerEmail, this.controllerPassword}) : super(key: key);
  @override
  State<registerCard> createState() => _registerCardState();
}

class _registerCardState extends State<registerCard> {
  bool passwordInvisible = true;

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
            Text("Enregistrement",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(45),
                    fontFamily: "Poppins-Bold",
                    letterSpacing: .6)),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),

            Text("Nom et prenom",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: ScreenUtil().setSp(26))),
            TextField(
              decoration: InputDecoration(
                  hintText: "Entrez votre Nom et votre prenom",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
              controller: widget.controllerNom,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Text("Email",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: ScreenUtil().setSp(26))),
            TextField(
              decoration: InputDecoration(
                  hintText: "Entrez votre Email",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              controller: widget.controllerEmail,
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
              decoration: InputDecoration(
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
              controller: widget.controllerPassword,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(35),
            ),
          ],
        ),
      ),
    );
  }
}
