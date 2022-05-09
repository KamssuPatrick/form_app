import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_app/screen/accueil/accueil_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormulaireScreen extends StatefulWidget {
  @override
  _FormulaireScreenState createState() => _FormulaireScreenState();
}

class _FormulaireScreenState extends State<FormulaireScreen> {
  double offset = 0;
  List<String> _values = [];
  List<String> _valuesResult = [];
  List<String> _valuesResultApres = [];
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();



  String nom_entreprise, quartier_entreprise, localisation_entreprise, telephone_entreprise;
  String style_vestimentaire;
  String type_vetement, vetement_autre;
  String ou_achat_produit, ou_achat_produit_autre, moyen_approvisionnement, satisfaction_prix, modalite_paiement;
  String echelle_satisfaction;
  String commentaire_a_faire, commentaire;
  String commentaire_commercial;
  var latitude;
  var longitude;
  var position;
  var locationMessage = "";


  String userEmail, userUid, userDocument;



  StepIdentifier adresseStep;
  StepIdentifier venteStep;

  String adresse;

  _onDelete(index) {
    setState(() {
      _values.removeAt(index);
    });
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  /// This is just an example for using `TextEditingController` to manipulate
  /// the the `TextField` just like a normal `TextField`.
  _onPressedModifyTextField() {
    final text = 'Test';
    _textEditingController.text = text;
    _textEditingController.value = _textEditingController.value.copyWith(
      text: text,
      selection: TextSelection(
        baseOffset: text.length,
        extentOffset: text.length,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getUserInfo();
    getCurrentLocation();

  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
        content:
        Text("Formulaire Enregistré avec succès !"));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void getCurrentLocation() async {
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lats = position.latitude;
    var longs = position.longitude;

    setState(() {
      locationMessage = "latitude : $lats and longitude: $longs";

      latitude = lats;
      longitude = longs;
    });

    print("**********Location ${locationMessage}");
  }

  getUserInfo () async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userEmail = prefs.getString("email");
      userDocument = prefs.getString("userDocument");
      userUid = prefs.getString("userUid");
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      // MaterialApp(
      // home:
      Scaffold(
        key: _scaffoldKey,
        body: Container(
          color: Colors.white,
          child: Align(
            alignment: Alignment.center,
            child: FutureBuilder<Task>(
              future: getSampleTask(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data != null) {
                  final task = snapshot.data;
                  return SurveyKit(
                    surveyController: SurveyController(
                      onCloseSurvey: (context, resultFunction) {
                        Navigator.pop(context);
                      },
                    ),
                    onResult: (SurveyResult result) async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();

                      print(result.finishReason);
                      print("_________1${result}");
                      print("_________2${result.finishReason}");
                      print("_________3${result.results.length}");
                      print("_________31${result.results.last.results}");
                      print("_________32${result.results[2].results.toString()}");
                      print("_________4${result.id}");
                      print("_________5${venteStep}");
                      print("_________6${adresseStep}");


                      setState(() {
                        userEmail = prefs.getString("email");
                        userDocument = prefs.getString("userDocument");
                        userUid = prefs.getString("userUid");
                      });

                      int i = 0;
                      result.results.forEach((element) {
                        // print(
                        //     "logTag answer ${element.results.first.valueIdentifier}");
                        // print(
                        //     "logTag answer****** ${element.results.first.id.id}");
                        // print(
                        //     "logTag answer******* ${element.results.first.result}");

                        setState(() {
                          _valuesResult.add(element.results.first.valueIdentifier);
                        });

                        i++;
                      });

                      print("logTag answer******* ${_valuesResult.length}");
                      print("logTag answer******* ${_valuesResult}");

                      setState(() {
                        _valuesResult.removeWhere((element) => element == "Autres");
                        for(int i=0; i < _valuesResult.length; i++)
                          {
                            if(i == 13)
                              {
                                // _valuesResult[i] = _valuesResult[i++];
                                _valuesResultApres.add(_valuesResult[i+1]);

                                 if(_valuesResult[13] == "Client satisfait")
                                   {
                                     _valuesResult.insert(14, "");
                                   }
                                 else
                                   {
                                   _valuesResult.insert(14, _valuesResult[14]);
                                 }
                              }

                          }

                      });

                      // for(int i=0; i < _valuesResult.length; i++)
                      //   {
                      //     if(_valuesResult[i] == "Autres")
                      //       {
                      //         // _valuesResult[i] = _valuesResult[i++];
                      //         _valuesResultApres.add(_valuesResult[i+1]);
                      //       }
                      //     else
                      //       {
                      //         _valuesResultApres.add(_valuesResult[i]);
                      //       }
                      //   }

                      print("logTag answer******* ${_valuesResult.length}");
                      print("logTag answer******* ${_valuesResult}");
                      // print("logTag answer******* ${_valuesResultApres.length}");
                      // print("logTag answer******* ${_valuesResultApres}");


                      Map<String, dynamic> formulaireMap = {
                        "nom_societe": _valuesResult[1],
                        "quartier_entreprise": _valuesResult[2],
                        "localisation_entreprise": _valuesResult[3],
                        "telephone_entreprise": _valuesResult[4],
                        "style_vestimentaire": _valuesResult[5],
                        "type_vetement": _valuesResult[6],
                        "ou_achat_produit": _valuesResult[7],
                        "moyen_approvisionnement": _valuesResult[8],
                        "satisfaction_prix": _valuesResult[9],
                        "modalite_paiement": _valuesResult[10],
                        "echelle_satisfaction": _valuesResult[11],
                        // "commentaire_a_faire": _valuesResult[12],
                        "commentaire_client": _valuesResult[12],
                        "commentaire_commercial": _valuesResult[13],
                        "commentaire_commercial_text": _valuesResult[14],
                        "userUid": userUid,
                        "position": GeoPoint(latitude, longitude),
                        "userDocument": userDocument,
                        "email": userEmail,
                        'temps_ajout': DateTime.now().millisecondsSinceEpoch,
                      };


                      print("______________ ${formulaireMap}");
                      Firestore.instance
                          .collection("formulaire")
                          .add(formulaireMap).then((value) {
                        // Fluttertoast.showToast(msg: "Formulaire Enregistré avec succès !", toastLength: Toast.LENGTH_LONG);
                        print("______________ Snack ${value.hashCode}");

                        if(result.finishReason.toString() == "FinishReason.COMPLETED")
                        {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext
                                context) =>
                                    AccueilScreen()),
                            ModalRoute.withName('/'),
                          );
                        }
                        // _displaySnackBar(context);
                      })
                          .catchError((e) {
                        print("______________Erreur ${e.toString()}");
                      });



                    },
                    task: task,
                    showProgress: false,
                    localizations: {
                      'cancel': 'Fermer',
                      'next': 'Suivant',
                    },
                    themeData: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.fromSwatch(
                        primarySwatch: Colors.cyan,
                      ).copyWith(
                        onPrimary: Colors.white,
                      ),
                      primaryColor: Colors.cyan,
                      backgroundColor: Colors.white,
                      appBarTheme: const AppBarTheme(
                        color: Colors.white,
                        iconTheme: IconThemeData(
                          color: Colors.cyan,
                        ),
                        titleTextStyle: TextStyle(
                          color: Colors.cyan,
                        ),
                      ),
                      iconTheme: const IconThemeData(
                        color: Colors.cyan,
                      ),
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: Colors.cyan,
                        selectionColor: Colors.cyan,
                        selectionHandleColor: Colors.cyan,
                      ),
                      cupertinoOverrideTheme: CupertinoThemeData(
                        primaryColor: Colors.cyan,
                      ),
                      outlinedButtonTheme: OutlinedButtonThemeData(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            Size(150.0, 60.0),
                          ),
                          side: MaterialStateProperty.resolveWith(
                                (Set<MaterialState> state) {
                              if (state.contains(MaterialState.disabled)) {
                                return BorderSide(
                                  color: Colors.grey,
                                );
                              }
                              return BorderSide(
                                color: Colors.cyan,
                              );
                            },
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          textStyle: MaterialStateProperty.resolveWith(
                                (Set<MaterialState> state) {
                              if (state.contains(MaterialState.disabled)) {
                                return Theme.of(context)
                                    .textTheme
                                    .button
                                    ?.copyWith(
                                  color: Colors.grey,
                                );
                              }
                              return Theme.of(context)
                                  .textTheme
                                  .button
                                  ?.copyWith(
                                color: Colors.cyan,
                              );
                            },
                          ),
                        ),
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(
                            Theme.of(context).textTheme.button?.copyWith(
                              color: Colors.cyan,
                            ),
                          ),
                        ),
                      ),
                      textTheme: TextTheme(
                        headline2: TextStyle(
                          fontSize: 28.0,
                          color: Colors.black,
                        ),
                        headline5: TextStyle(
                          fontSize: 24.0,
                          color: Colors.black,
                        ),
                        bodyText2: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                        subtitle1: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    surveyProgressbarConfiguration: SurveyProgressConfiguration(
                      backgroundColor: Colors.white,
                    ),
                  );
                }
                return AccueilScreen();
              },
            ),
          ),
        ),
      )
    // )
    ;
  }

  Future<Task> getSampleTask() {
    var task = NavigableTask(
      id: TaskIdentifier(),
      steps: [
        InstructionStep(
          title: 'Bienvenue\nVotre formulaire est prêt',
          text:
          'Vos réponses aux questionnaires restent totalement anonymes, et ne sont traitées qu\'à des fins d’analyses et de manière confidentielle',
          buttonText: 'C\'est parti!',
        ),
        QuestionStep(
          title: 'Nom de l\'Entreprise',
          answerFormat: const TextAnswerFormat(
            maxLines: 2,
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),
        QuestionStep(
          title: 'Quartier',
          answerFormat: const TextAnswerFormat(
            maxLines: 2,
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),
        QuestionStep(
          title: 'Localisation',
          text: 'Lieu dit ...',
          answerFormat: const TextAnswerFormat(
            maxLines: 2,
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),
        QuestionStep(
          title: 'Numéro de téléphone',
          answerFormat: const IntegerAnswerFormat(
            hint: '697548966',
          ),
          isOptional: true,
        ),
        QuestionStep(
          title: 'Style vestimentaire',
          text: 'Dans quel style vestimentaire exercez-vous?',
          isOptional: false,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Hommes', value: 'Hommes'),
              TextChoice(text: 'Femmes', value: 'Femmes'),
              TextChoice(text: 'Enfants', value: 'Enfants'),
              TextChoice(text: 'Mixte', value: 'Mixte'),
            ],
            defaultSelection: TextChoice(text: 'Hommes', value: 'Hommes'),
          ),
        ),
        QuestionStep(
          title: 'Types de vêtements',
          text: 'Quels types de vêtements vendez-vous?',
          isOptional: false,
          answerFormat: const MultipleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Vêtements de soirée', value: 'Soirée'),
              TextChoice(text: 'Vêtements de sports', value: 'Sport'),
              TextChoice(
                  text: 'Vêtements professionnel', value: 'Professionnel'),
              TextChoice(text: 'Haut de vêtements', value: 'Haut'),
              TextChoice(text: 'Bas de vêtements', value: 'Bas'),
              TextChoice(text: 'Vêtements une pièce', value: 'Une pièce'),
              TextChoice(text: 'Autre', value: 'Autres'),
            ],
          ),
        ),
        QuestionStep(
          title: 'Type de vêtement',
          text: 'Entrez le type de vêtements vendu',
          answerFormat: const TextAnswerFormat(
            maxLines: 2,
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),
        QuestionStep(
          title: 'Où Achetez- vous vos produits?',
          isOptional: false,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Chine', value: 'Chine'),
              TextChoice(text: 'Europe', value: 'Europe'),
              TextChoice(text: 'Dubai', value: 'Dubai'),
              TextChoice(text: 'Turqui', value: 'Turqui'),
              TextChoice(text: 'Autres', value: 'Autres'),
            ],
            defaultSelection: TextChoice(text: 'Chine', value: 'Chine'),
          ),
        ),
        QuestionStep(
          title: 'Précisez le lieu d\'achat de vos produits.',
          answerFormat: const TextAnswerFormat(
            maxLines: 2,
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),
        QuestionStep(
          title: 'Quel est le moyen d\'approvisionnement?',
          isOptional: false,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(
                  text: 'Déplacement pour achats',
                  value: 'Déplacement pour achats'),
              TextChoice(
                  text: 'Livraison sur place', value: 'Livraison sur place'),
            ],
            defaultSelection: TextChoice(
                text: 'Déplacement pour achats',
                value: 'Déplacement pour achats'),
          ),
        ),
        QuestionStep(
          title: 'Satisfaction client',
          text:
          'Êtes vous satisfait de vos prix d\'achats chez vos fournisseurs actuels?',
          isOptional: true,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Oui', value: 'Oui'),
              TextChoice(text: 'Non', value: 'Non'),
            ],
            defaultSelection: TextChoice(text: 'Non', value: 'Non'),
          ),
        ),
        QuestionStep(
          title: 'Modalités',
          text: 'Quelles sont les modalités de paiement de votre fournisseur?',
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(
                  text: 'Paiements par tranche',
                  value: 'Paiements par tranche'),
              TextChoice(
                  text: 'paiement totale à l\'achat',
                  value: 'paiement totale à l\'achat'),
              TextChoice(text: ' Credit', value: ' Credit'),
            ],
          ),
        ),
        QuestionStep(
          title:
          'Sur une échelle de 1-10 à combien estimez-vous être satifait des services de votre fournisseur?',
          answerFormat: const ScaleAnswerFormat(
            step: 1,
            minimumValue: 1,
            maximumValue: 10,
            defaultValue: 5,
            minimumValueDescription: '1',
            maximumValueDescription: '10',
          ),
        ),
        QuestionStep(
          title: 'Commentaire client',
          text: 'Avez vous un autre commentaire à faire?',
          isOptional: true,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Oui', value: 'Autres'),
              TextChoice(text: 'Non', value: 'Non'),
            ],
            defaultSelection: TextChoice(text: 'Oui', value: 'Autres'),
          ),
        ),
        QuestionStep(
          title: 'Votre commentaire s\'il vous plait.',
          answerFormat: const TextAnswerFormat(
            maxLines: 5,
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),
        QuestionStep(
          title: 'Commentaire du commercial',
          text: 'Qu\'avez-vous pensez de cet interview?',
          isOptional: true,
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Client satisfait', value: 'Client satisfait'),
              TextChoice(text: 'Client difficile', value: 'Client difficile'),
              TextChoice(
                  text: 'Client non satisfait', value: 'Client non satisfait'),
            ],
            defaultSelection:
            TextChoice(text: 'Client satisfait', value: 'Client satisfait'),
          ),
        ),
        QuestionStep(
          title: 'Pourquoi?',
          answerFormat: const TextAnswerFormat(
            maxLines: 20,
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),
        CompletionStep(
          stepIdentifier: StepIdentifier(id: '321'),
          text: 'Merci d\'avoir pris le temps de répondre à nos questions',
          title: 'Terminé!',
          buttonText: 'Submit survey',
        ),
      ],
    );
    task.addNavigationRule(
      forTriggerStepIdentifier: task.steps[6].stepIdentifier,
      navigationRule: ConditionalNavigationRule(
        resultToStepIdentifierMapper: (input) {
          print('hhh ${input.toString()}');
          if (input.contains('Autres')) {
            return task.steps[7].stepIdentifier;
//            case input.contains('Autre'):
//              return task.steps[7].stepIdentifier;
//
//            default:
//              return task.steps[8].stepIdentifier;
          } else {
            return task.steps[8].stepIdentifier;
          }
        },
      ),
    );
    task.addNavigationRule(
      forTriggerStepIdentifier: task.steps[8].stepIdentifier,
      navigationRule: ConditionalNavigationRule(
        resultToStepIdentifierMapper: (input) {
          print('hhh ${input.toString()}');
          if (input.contains('Autre')) {
            return task.steps[9].stepIdentifier;
//            case input.contains('Autre'):
//              return task.steps[7].stepIdentifier;
//
//            default:
//              return task.steps[8].stepIdentifier;
          } else {
            return task.steps[10].stepIdentifier;
          }
        },
      ),
    );
    task.addNavigationRule(
      forTriggerStepIdentifier: task.steps[14].stepIdentifier,
      navigationRule: ConditionalNavigationRule(
        resultToStepIdentifierMapper: (input) {
          switch (input) {
            case "Oui":
              return task.steps[15].stepIdentifier;
            case "Non":
              return task.steps[16].stepIdentifier;
            default:
              return null;
          }
        },
      ),
    );
    task.addNavigationRule(
      forTriggerStepIdentifier: task.steps[16].stepIdentifier,
      navigationRule: ConditionalNavigationRule(
        resultToStepIdentifierMapper: (input) {
          switch (input) {
            case "Client satisfait":
              return task.steps[18].stepIdentifier;
            case "Client difficile":
              return task.steps[17].stepIdentifier;
            case "Client non satisfait":
              return task.steps[17].stepIdentifier;
            default:
              return null;
          }
        },
      ),
    );
    return Future.value(task);
  }

  Future<Task> getJsonTask() async {
    final taskJson = await rootBundle.loadString('assets/example_json.json');
    final taskMap = json.decode(taskJson);

    return Task.fromJson(taskMap);
  }
}
