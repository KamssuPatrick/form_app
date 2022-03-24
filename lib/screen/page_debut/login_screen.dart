import 'package:form_app/screen/accueil/accueil_screen.dart';
import 'package:form_app/screen/page_debut/widgets/LoginCard.dart';
import 'package:form_app/screen/page_debut/widgets/SocialIcons.dart';
import 'package:form_app/screen/page_debut/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_app/screen/register/register_screen.dart';

import 'utils/CustomIcons.dart';
import 'utils/constant.dart';

class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final controller = ScrollController();
  double offset = 0;

  bool passwordInvisible = true;
  bool _isSelected = false;


  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  bool _validateEmail = false;
  bool _validatePassword = false;

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    // ScreenUtil.instance =
    //     ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader(
              image: "assets/icons/personal_info.svg",
              textTop: "",
              textBottom: "CONNEXION",
              offset: offset,
              avecBack: false,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  LoginCard(),
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

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) {
                                //       return AccueilScreen();
                                //     },
                                //   ),
                                // );

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
                                child: Text("CONNEXION",
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Nouveau ? ",
                        style: TextStyle(fontFamily: "Poppins-Medium"),
                      ),
                      InkWell(
                        onTap: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return RegisterScreen();
                              },
                            ),
                          );
                        },
                        child: Text("Enregistrez-vous",
                            style: TextStyle(
                                color: Color(0xFF5d74e3),
                                fontFamily: "Poppins-Bold")),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(50),
                  ),

                ],
              ),
            )
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
    super.dispose();
  }



  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil().setWidth(120),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  Widget radioButton(bool isSelected) => Container(
    width: 16.0,
    height: 16.0,
    padding: EdgeInsets.all(2.0),
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2.0, color: Colors.black)),
    child: isSelected
        ? Container(
      width: double.infinity,
      height: double.infinity,
      decoration:
      BoxDecoration(shape: BoxShape.circle, color: Colors.black),
    )
        : Container(),
  );

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget LoginCard ()
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
              controller: _controllerEmail,
              decoration: InputDecoration(
                  hintText: "Entrez votre Email",
                  errorText: _validateEmail ? 'Ce champ ne peut être vide' : null,
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
              controller: _controllerPassword,
              decoration: InputDecoration(
                  errorText: _validatePassword ? 'Ce champ ne peut être vide' : null,
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

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final textEmail = _controllerEmail!.value.text;
    final textPassword = _controllerPassword!.value.text;
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
