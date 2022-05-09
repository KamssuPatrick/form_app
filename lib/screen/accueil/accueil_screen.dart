import 'package:flutter/material.dart';
import 'package:form_app/screen/accueil/profile_list_item.dart';
import 'package:form_app/screen/donnee_analytique/analitique_screen.dart';
import 'package:form_app/screen/formulaire/formulaire_screen.dart';
import 'package:form_app/screen/historique_questionnaire/historique_screen.dart';
import 'package:form_app/screen/map/map_screen.dart';
import 'package:form_app/screen/page_debut/login_screen.dart';
import 'package:form_app/screen/page_debut/widgets/my_header.dart';
import 'package:form_app/screen/statistiques/statistiques_screen.dart';
import 'package:form_app/services/auth.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccueilScreen extends StatefulWidget {
  const AccueilScreen({Key key}) : super(key: key);

  @override
  _AccueilScreenState createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> {
  final controllers = ScrollController();
  double offset = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final AuthService _auth = AuthService();

  bool _isSelected = false;

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value, style: TextStyle(color: Color(0xFF5d74e3), fontSize: 18),)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          MyHeader(
            image: "assets/icons/welcome.svg",
            textTop: "Bienvenue",
            textBottom: "",
            offset: offset,
            avecBack: false,
          ),

          Flexible(child: ProfileListItems())
        ],
      ),
    );
  }
}


class ProfileListItems extends StatefulWidget {
  @override
  State<ProfileListItems> createState() => _ProfileListItemsState();
}

class _ProfileListItemsState extends State<ProfileListItems> {
  final AuthService _auth = AuthService();

  bool isLoading = false;

  String email, statut;

  @override
  void initState() {
    super.initState();
    getInfoUser();;
  }

  getInfoUser() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      email = prefs.getString("email");
      statut = prefs.getString("statut");

    });

  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          GestureDetector(
            child: ProfileListItem(
              icon: LineAwesomeIcons.wpforms,
              text: 'Nouveau Questionnaire',
            ),
            onTap: () {

              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Center(child: Text('Localisation nécessaire')),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Bellone collecte des données de localisation pour permettre de reccupérer votre position avec précision même lorsque l'appli est fermée ou non utilisée.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                FlatButton(
                                    child: Text('Continuer', style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.green
                                    ),),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return FormulaireScreen();
                                          },
                                        ),
                                      );
                                    }),
                                FlatButton(
                                    child: Text('Fermer', style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.red
                                    )),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })
                              ])
                        ],
                      ),
                    );
                  });


            },
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HistoriqueFormScreen();
                  },
                ),
              );
            },
            child: ProfileListItem(
              icon: LineAwesomeIcons.history,
              text: 'Historique de réponse',
            ),
          ),
          statut == "Admin" ? GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Stats();
                  },
                ),
              );
            },
            child: ProfileListItem(
              icon: LineAwesomeIcons.cloud_with_moon_and_rain,
              text: 'Données Analytiques',
            ),
          ) : Container(),
          statut == "Admin" ? GestureDetector(
            onTap: () {


              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Center(child: Text('Localisation nécessaire')),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Bellone collecte des données de localisation pour permettre de reccupérer votre position avec précision même lorsque l'appli est fermée ou non utilisée.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                FlatButton(
                                    child: Text('Continuer', style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.green
                                    ),),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return MapScreen();
                                          },
                                        ),
                                      );
                                    }),
                                FlatButton(
                                    child: Text('Fermer', style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.red
                                    )),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })
                              ])
                        ],
                      ),
                    );
                  });


            },
            child: ProfileListItem(
              icon: LineAwesomeIcons.map,
              text: "Lieux d'enregistrement",
            ),
          ) : Container(),
          GestureDetector(
            onTap: () async{

              setState(() {
                print("____icic");
                isLoading = true;
              });

              // dynamic result = await _auth.signOut();
              //
              // if (result == null) {
              //   // showInSnackBar("Une Erreur s'est produite");
              //   // _btnController.reset();
              // } else {

                //open change location

                // set up the buttons
                Widget cancelButton = FlatButton(
                  child: Text('Fermer'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
                Widget continueButton = FlatButton(
                  child: Text('Continuer'),
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString("userUid", "");
                    prefs.setString("email", "");
                    prefs.setString("statut", "");
                    prefs.setString("nom_prenom", "");
                    prefs.setString("userDocument", "");
                    prefs.setString("userId", "");
                    prefs.setString("createdAt", "");


                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => loginScreen()),
                        ModalRoute.withName('/'),
                      );

                    // }
                    // else
                    // {
                    //   showInSnackBar("Erreur de déconnexion");
                    //   // _btnController.reset();
                    // }
                    // });

                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (BuildContext context) => LoginPage()),
                    //   ModalRoute.withName('/'),
                    // );
                  },
                );

                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: Text('Alert'),
                  content: Text("Voulez-vous vous déconnecter ?"),
                  actions: [
                    cancelButton,
                    continueButton,
                  ],
                );

                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );

              // }

            },
            child: ProfileListItem(
              icon: LineAwesomeIcons.alternate_sign_out,
              text: 'Se Déconnecter',
              hasNavigation: false,
            ),
          ),
        ],
      ),
    );
  }

  createLoading() {
    return Positioned(
      child: isLoading ? oldcircularprogress() : Container(),
    );
  }

  oldcircularprogress() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 130.0),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.blue),
        ),
      ),
    );
  }
}
