import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_app/screen/page_debut/utils/constant.dart';
import 'package:form_app/screen/statistiques/repository.dart';
import 'package:form_app/screen/statistiques/widget/app_bar_stat.dart';

class DetailAutreScreen extends StatefulWidget {

  final List<Map<String, dynamic>> data;
  final String userEmail;
  final String title;
  final String indicateur;

  const DetailAutreScreen({Key key, this.data, this.userEmail, this.title, this.indicateur}) : super(key: key);

  @override
  _DetailAutreScreenState createState() => _DetailAutreScreenState();
}

class _DetailAutreScreenState extends State<DetailAutreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          title: "${widget.title}",
          implyLeading: true,
          context: context,
          hasAction: true),
      body: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: widget.data.length == 0 ? Center(
            child: SvgPicture.asset("assets/icons/no_data.svg",
              height: 300,),
          ) : ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.data.length,
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return DetailFormulaire(data: snapshot.data.documents[index]);
                      //     },
                      //   ),
                      // );
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
                    title: Text("${widget.data[index][widget.indicateur]} ",
                      style: TextStyle(color: Repository.textColor(context), fontWeight: FontWeight.w500, fontSize: 20), ),
                    subtitle: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Société : ${widget.data[index]["nom_societe"]}",
                                  style: TextStyle(color: Repository.subTextColor(context), fontSize: 14)),

                              Text("${readTimestamp(widget.data[index]["temps_ajout"])}",
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
          ),
        ),
      ),
    );
  }
}
