import 'package:flutter/material.dart';

class PremierePage extends StatefulWidget {
  const PremierePage({Key? key}) : super(key: key);

  @override
  _PremierePageState createState() => _PremierePageState();
}

class _PremierePageState extends State<PremierePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(child: Image.asset("assets/images/identification.jpg", )),
          ),
          Expanded(flex: 1,
          child: Container(color: Colors.red,
          child: Center(

          ),),)
        ],
      ),
    );
  }
}
