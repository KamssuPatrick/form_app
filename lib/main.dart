import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_app/screen/page_debut/login_screen.dart';
import 'package:form_app/screen/premierePage.dart';
import 'package:form_app/screen/statistiques/view_models/view_models.dart';
import 'package:form_app/screen/wrapper.dart';
import 'package:provider/provider.dart';

Future  main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // await initialization(null);
  runApp(const MyApp());
}

Future initialization(BuildContext context) async {
  await Future.delayed(Duration(seconds: 2));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: ()=> MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ViewModel())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: Wrapper(),
        ),
      ),
    );
  }
}

