import 'package:flutter/material.dart';

class AnalitiqueScreen extends StatefulWidget {
  const AnalitiqueScreen({Key key}) : super(key: key);

  @override
  _AnalitiqueScreenState createState() => _AnalitiqueScreenState();
}

class _AnalitiqueScreenState extends State<AnalitiqueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Données analytiques"),
      ),

    );
  }
}
