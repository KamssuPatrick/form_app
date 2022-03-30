import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_banking_app/json/transactions.dart';
// import 'package:flutter_banking_app/repo/repository.dart';
// import 'package:flutter_banking_app/utils/layouts.dart';
// import 'package:flutter_banking_app/utils/styles.dart';
// import 'package:flutter_banking_app/widgets/my_app_bar.dart';
import 'package:form_app/screen/statistiques/repository.dart';
import 'package:form_app/screen/statistiques/utils/assets.dart';
import 'package:form_app/screen/statistiques/utils/layouts.dart';
import 'package:form_app/screen/statistiques/utils/styles.dart';
import 'package:form_app/screen/statistiques/utils/transactions.dart';
import 'package:form_app/screen/statistiques/widget/app_bar_stat.dart';
import 'package:gap/gap.dart';
import 'dart:math' as math;

class Stats extends StatefulWidget {
  const Stats({Key key}) : super(key: key);

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {

  bool showAvg = false;

  int nombreHommeSV =0;
  int nombreFemmeSV =0;
  int nombreEnfantSV =0;
  int nombreMixteSV =0;

  int nombreVetementSoiree = 0;
  int nombreVetementSport = 0;
  int nombreVetementProfessionnel = 0;
  int nombreVetementHaut = 0;
  int nombreVetementBas = 0;
  int nombreVetementPiece = 0;
  int nombreVetementAutre = 0;


  int nombrePaysCHine = 0;
  int nombrePaysEurope = 0;
  int nombrePaysDubai = 0;
  int nombrePaysTurqui = 0;
  int nombrePaysAutres = 0;


  int nombreMoyerDeplacement = 0;
  int nombreMoyerPlace = 0;


  int nombreSatisfactionOui = 0;
  int nombreSatisfactionNon = 0;


  int nombreModalitePaiementTranche = 0;
  int nombreModalitePaiementTotale = 0;
  int nombreModalitePaiementCredit = 0;


  int nombreEchelle0 = 0;
  int nombreEchelle1 = 0;
  int nombreEchelle2 = 0;
  int nombreEchelle3 = 0;
  int nombreEchelle4 = 0;
  int nombreEchelle5 = 0;
  int nombreEchelle6 = 0;
  int nombreEchelle7 = 0;
  int nombreEchelle8 = 0;
  int nombreEchelle9 = 0;
  int nombreEchelle10 = 0;


  int nombreCommentaireOui = 0;
  int nombreCommentaireNon = 0;

  int nombreCommentaireComercialSatisfait = 0;
  int nombreCommentaireComercialNonSatisfait = 0;
  int nombreCommentaireComercialDifficile = 0;


  double pourcentageHommeSV =0.0;
  double pourcentageFemmeSV =0.0;
  double pourcentageEnfantSV =0.0;
  double pourcentageMixteSV =0.0;


  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);
    return Scaffold(
      backgroundColor: Repository.bgColor(context),
      appBar: myAppBar(
          title: 'Stats',
          implyLeading: true,
          context: context,
          hasAction: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('formulaire')
            .snapshots(),
        builder: (context, snapshot)
        {

          if(snapshot.connectionState == ConnectionState.waiting)
          {
            return Center(
              child: SvgPicture.asset("assets/icons/no_connexion.svg",
                height: 300,),
            );
          }
          else if(!snapshot.hasData)
          {
            return Center(
              child: SvgPicture.asset("assets/icons/no_connexion.svg",
                height: 300,),
            );
          }
          else if(snapshot.data.documents.length == 0)
          {
            return Center(
              child: SvgPicture.asset("assets/icons/no_connexion.svg",
                height: 200,),
            );
          }


          // Statistiques Styles Vestimentaires
            snapshot.data.documents.forEach((element) {
                if(element["style_vestimentaire"] == "Hommes")
                  {
                    nombreHommeSV = nombreHommeSV +1;
                  }

                if(element["style_vestimentaire"] == "Femmes")
                {
                  nombreFemmeSV = nombreFemmeSV +1;
                }

                if(element["style_vestimentaire"] == "Enfants")
                {
                  nombreEnfantSV = nombreEnfantSV +1;
                }

                if(element["style_vestimentaire"] == "Mixte")
                {
                  nombreMixteSV = nombreMixteSV +1;
                }
            });


          //Statistiques Types vetements
          snapshot.data.documents.forEach((element) {
            if(element["type_vetement"] == "Soirée")
            {
              nombreVetementSoiree = nombreVetementSoiree +1;
            }

            else if(element["type_vetement"] == "Sport")
            {
              nombreVetementSport = nombreVetementSport +1;
            }

            else if(element["type_vetement"] == "Professionnel")
            {
              nombreVetementProfessionnel = nombreVetementProfessionnel +1;
            }

            else if(element["type_vetement"] == "Haut")
            {
              nombreVetementHaut = nombreVetementHaut +1;
            }

            else if(element["type_vetement"] == "Bas")
            {
              nombreVetementBas = nombreVetementBas +1;
            }

            else if(element["type_vetement"] == "Une pièce")
            {
              nombreVetementPiece = nombreVetementPiece +1;
            }

            else
            {
              nombreVetementAutre = nombreVetementAutre +1;
            }
          });


          //Statistiques Pays Achat
          snapshot.data.documents.forEach((element) {
            if(element["ou_achat_produit"] == "Chine")
            {
              nombrePaysCHine = nombrePaysCHine +1;
            }

            else if(element["ou_achat_produit"] == "Europe")
            {
              nombrePaysEurope = nombrePaysEurope +1;
            }

            else if(element["ou_achat_produit"] == "Dubai")
            {
              nombrePaysDubai = nombrePaysDubai +1;
            }

            else if(element["ou_achat_produit"] == "Turqui")
            {
              nombrePaysTurqui = nombrePaysTurqui +1;
            }

            else
            {
              nombrePaysAutres = nombrePaysAutres +1;
            }
          });


          //Statistiques Moyen Approvisionnement
          snapshot.data.documents.forEach((element) {
            if(element["moyen_approvisionnement"] == "Déplacement pour achats")
            {
              nombreMoyerDeplacement = nombreMoyerDeplacement +1;
            }

            if(element["moyen_approvisionnement"] == "Livraison sur place")
            {
              nombreMoyerPlace = nombreMoyerPlace +1;
            }

          });


          //Satisfaction Client
          snapshot.data.documents.forEach((element) {
            if(element["satisfaction_prix"] == "Oui")
            {
              nombreSatisfactionOui = nombreSatisfactionOui +1;
            }

            if(element["satisfaction_prix"] == "Non")
            {
              nombreSatisfactionNon = nombreSatisfactionNon +1;
            }

          });



          //Modalite paiement
          snapshot.data.documents.forEach((element) {
            if(element["modalite_paiement"] == "Paiements par tranche")
            {
              nombreModalitePaiementTranche = nombreModalitePaiementTranche +1;
            }

            if(element["modalite_paiement"] == "paiement totale à l\'achat")
            {
              nombreModalitePaiementTotale = nombreModalitePaiementTotale +1;
            }

            if(element["modalite_paiement"] == " Credit")
            {
              nombreModalitePaiementCredit = nombreModalitePaiementCredit +1;
            }

          });


          //Echelle Satisfaction
          snapshot.data.documents.forEach((element) {
            if(element["echelle_satisfaction"] == "1.0")
            {
              nombreEchelle1 = nombreEchelle1 +1;
            }

            if(element["echelle_satisfaction"] == "2.0")
            {
              nombreEchelle2 = nombreEchelle2 +1;
            }

            if(element["echelle_satisfaction"] == "3.0")
            {
              nombreEchelle3 = nombreEchelle3 +1;
            }

            if(element["echelle_satisfaction"] == "4.0")
            {
              nombreEchelle4 = nombreEchelle4 +1;
            }

            if(element["echelle_satisfaction"] == "5.0")
            {
              nombreEchelle5 = nombreEchelle5 +1;
            }

            if(element["echelle_satisfaction"] == "6.0")
            {
              nombreEchelle6 = nombreEchelle6 +1;
            }

            if(element["echelle_satisfaction"] == "7.0")
            {
              nombreEchelle7 = nombreEchelle7 +1;
            }

            if(element["echelle_satisfaction"] == "8.0")
            {
              nombreEchelle8 = nombreEchelle8 +1;
            }

            if(element["echelle_satisfaction"] == "9.0")
            {
              nombreEchelle9 = nombreEchelle9 +1;
            }

            if(element["echelle_satisfaction"] == "10.0")
            {
              nombreEchelle10 = nombreEchelle10 +1;
            }

          });


          // Commentaire Client
          snapshot.data.documents.forEach((element) {

            if(element["commentaire_client"] == "Non")
            {
              nombreCommentaireNon = nombreCommentaireNon +1;
            }
            else
              {
                nombreCommentaireOui = nombreCommentaireOui +1;
              }

          });


          // Commentaire commercial
          snapshot.data.documents.forEach((element) {

            if(element["commentaire_commercial"] == "Client satisfait")
            {
              nombreCommentaireComercialSatisfait = nombreCommentaireComercialSatisfait +1;
            }

            if(element["commentaire_commercial"] == "Client difficile")
            {
              nombreCommentaireComercialDifficile = nombreCommentaireComercialDifficile +1;
            }

            if(element["commentaire_commercial"] == "Client non satisfait")
            {
              nombreCommentaireComercialNonSatisfait = nombreCommentaireComercialNonSatisfait +1;
            }

          });

          return ListView(
            padding: const EdgeInsets.all(15),
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Repository.accentColor2(context),
                    border: Border.all(color: Repository.accentColor(context))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
                        child: Text("Nombre Total d'enregistrements",
                            style:
                            TextStyle(color: Repository.subTextColor(context)))),
                    Divider(
                      color: Repository.dividerColor(context),
                      thickness: 2,
                    ),
                    Container(
                        padding: const EdgeInsets.fromLTRB(20, 25, 20, 30),
                        child: Text('${snapshot.data.documents.length}',
                            style: TextStyle(
                                color: Repository.titleColor(context),
                                fontSize: 32,
                                fontWeight: FontWeight.bold))),
                  ],
                ),
              ),

