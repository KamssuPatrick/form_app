import 'package:form_app/screen/accueil/accueil_screen.dart';
import 'package:form_app/screen/page_debut/widgets/LoginCard.dart';
import 'package:form_app/screen/page_debut/widgets/SocialIcons.dart';
import 'package:form_app/screen/page_debut/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_app/screen/register/register_screen.dart';
import 'package:form_app/services/auth.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

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

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final RoundedLoadingButtonController _btnController =
  new RoundedLoadingButtonController();

  final AuthService _auth = AuthService();


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
      key: _scaffoldKey,
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
                        child: RoundedLoadingButton(
                            controller: _btnController,
                            width: ScreenUtil().setWidth(330),
                            height: ScreenUtil().setHeight(100),
                            // height: 40,
                            color: Color(0xFF5d74e3),
                            child: Text("CONNEXION",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                )),
                            onPressed: () async {

                              if(_controllerEmail.text.isEmpty || _controllerPassword.text.isEmpty)
                              {
                                showInSnackBar("Vous devez remplir tous les champs");
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
                                _btnController.reset();
                              }
                              else
                              {
                                //Ici
                                if(_controllerPassword.text.length <= 6)
                                {
                                  showInSnackBar("Le mot de passe doit avoir plus de 6 caractères");
                                  _btnController.reset();
                                }
                                else
                                {
                                  dynamic result = await _auth
                                      .signInWithEmailAndPassword(
                                      _controllerEmail.text,
                                      _controllerPassword.text);

                                  if (result == null) {
                                    showInSnackBar("Une Erreur s'est produite");
                                    _btnController.reset();
                                  } else {

                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext
                                          context) =>
                                              AccueilScreen()),
                                      ModalRoute.withName('/'),
                                    );

                                  }

                                }

                              }
                            }


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

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value, style: TextStyle(color: Color(0xFF5d74e3), fontSize: 18),)));
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


}
