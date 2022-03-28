import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_app/screen/statistiques/iconly/iconly_light.dart';
import 'package:form_app/screen/statistiques/repository.dart';
import 'package:gap/gap.dart';

AppBar myAppBar({ String title, String stringColor,  bool implyLeading,  BuildContext context, bool hasAction}) {
  return AppBar(
    centerTitle: true,
    title: Text(title, style: TextStyle(color: Repository.textColor(context), fontSize: 18),),
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: implyLeading == true ? Transform.scale(
        scale: 0.7,
        child: IconButton(
          icon: Icon(Icons.keyboard_backspace_rounded, size: 33, color: Repository.textColor(context)),
          onPressed: () => Navigator.pop(context),
        )
    ) : const SizedBox(),
    actions: hasAction == true
        ? const [
      Icon(IconlyBroken.Search),
      Gap(15)
    ] : null,
  );
}