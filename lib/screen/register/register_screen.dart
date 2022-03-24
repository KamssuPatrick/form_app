import 'package:flutter/material.dart';
import 'package:form_app/screen/accueil/accueil_screen.dart';
import 'package:form_app/screen/page_debut/utils/constant.dart';
import 'package:form_app/screen/page_debut/widgets/LoginCard.dart';
import 'package:form_app/screen/page_debut/widgets/SocialIcons.dart';
import 'package:form_app/screen/page_debut/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_app/screen/page_debut/widgets/registerCard.dart';
import 'package:form_app/services/auth.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final controller = ScrollController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _controllerNom = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  double offset = 0;
  bool passwordInvisible = true;

  final AuthService _auth = AuthService();

  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _isSelected = false;

  final RoundedLoadingButtonController _btnController =
  new RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                        child: RoundedLoadingButton(
                      controller: _btnController,
                      width: ScreenUtil().setWidth(330),
                      height: ScreenUtil().setHeight(100),
                      // height: 40,
                      color: Color(0xFF5d74e3),
                      child: Text("ENREGISTRER",
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
                                  .registerWithEmailAndPassword(
                                  _controllerEmail.text,
                                  _controllerPassword.text, _controllerNom.text);

                              if (result == null) {
                                showInSnackBar("Une Erreur s'est produite");
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

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState!.showSnackBar(new SnackBar(content: new Text(value, style: TextStyle(color: Color(0xFF5d74e3), fontSize: 18),)));
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
