import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:form_app/models/user.dart';
import 'package:form_app/screen/page_debut/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';






class AppUser {
  final String uid;
  final DateTime creationTime;
  final String email;
  final bool emailVerified;

  AppUser({
    this.uid,
    this.creationTime,
    this.email,
    this.emailVerified,
  });
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ignore: non_constant_identifier_names
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // ignore: non_constant_identifier_names
  final DBRef = FirebaseDatabase.instance.reference();
  final Firestore _db = Firestore.instance;

  // final Firestore _db = Firestore.instance;

  static final Firestore _firestore = Firestore.instance;
  static final Firestore firestore = Firestore.instance;
  static final CollectionReference _userCollection =
  _firestore.collection(USERS_COLLECTION);

  // create user obj based on FirebaseUser
  _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  DocumentSnapshot snap;

  Map<String, String> userDataMap;

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }


  // sign in anon
  Future signInAnon() async {
    // try {
    //   UserCredential  result = await _auth.signInAnonymously();
    //   FirebaseUser user = result.user;
    //   return _appUserFromFirebaseUser(user);
    // } catch (e) {
    //   print(e.toString());
    //   return null;
    // }
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, password) async {
    String typ = null;
    if (email != null && password != null) {
      try {
        AuthResult result = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        FirebaseUser user = result.user;
        final prefs = await SharedPreferences.getInstance();

        // await DBRef.child("users")
        //     .child(user.uid)
        //     .once()
        //     .then((DataSnapshot snapshot) {
        //   // print('Data : ${snapshot.value}');
        //   typ = snapshot.value["type"];
        //   prefs.setString("nom_prenom", snapshot.value["nom_prenom"]);
        //   prefs.setString("status", snapshot.value["status"]);
        // });


        await Firestore.instance
            .collection("users")
            .where("email", isEqualTo: email)
            .getDocuments()
            .then((QuerySnapshot snapshot) {
          snapshot.documents.forEach((f) async {
            print(' ici ${f.data}}');


              // prefs.setInt("dateDeCreation", f.data['dateDeCreation']);
              // prefs.setString("profilPic", f.data['profilPic']);
              prefs.setString("nom_prenom", f.data["nom_prenom"]);
              prefs.setString("email", f.data["email"]);
              prefs.setString("createdAt", f.data["createdAt"]);
              prefs.setString("statut", f.data["statut"]);
              prefs.setString("uid", f.data["uid"]);
              prefs.setString("userDocument", f.documentID);

          });
        });
        // NotificationController.instance.takeFCMTokenWhenAppLaunch();
        // prefs.setString("UserUid", user.uid);
        prefs.setString("email", user.email);
        prefs.setString("userUid", user.uid);


        // prefs.setString("UserUid", FirebaseAuth.instance.currentUser.uid);
        prefs.setString("email", user.email);
        // prefs.setString("UserUid", user.uid);
        print(" pas123 ${user.uid}");
        // return null;
        return _userFromFirebaseUser(user);
      } catch (e) {
        print("catch signIn" + e.toString());
        return null;
      }
    } else {
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(
      String email, password, nomUser) async {
    // print("register $email $password + $username");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {

      print("register result 12 $email.");
      AuthResult result = await _auth.createUserWithEmailAndPassword(
              email: email, password: password)
          // ignore: missing_return
//          .then((value) {
//        print(value.user.uid);
//        this.writeUserDataSignUp(value.user.uid, username, email);
          ;

      Map<String, dynamic> userDataMap = {
        "nom_prenom": nomUser,
        "email": email,
        "uid": result.user.uid,
        "statut": "Employe",
        "createdAt": DateTime.now().millisecondsSinceEpoch.toString(),
      };

      prefs.setString("nom_prenom", nomUser);
      prefs.setString("email", email);
      prefs.setString("createdAt", DateTime.now().millisecondsSinceEpoch.toString());
      prefs.setString("statut", "Employe");
      prefs.setString("uid", result.user.uid);

      await Firestore.instance
          .collection("users")
          .add(userDataMap)
          .then((value) async {
        prefs.setString("userDocument", value.documentID);

        await Firestore.instance
            .collection("users")
            .document(value.documentID)
            .updateData({"userDocument": value.documentID}).catchError((e) {
          print("erreure  ${e.toString()}");
        });
      }).catchError((e) {
        print("erreure  ${e.toString()}");
      });

      print("register result 12 $result.");
      FirebaseUser user = result.user;
      this.writeUserDataSignUp(result.user.uid, email, nomUser);

      print("register result $user");
//      this.signInWithEmailAndPassword(email, password);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("catch " + e.toString());
      return null;
    }
  }





  // sign out
  Future signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.setString("userUid", "");
      prefs.setString("email", "");
      prefs.setString("statut", "");
      prefs.setString("nom_prenom", "");
      prefs.setString("userDocument", "");
      prefs.setString("userId", "");
      prefs.setString("createdAt", "");
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // write user data
  // ignore: missing_return
  Future writeUserDataSignUp(
      String uid, String email, String nomUser) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userUid", uid);
    prefs.setString("email", email);
     var dateNow = DateTime.now().millisecondsSinceEpoch;
    // await DBRef.child('users').child(uid).set({
    //   "ID" : uid,
    //  "statut": "Employe",
    //   "nom_prenom" : nomUser,
    //   "email": email,
    //   "dateEnregistrement" : dateNow
    // });
  }

  Future writeUserDataSignUpNewUser(
      String uid, String email, nomUser) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("UserUid", uid);
    prefs.setString("email", email);
    var dateNow = DateTime.now().millisecondsSinceEpoch;
    await DBRef.child('users').child(uid).set({
      "nom_prenom" : nomUser,
      "ID" : uid,
      "statut": "Employe",
      "email": email,
      "JourCreation" : dateNow
    });
  }




}
