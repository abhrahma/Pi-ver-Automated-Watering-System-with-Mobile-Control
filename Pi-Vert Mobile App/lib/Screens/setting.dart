import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Model/my_flutter_app_icons.dart';
import 'package:projet2cp/Screens/ThemeService.dart';
import 'package:projet2cp/Widgets/Style.dart';

class MySettings extends StatefulWidget {
  const MySettings({Key? key}) : super(key: key);

  @override
  _MySettingsState createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  bool activer = false;
  bool activer2 = false;
  Future<void> showAlertDialogue(BuildContext context, Widget widget) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: widget,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('ok')),
            ],
          );
        });
  }
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      FirebaseFirestore.instance
          .collection('Informations')
          .doc('System')
          .get()
          .then((value) {
        Map<String, dynamic>? p = value.data();
        setState(() {
          if (p != null) {
            activer2 = p['brumisation'];
            activer = p['notification'];
          }
        });

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(244, 243, 233, 1),
        body: SafeArea(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/acueil');
                    },
                    icon: Icon(MyFlutterApp.undo),
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              Center(
                child: Container(
                  child: Text(
                    'Pi-Vert',
                    style: Style.Verona.copyWith(
                      fontSize: 40,
                      color: Color.fromRGBO(8, 76, 97, 1),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              Container(
                padding: EdgeInsets.only(right: 15, left: 15),
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    'Langue',
                    style: Style.Verona.copyWith(
                      fontSize: 18,
                      color: Color.fromRGBO(8, 76, 97, 1),
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      await showAlertDialogue(
                        context,
                        Text(
                          'Langue : Français',
                          style: Style.Verona.copyWith(
                            fontSize: 18,
                            color: Color.fromRGBO(8, 76, 97, 1),
                          ),
                        ),
                      );
                    },
                    icon: Icon(MyFlutterApp.continue_icon),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromRGBO(244, 243, 233, 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(7.0, 8.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.only(right: 15, left: 15),
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    'Thème',
                    style: Style.Verona.copyWith(
                      fontSize: 18,
                      color: Color.fromRGBO(8, 76, 97, 1),
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      /*setState(() {
                        ThemeService().changeTheme();
                      });*/
                    },
                    icon: Icon(MyFlutterApp.setting),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromRGBO(244, 243, 233, 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(7.0, 8.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.only(right: 15, left: 15),
                margin: EdgeInsets.all(8),
                child: SwitchListTile(
                  title: Text(
                    'Notifications',
                    style: Style.Verona.copyWith(
                      fontSize: 18,
                      color: Color.fromRGBO(8, 76, 97, 1),
                    ),
                  ),
                  activeColor: Color.fromRGBO(8, 76, 97, 1),
                  inactiveThumbColor: Colors.grey[400],
                  value: activer,
                  onChanged: (bool value) {
                    setState(() {
                      if (activer == false) {
                        FirebaseFirestore.instance
                            .collection('Informations')
                            .doc('System')
                            .update({
                          'notification': true,

                        });
                        activer=true;
                      } else {
                        FirebaseFirestore.instance
                            .collection('Informations')
                            .doc('System')
                            .update({
                          'notification': false,

                        });
                        activer=false;
                      }
                    });
                  },
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromRGBO(244, 243, 233, 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(7.0, 8.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.only(right: 15, left: 15),
                margin: EdgeInsets.all(8),
                child:
                SwitchListTile(
                  title: Text(
                    'Brumisation',
                    style: Style.Verona.copyWith(
                      fontSize: 18,
                      color: Color.fromRGBO(8, 76, 97, 1),
                    ),
                  ),
                  activeColor: Color.fromRGBO(8, 76, 97, 1),
                  inactiveThumbColor: Colors.grey[400],
                  value: activer2,
                  onChanged: (bool value){
                    setState(() {
                      if (activer2 == false) {
                        FirebaseFirestore.instance
                            .collection('Informations')
                            .doc('System')
                            .update({
                          'brumisation': true,
                        });
                        activer2=true;
                      } else {
                        FirebaseFirestore.instance
                            .collection('Informations')
                            .doc('System')
                            .update({
                          'brumisation': false,

                        });
                        activer2=false;
                      }
                    });
                  },
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromRGBO(244, 243, 233, 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(7.0, 8.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.only(right: 15, left: 15),

                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    "Mode d'emploi",
                    style: Style.Verona.copyWith(
                      fontSize: 18,
                      color: Color.fromRGBO(8, 76, 97, 1),
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/Modemploi');
                    },
                    icon: Icon(MyFlutterApp.continue_icon),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromRGBO(244, 243, 233, 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(7.0, 8.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.only(right: 15, left: 15),
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    'Crédits',
                    style: Style.Verona.copyWith(
                      fontSize: 18,
                      color: Color.fromRGBO(8, 76, 97, 1),
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/Credit');
                    },
                    icon: Icon(MyFlutterApp.setting),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromRGBO(244, 243, 233, 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(7.0, 8.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.only(right: 15, left: 15),
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    'Contactez-nous',
                    style: Style.Verona.copyWith(
                      fontSize: 18,
                      color: Color.fromRGBO(8, 76, 97, 1),
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/Contact');
                    },
                    icon: Icon(MyFlutterApp.setting),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromRGBO(244, 243, 233, 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(7.0, 8.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
