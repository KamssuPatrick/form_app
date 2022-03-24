import 'package:flutter/material.dart';
import 'package:form_app/screen/accueil/profile_list_item.dart';
import 'package:form_app/screen/formulaire/formulaire_screen.dart';
import 'package:form_app/screen/page_debut/login_screen.dart';
import 'package:form_app/screen/page_debut/widgets/my_header.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AccueilScreen extends StatefulWidget {
  const AccueilScreen({Key? key}) : super(key: key);

  @override
  _AccueilScreenState createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> {
  final controllers = ScrollController();
  double offset = 0;
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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


class ProfileListItems extends StatelessWidget {
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return FormulaireScreen();
                  },
                ),
              );
            },
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.history,
            text: 'Historique de réponse',
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext
                    context) =>
                        loginScreen()),
                ModalRoute.withName('/'),
              );
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
}
