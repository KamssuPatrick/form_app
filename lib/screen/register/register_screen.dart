import 'package:flutter/material.dart';
import 'package:form_app/screen/page_debut/utils/constant.dart';
import 'package:form_app/screen/page_debut/widgets/LoginCard.dart';
import 'package:form_app/screen/page_debut/widgets/SocialIcons.dart';
import 'package:form_app/screen/page_debut/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_app/screen/page_debut/widgets/registerCard.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final controller = ScrollController();

  final _controllerNom = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  double offset = 0;
  bool passwordInvisible = true;

  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader(
              image: "assets/icons/personal_info.svg",
              textTop: "Enregistrement",
              textBottom: "",
              offset: offset,
              avecBack: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RegisterCard(),
                  SizedBox(height: ScreenUtil().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      InkWell(
                        child: Container(
                          width: ScreenUtil().setWidth(330),
                          height: ScreenUtil().setHeight(100),
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: kActiveShadowColor,
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {

                                if(_controllerEmail.text.isEmpty || _controllerPassword.text.isEmpty)
                                {
                                  if(_controllerEmail.text.isEmpty)
                                  {
                                    setState(() {
                                      _validateEmail = true;
                                    });
                                  }
                                  else
                                  {
                                    setState(() {
                                      _validatePassword = true;
                                    });
                                  }
                                }
                                else
                                {
                                  //Ici
                                }

                              },
                              child: Center(
                                child: Text("S'enregistrer",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(40),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget RegisterCard()
  {
    return Container(
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
              controller: _controllerNom,
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
              controller: _controllerEmail,
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
              controller: _controllerPassword,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(35),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerNom.dispose();
    super.dispose();
  }
}