              const Gap(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Statistiques',
                      style: TextStyle(
                          color: Repository.titleColor(context),
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const Gap(20),
              MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [

                    //Style Vestimentaire
                    FittedBox(
                      child: SizedBox(
                        height: size.height * 0.34,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * 0.67,
                              padding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(15)),
                                color: Styles.greenColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Hommes',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),

                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text("${nombreHommeSV}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),



                                       Row(
                                         children: [
                                           Text("Pourcentage : ",
                                               style:
                                               const TextStyle(color: Colors.white, fontSize: 15)),

                                           Text("${(nombreHommeSV * 100)/snapshot.data.documents.length} %",
                                               style:
                                               const TextStyle(color: Colors.white, fontSize: 15)),
                                         ],
                                       ),
                                     ],
                                   ),

                                  const Gap(10),

                                  Text('Femmes',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreFemmeSV}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),



                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreFemmeSV * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const Gap(10),


                                  Text('Enfants',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreEnfantSV}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),



                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreEnfantSV * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const Gap(10),


                                  Text('Mixte',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreMixteSV}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),



                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreMixteSV * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.27,
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(15)),
                                color: Styles.yellowColor,
                              ),
                              child: RotatedBox(
                                  quarterTurns: -1,
                                  child: Center(
                                      child:
                                      const FittedBox(child: const Text('Style vestimentaire', style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold))))),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // Type de vetements
                    FittedBox(
                      child: SizedBox(
                        height: size.height * 0.60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * 0.67,
                              padding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(15)),
                                color: Styles.greenColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Vêtements de soirée',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreVetementSoiree}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),

                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreVetementSoiree * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),


                                  const Gap(10),
                                  Text('Vêtements de sport',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreVetementSport}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),



                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreVetementSport * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),


                                  const Gap(10),
                                  Text('Vêtements de professionnel',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreVetementProfessionnel}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),



                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreVetementProfessionnel * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),


                                  const Gap(10),
                                  Text('Haut de vêtements',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreVetementHaut}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreVetementHaut * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),


                                  const Gap(10),
                                  Text('Bas de vêtements',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreVetementBas}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreVetementBas * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),


                                  const Gap(10),
                                  Text('Vêtements une pièce',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreVetementPiece}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreVetementPiece * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),


                                  const Gap(10),
                                  Text('Autre',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreVetementAutre}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreVetementAutre * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.27,
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(15)),
                                color: Styles.yellowColor,
                              ),
                              child: RotatedBox(
                                  quarterTurns: -1,
                                  child: Center(
                                      child:
                                      const FittedBox(child: const Text('Types de vêtements', style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold))))),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // Ou Acheter le produit
                    FittedBox(
                      child: SizedBox(
                        height: size.height * 0.44,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * 0.67,
                              padding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(15)),
                                color: Styles.greenColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Chine',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombrePaysCHine}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),

                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombrePaysCHine * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),


                                  const Gap(10),
                                  Text('Europe',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombrePaysEurope}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),



                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombrePaysEurope * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),


                                  const Gap(10),
                                  Text('Dubai',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombrePaysDubai}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),



                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombrePaysDubai * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),


                                  const Gap(10),
                                  Text('Turqui',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombrePaysTurqui}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombrePaysTurqui * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),


                                  const Gap(10),
                                  Text('Autre',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombrePaysAutres}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombrePaysAutres * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.27,
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(15)),
                                color: Styles.yellowColor,
                              ),
                              child: RotatedBox(
                                  quarterTurns: -1,
                                  child: Center(
                                      child:
                                      const FittedBox(child: const Text("Lieu d'achat des produits", style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold))))),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // Le moyen d'approvisionnement
                    FittedBox(
                      child: SizedBox(
                        height: size.height * 0.24,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * 0.67,
                              padding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(15)),
                                color: Styles.greenColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Déplacement pour achats',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreMoyerDeplacement}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreMoyerDeplacement * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const Gap(10),

                                  Text('Livraison sur place',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreMoyerPlace}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreMoyerPlace * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.27,
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(15)),
                                color: Styles.yellowColor,
                              ),
                              child: RotatedBox(
                                  quarterTurns: -1,
                                  child: Center(
                                      child:
                                      const FittedBox(child: const Text("Moyen \nd'approvisionnement", style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold))))),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // Satisfaction Client
                    FittedBox(
                      child: SizedBox(
                        height: size.height * 0.24,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * 0.67,
                              padding: const EdgeInsets.fromLTRB(16, 10, 5, 10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(15)),
                                color: Styles.greenColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('OUI',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreSatisfactionOui}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreSatisfactionOui * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const Gap(10),

                                  Text('NON',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreSatisfactionNon}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreSatisfactionNon * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.27,
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(15)),
                                color: Styles.yellowColor,
                              ),
                              child: RotatedBox(
                                  quarterTurns: -1,
                                  child: Center(
                                      child:
                                      const FittedBox(child: const Text("Satisfaction client", style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold))))),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // Les Modalite de paiement
                    FittedBox(
                      child: SizedBox(
                        height: size.height * 0.28,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * 0.67,
                              padding: const EdgeInsets.fromLTRB(16, 10, 5, 10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(15)),
                                color: Styles.greenColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Paiements par tranche',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreModalitePaiementTranche}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreModalitePaiementTranche * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const Gap(10),

                                  Text('paiement totale à l\'achat',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreModalitePaiementTotale}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreModalitePaiementTotale * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const Gap(10),

                                  Text('Credit',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreModalitePaiementCredit}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreModalitePaiementCredit * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.27,
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(15)),
                                color: Styles.yellowColor,
                              ),
                              child: RotatedBox(
                                  quarterTurns: -1,
                                  child: Center(
                                      child:
                                      const FittedBox(child: const Text("Les modalités de paiement", style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold))))),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // Echelle estimation
                    FittedBox(
                      child: SizedBox(
                        height: size.height * 0.82,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * 0.67,
                              padding: const EdgeInsets.fromLTRB(16, 10, 5, 10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(15)),
                                color: Styles.greenColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Note : 1',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreEchelle1}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),

                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreEchelle1 * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),


                                  const Gap(10),
                                  Text('Note : 2',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreEchelle2}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),



                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreEchelle2 * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),


                                  const Gap(10),
                                  Text('Note : 3',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreEchelle3}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreEchelle3 * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),


                                  const Gap(10),
                                  Text('Note : 4',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreEchelle4}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreEchelle4 * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),


                                  const Gap(10),
                                  Text('Note : 5',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreEchelle5}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreEchelle5 * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),


                                  const Gap(10),
                                  Text('Note : 6',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreEchelle6}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreEchelle6 * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),


                                  const Gap(10),
                                  Text('Note : 7',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreEchelle7}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreEchelle7 * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),


                                  const Gap(10),
                                  Text('Note : 8',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreEchelle8}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreEchelle8 * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),


                                  const Gap(10),
                                  Text('Note : 9',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreEchelle9}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreEchelle9 * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),


                                  const Gap(10),
                                  Text('Note : 10',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreEchelle10}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreEchelle10 * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.27,
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(15)),
                                color: Styles.yellowColor,
                              ),
                              child: RotatedBox(
                                  quarterTurns: -1,
                                  child: Center(
                                      child:
                                      const FittedBox(child: const Text("Notation satisfaction client", style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold))))),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // Commentaire Client
                    FittedBox(
                      child: SizedBox(
                        height: size.height * 0.24,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * 0.67,
                              padding: const EdgeInsets.fromLTRB(16, 10, 5, 10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(15)),
                                color: Styles.greenColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('OUI',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreCommentaireOui}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreCommentaireOui * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const Gap(10),

                                  Text('NON',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreCommentaireNon}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreCommentaireNon * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.27,
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(15)),
                                color: Styles.yellowColor,
                              ),
                              child: RotatedBox(
                                  quarterTurns: -1,
                                  child: Center(
                                      child:
                                      const FittedBox(child: const Text("Commentaire client", style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold))))),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // Commentaire Commercial
                    FittedBox(
                      child: SizedBox(
                        height: size.height * 0.28,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * 0.67,
                              padding: const EdgeInsets.fromLTRB(16, 10, 5, 10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(15)),
                                color: Styles.greenColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Client satisfait',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreCommentaireComercialSatisfait}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreCommentaireComercialSatisfait * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const Gap(10),

                                  Text('Client difficile',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreCommentaireComercialDifficile}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreCommentaireComercialDifficile * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const Gap(10),

                                  Text('Client non satisfait',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12)),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${nombreCommentaireComercialNonSatisfait}",
                                          style:
                                          const TextStyle(color: Colors.white, fontSize: 15)),
                                      Row(
                                        children: [
                                          Text("Pourcentage : ",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),

                                          Text("${(nombreCommentaireComercialNonSatisfait * 100)/snapshot.data.documents.length} %",
                                              style:
                                              const TextStyle(color: Colors.white, fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.27,
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(15)),
                                color: Styles.yellowColor,
                              ),
                              child: RotatedBox(
                                  quarterTurns: -1,
                                  child: Center(
                                      child:
                                      const FittedBox(child: const Text("Commentaire du commercial", style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold))))),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  LineChartData mainData() {
    List<Color> gradientColors = [
      Repository.selectedItemColor(context),
      Styles.greenColor
    ];
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            //color: Repository.selectedItemColor(context),
            strokeWidth: 1,
          );
        },
      ),
        titlesData: FlTitlesData(
        show: true,
        // rightTitles: SideTitles(showTitles: false),
        // topTitles: SideTitles(showTitles: false),
        // bottomTitles: SideTitles(
        //   showTitles: true,
        //   reservedSize: 40,
        //   interval: 1.1,
        //   getTextStyles: (context, value) => const TextStyle(color: Colors.grey, fontSize: 17),
        //   getTitles: (value) {
        //     switch (value.toInt()) {
        //       case 1:
        //         return 'S';
        //       case 2:
        //         return 'M';
        //       case 3:
        //         return 'T';
        //       case 4:
        //         return 'W';
        //       case 5:
        //         return 'T';
        //       case 6:
        //         return 'F';
        //       case 7:
        //         return 'S';
        //     }
        //     return '';
        //   },
        //   margin: 15,
        // ),
        // leftTitles: SideTitles(
        //   showTitles: false,
        //   interval: 1,
        //   getTextStyles: (context, value) => const TextStyle(
        //     color: Color(0xff67727d),
        //     fontWeight: FontWeight.bold,
        //     fontSize: 15,
        //   ),
        //   getTitles: (value) {
        //     switch (value.toInt()) {
        //       case 1:
        //         return '10k';
        //       case 3:
        //         return '30k';
        //       case 5:
        //         return '50k';
        //     }
        //     return '';
        //   },
        //   reservedSize: 32,
        //   margin: 12,
        // ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: Repository.selectedItemColor(context), width: 1),
      ),
      minX: 0,
      maxX: 9,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(1.5, 3),
            FlSpot(3.5, 5),
            FlSpot(5, 3),
            FlSpot(6.5, 4),
            FlSpot(8, 2.8),
            FlSpot(9, 3),
          ],
          isCurved: true,
          // color: gradientColors,
          barWidth: 2.5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            //applyCutOffY: true,
            //cutOffY: 100,
            // gradient:  Offset(100, 10),
            // gradient: const Offset(100, 100),
            show: true,
            color: Styles.greenColor,
          ),
        ),
      ],
    );
  }
}
