import 'package:flutter/material.dart';
import 'package:form_app/screen/formulaire/widget/element_text.dart';
import 'package:form_app/screen/page_debut/widgets/my_header.dart';

class FormulaireScreen extends StatefulWidget {

  @override
  _FormulaireScreenState createState() => _FormulaireScreenState();
}

class _FormulaireScreenState extends State<FormulaireScreen> {

  double offset = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulaire"),
        backgroundColor:
      Color(0xFF11249F),

      ),
      body: Column(
        children: [
            Container(
              height: 150,
              color: Colors.red,
            ),
          ElementTextItem(
            // icon: LineAwesomeIcons.history,
            text: 'Historique de réponse',
          ),
          Text(
            "Patrick",
            style: TextStyle(
              fontSize: 50
            ),
          )
        ],
      ),
    );
  }
}
