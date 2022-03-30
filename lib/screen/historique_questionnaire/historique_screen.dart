import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_app/screen/detail_formulaire/detail_formulaire_screen.dart';
import 'package:form_app/screen/page_debut/utils/constant.dart';
import 'package:form_app/screen/statistiques/repository.dart';
import 'package:form_app/screen/statistiques/utils/transactions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoriqueFormScreen extends StatefulWidget {

  const HistoriqueFormScreen({Key key}) : super(key: key);

  @override
  _HistoriqueFormScreenState createState() => _HistoriqueFormScreenState();
}

class _HistoriqueFormScreenState extends State<HistoriqueFormScreen> {


  String userEmail, userUid, userDocument;


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
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Historique"
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('formulaire')
                .where('email', isEqualTo: userEmail)
                .snapshots(),
            builder: (context, snapshot){

              if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return Center(
                    child: SvgPicture.asset("assets/icons/no_data.svg",
                    height: 300,),
                  );
                }
              else if(!snapshot.hasData)
                {
                  return Center(
                    child: SvgPicture.asset("assets/icons/no_data.svg",
                    height: 300,),
                  );
                }
              else if(snapshot.data.documents.length == 0)
                {
                  return Center(
                    child: SvgPicture.asset("assets/icons/no_data.svg",
                      height: 200,),
                  );
                }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (c, index) {
                      // final trs = transactions[i];
                      return Column(
                        children: [
                          ListTile(
                            isThreeLine: true,
                            minLeadingWidth: 10,
                            minVerticalPadding: 20,
                            contentPadding: const EdgeInsets.all(0),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DetailFormulaire(data: snapshot.data.documents[index]);
                                  },
                                ),
                              );
                            },
                            leading: Container(
                                width: 50,
                                height: 50,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Repository.accentColor(context),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 1),
                                      color: Colors.white.withOpacity(0.1),
                                      blurRadius: 2,
                                      spreadRadius: 1,
                                    )
                                  ],
                                  // image: i == 0
                                  //     ? null
                                  //     : DecorationImage(
                                  //   image: AssetImage(trs['avatar']),
                                  //   fit: BoxFit.cover,
                                  // ),
                                  shape: BoxShape.circle,
                                ),
                                child:  Icon(CupertinoIcons.house_fill,
                                    color: const Color(0xFFFF736C), size: 20)
                            ),
                            title: Text("${snapshot.data.documents[index]["nom_societe"]} ",
                                style: TextStyle(color: Repository.textColor(context), fontWeight: FontWeight.w500, fontSize: 20), ),
                            subtitle: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${snapshot.data.documents[index]["localisation_entreprise"]}, lieu dit ${snapshot.data.documents[index]["quartier_entreprise"]}",
                                        style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),

                                    Text("${readTimestamp(snapshot.data.documents[index]["temps_ajout"])}",
                                      style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),
                                ]),
                              ],
                            ),
                            trailing: Text("-140",
                                style: const TextStyle(fontSize: 17, color: Colors.white)),
                          ),
                          Divider(),
                        ],
                      );
                    },
                  );


            },
          ),
        ),
      ),
    );
  }
}
