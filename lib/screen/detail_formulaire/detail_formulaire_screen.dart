import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_app/screen/statistiques/repository.dart';

class DetailFormulaire extends StatefulWidget {
  final DocumentSnapshot data;
  const DetailFormulaire({Key key, this.data}) : super(key: key);

  @override
  _DetailFormulaireState createState() => _DetailFormulaireState();
}

class _DetailFormulaireState extends State<DetailFormulaire> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details, ${widget.data["nom_societe"]}"
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            ListTile(
              isThreeLine: true,
              minLeadingWidth: 10,
              minVerticalPadding: 20,
              contentPadding: const EdgeInsets.all(0),
              onTap: () {

              },
              title: Text("${widget.data["localisation_entreprise"]}, lieu dit ${widget.data["quartier_entreprise"]}",
                style: TextStyle(color: Repository.textColor(context), fontWeight: FontWeight.w500, fontSize: 20), ),
              subtitle: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),

                        Text("Localisation, lieu dit ",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),
                      ]),
                ],
              ),
            ),
            Divider(),

            ListTile(
              isThreeLine: true,
              minLeadingWidth: 10,
              minVerticalPadding: 20,
              contentPadding: const EdgeInsets.all(0),
              onTap: () {

              },
              title: Text("${widget.data["telephone_entreprise"]}",
                style: TextStyle(color: Repository.textColor(context), fontWeight: FontWeight.w500, fontSize: 20), ),
              subtitle: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),

                        Text("Numéro de téléphone",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),
                      ]),
                ],
              ),
            ),
            Divider(),

            ListTile(
              isThreeLine: true,
              minLeadingWidth: 10,
              minVerticalPadding: 20,
              contentPadding: const EdgeInsets.all(0),
              onTap: () {

              },
              title: Text("${widget.data["style_vestimentaire"]}",
                style: TextStyle(color: Repository.textColor(context), fontWeight: FontWeight.w500, fontSize: 20), ),
              subtitle: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),

                        Text("Style vestimentaire ",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),
                      ]),
                ],
              ),
            ),
            Divider(),

            ListTile(
              isThreeLine: true,
              minLeadingWidth: 10,
              minVerticalPadding: 20,
              contentPadding: const EdgeInsets.all(0),
              onTap: () {

              },
              title: Text("${widget.data["type_vetement"]}",
                style: TextStyle(color: Repository.textColor(context), fontWeight: FontWeight.w500, fontSize: 20), ),
              subtitle: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),

                        Text("Types de vêtements ",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),
                      ]),
                ],
              ),

            ),
            Divider(),

            ListTile(
              isThreeLine: true,
              minLeadingWidth: 10,
              minVerticalPadding: 20,
              contentPadding: const EdgeInsets.all(0),
              onTap: () {

              },
              title: Text("${widget.data["ou_achat_produit"]}",
                style: TextStyle(color: Repository.textColor(context), fontWeight: FontWeight.w500, fontSize: 20), ),
              subtitle: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),

                        Text("Où Achetez- vous vos produits ?",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),
                      ]),
                ],
              ),

            ),
            Divider(),

            ListTile(
              isThreeLine: true,
              minLeadingWidth: 10,
              minVerticalPadding: 20,
              contentPadding: const EdgeInsets.all(0),
              onTap: () {

              },
              title: Text("${widget.data["moyen_approvisionnement"]}",
                style: TextStyle(color: Repository.textColor(context), fontWeight: FontWeight.w500, fontSize: 20), ),
              subtitle: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),

                        Text("Quel est le moyen dapprovisionnement ?",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),
                      ]),
                ],
              ),
            ),
            Divider(),

            ListTile(
              isThreeLine: true,
              minLeadingWidth: 10,
              minVerticalPadding: 20,
              contentPadding: const EdgeInsets.all(0),
              onTap: () {

              },
              title: Text("${widget.data["satisfaction_prix"]}",
                style: TextStyle(color: Repository.textColor(context), fontWeight: FontWeight.w500, fontSize: 20), ),
              subtitle: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),

                        Text("Satisfaction client",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),
                      ]),
                ],
              ),
            ),
            Divider(),

            ListTile(
              isThreeLine: true,
              minLeadingWidth: 10,
              minVerticalPadding: 20,
              contentPadding: const EdgeInsets.all(0),
              onTap: () {

              },
              title: Text("${widget.data["modalite_paiement"]}",
                style: TextStyle(color: Repository.textColor(context), fontWeight: FontWeight.w500, fontSize: 20), ),
              subtitle: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),

                        Text("Modalités ",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),
                      ]),
                ],
              ),
            ),
            Divider(),

            ListTile(
              isThreeLine: true,
              minLeadingWidth: 10,
              minVerticalPadding: 20,
              contentPadding: const EdgeInsets.all(0),
              onTap: () {

              },
              title: Text("${widget.data["echelle_satisfaction"]}",
                style: TextStyle(color: Repository.textColor(context), fontWeight: FontWeight.w500, fontSize: 20), ),
              subtitle: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),

                        Text("Echelle de satisfaction ",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),
                      ]),
                ],
              ),
            ),
            Divider(),

            ListTile(
              isThreeLine: true,
              minLeadingWidth: 10,
              minVerticalPadding: 20,
              contentPadding: const EdgeInsets.all(0),
              onTap: () {

              },
              title: Text("${widget.data["commentaire_client"]}",
                style: TextStyle(color: Repository.textColor(context), fontWeight: FontWeight.w500, fontSize: 20), ),
              subtitle: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),

                        Text("Commentaire client",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),
                      ]),
                ],
              ),
            ),
            Divider(),

            ListTile(
              isThreeLine: true,
              minLeadingWidth: 10,
              minVerticalPadding: 20,
              contentPadding: const EdgeInsets.all(0),
              onTap: () {

              },
              title: Text("${widget.data["commentaire_commercial"]}",
                style: TextStyle(color: Repository.textColor(context), fontWeight: FontWeight.w500, fontSize: 20), ),
              subtitle: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),

                        Text("Commentaire du commercial",
                            style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),
                      ]),
                ],
              ),
            ),
            Divider(),


          ],
        ),
      ),
    );
  }
}
