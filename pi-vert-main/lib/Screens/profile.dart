import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projet2cp/Model/my_flutter_app_icons.dart';
import 'package:projet2cp/Widgets/Style.dart';
import 'package:projet2cp/login_screen.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  int rImg = 0;
  List<ImageProvider> img = [
    AssetImage(
      'images/avatar0.png',
    ),
    AssetImage(
      'images/avatar1.png',
    ),
  ];
  String _currentImg='avatar0';
  void changeAvatar()
  {
    if(_currentImg=='avatar0')
      {
        _currentImg='avatar1';

      }
    else{
      _currentImg='avatar0';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(244, 243, 233, 1),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 193, 196, 1.0),
        automaticallyImplyLeading: false,
        title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/acueil");
                  },
                  icon: Icon(Icons.undo,color: Colors.black,),
                ),
                Center(
                  child: Text(
                    'Mon Profil',
                    style: Style.Verona.copyWith(fontSize: 26),
                    ),
                  ),

                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  icon: Icon(MyFlutterApp.setting,color: Colors.black,),
                ),
              ],
            ),
          ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 60.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(backgroundImage: AssetImage(
                  'images/$_currentImg.png',
                ),
                  radius: 100,
                  backgroundColor:Color.fromRGBO(229, 228, 216, 1.0),),
                IconButton(onPressed: (){
                  setState(() {
                    changeAvatar();
                  });
                }, icon: Icon(MyFlutterApp.pencil)),
              ],
            ),

            SizedBox(height: 60.0),
            Icon(Icons.email_outlined,semanticLabel: 'E_mail:',),
            buildEmail(),
            SizedBox(height: 60.0),
            Container(
              height: 43.0,
              width: 164.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 80.0),
              child: FlatButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context,"/loginScreen");
                },
                child: Text(
                  'Déconnexion',
                  style: const TextStyle(
                    fontFamily: 'Space Grotesk',
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromRGBO(189, 125, 90, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildEmail() {
  return Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.grey),
      color:Color.fromRGBO(229, 228, 216, 1.0),
    ),
    child: Text('${FirebaseAuth.instance.currentUser?.email}',style: Style.Space16,),
  );
}

