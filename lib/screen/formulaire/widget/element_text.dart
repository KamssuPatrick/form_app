import 'package:flutter/material.dart';
import 'package:form_app/screen/page_debut/utils/constant.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ElementTextItem extends StatelessWidget {
  // final IconData? icon;
  final String text;

  const ElementTextItem({
    // this.icon,
     this.text,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ).copyWith(
        bottom: 20,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.shade300,
      ),
      child: Center(
        child: Text("Patrick"),
      ),
    );
  }
}
