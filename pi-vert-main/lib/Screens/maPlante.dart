import 'dart:convert';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicator/progress_indicator.dart';
import 'package:projet2cp/Model/my_flutter_app_icons.dart';
import 'package:projet2cp/Model/plant.dart';
import 'package:projet2cp/Widgets/Style.dart';

class MaPlante extends StatefulWidget {
  const MaPlante({Key? key}) : super(key: key);

  @override
  State<MaPlante> createState() => _MaPlanteState();
}

class _MaPlanteState extends State<MaPlante> {
  int result = 0;
  String etat = '';
  dynamic pourcentage = 0.0;
  dynamic? brumisation;
  dynamic? brumisation0;
  dynamic? arrosage;
  dynamic? arrosage0;
  String? mode;
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

  Future<Widget> _getImage(BuildContext context, String imageName) async {
    Image image = Image.network('');
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image.network(
        value.toString(),
        width: 280,
        height: 280,
      );
    });
    return image;
  }

  DatabaseReference ref = FirebaseDatabase.instance
      .refFromURL('https://system-d-arrosage-default-rtdb.firebaseio.com/Data');
  String? data;
  Map<String, dynamic>? convertedData;
  @override
  void initState() {
    ref.onValue.listen((event) {
      setState(() {
        data = jsonEncode(event.snapshot.value);
        convertedData = jsonDecode(data!);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('Informations')
        .doc('Sortie')
        .get()
        .then((value) {
      Map<String, dynamic>? p = value.data();

      if (p != null) {
        etat = p['Etat_Plante'];
        pourcentage = p['Etat_prct'];
        brumisation = p['prochaine_brumisation'];
        brumisation0 = p['derniere_brumisation'];
        arrosage = p['prochain_arrosage'];
        arrosage0= p['dernier_arrosage'];
      }
    });
    if (ModalRoute.of(context)?.settings.arguments != null) {
      Map<String?, dynamic?> data =
          ModalRoute.of(context)?.settings.arguments as Map<String?, dynamic>;
      Plant maPlante;
      maPlante = data['plante'];
      return Scaffold(
        backgroundColor: Color.fromRGBO(244, 243, 233, 1.0),
        body: SafeArea(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/monJardin');
                      },
                      icon: Icon(
                        MyFlutterApp.undo,
                      )),
                ],
              ),
              Center(
                  child: Text(
                '${data['surnom']}',
                style: Style.Space12.copyWith(fontSize: 24),
              )),
              Center(
                  child: Text(
                '${maPlante.plant_Name}',
                style: Style.Verona18.copyWith(
                    color: Color.fromRGBO(8, 76, 97, 1), fontSize: 32),
                textAlign: TextAlign.center,
              )),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    '${data['image']}',
                    height: 200,
                    width: 200,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '${convertedData?['Humidity']} %',
                            style: Style.Space16.copyWith(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Icon(
                            MyFlutterApp.humidity,
                            size: 30,
                          ),
                        ],
                      ),
                      Container(
                        height: 1,
                        color: Colors.black,
                        width: 150,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${convertedData?['Temperature']} °c',
                              style: Style.Space16.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 30,
                          ),
                          Icon(
                            MyFlutterApp.temp,
                            size: 30,
                          ),
                        ],
                      ),
                      Container(
                        height: 1,
                        color: Colors.black,
                        width: 150,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${convertedData?['Moisture']}',
                              style: Style.Space16.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 30,
                          ),
                          Icon(
                            MyFlutterApp.moisture,
                            size: 30,
                          ),
                        ],
                      ),
                      Container(
                        height: 1,
                        color: Colors.black,
                        width: 150,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  '$etat',
                  style: Style.Space16,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Icon(Icons.face_sharp),
                  Center(
                    child: Container(
                      height: 100,
                      width: 300,
                      child: BarProgress(
                        percentage: pourcentage * 100,
                        backColor: Color.fromARGB(255, 0, 193, 196),
                        gradient:
                            LinearGradient(colors: [Colors.orange, Colors.red]),
                        showPercentage: true,
                        textStyle: Style.Space12,
                        stroke: 20,
                        round: true,
                      ),
                    ),
                  ),
                ],
              ),
              //SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Card(
                  margin: EdgeInsets.all(0),
                  color: Colors.transparent,
                  shadowColor: Colors.grey,
                  elevation: 0,
                  child: Hero(
                    tag: "arroser",
                    child: RaisedButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('Informations')
                            .doc('System')
                            .update({
                          'arroser': true,
                        });
                      },
                      child: Text('Arroser',
                          style: Style.Space12.copyWith(
                            color: Colors.white,
                            fontSize: 19,
                          )),
                      color: Color.fromRGBO(189, 125, 90, 1.0),
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 49,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: EdgeInsets.all(19),
                  child: Column(
                    children: [
                      Row(mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Historique',
                            textAlign: TextAlign.center,
                            style: Style.Verona18,
                          ),
                          IconButton(
                            onPressed: () {
                              showAlertDialogue(context, Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Le dernier arrosage était : ',
                                    style: Style.Space12.copyWith(
                                        fontSize: 14),
                                  ),
                                  Text('${arrosage0.toDate()}',
                                      style: Style.Space12.copyWith(
                                          fontSize: 14,
                                          color: Colors.cyan)),
                                  Text(
                                    'Le prochain arrosage sera : ',
                                    style: Style.Space12.copyWith(
                                        fontSize: 14),
                                  ),
                                  Text('${arrosage.toDate()}',
                                      style: Style.Space12.copyWith(
                                          fontSize: 14,
                                          color: Colors.cyan)),
                                ],
                              ));
                            },
                            icon: Icon(MyFlutterApp.view_details,),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: DatePicker(
                          DateTime.now(),
                          height: 100,
                          width: 80,
                          initialSelectedDate: DateTime.now(),
                          selectionColor: Colors.teal,
                          selectedTextColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: EdgeInsets.all(19),
                  child: Column(
                    children: [
                      Text(
                        'Brumisation',
                        style: Style.Verona18,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Votre plante n’a pas besoin de brumisation pour le moment',
                        style: Style.Space12.copyWith(fontSize: 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: Card(
                          color: Colors.transparent,
                          shadowColor: Colors.grey,
                          elevation: 1,
                          child: Hero(
                            tag: "En savoir plus",
                            child: RaisedButton(
                              onPressed: () async {
                                await showAlertDialogue(
                                    context,
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Brumiser une plante c'est vaporiser de l'eau sur son feuillage. La brumisation à l'aide d'un vaporisateur est très bénéfique à certaines plantes",
                                          textAlign: TextAlign.center,
                                          style: Style.Space12.copyWith(
                                              fontSize: 14),
                                        ),
                                        Text(
                                          'La dernière brumisation était : ',
                                          style: Style.Space12.copyWith(
                                              fontSize: 14),
                                        ),
                                        Text('${brumisation0.toDate()}',
                                            style: Style.Space12.copyWith(
                                                fontSize: 14,
                                                color: Colors.cyan)),
                                        Text(
                                          'La prochaine brumisation sera : ',
                                          style: Style.Space12.copyWith(
                                              fontSize: 14),
                                        ),
                                        Text('${brumisation.toDate()}',
                                            style: Style.Space12.copyWith(
                                                fontSize: 14,
                                                color: Colors.cyan)),
                                      ],
                                    ));
                              },
                              child: Text('En savoir plus',
                                  style: Style.Space12.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                              color: Color.fromRGBO(0, 193, 196, 1),
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 49),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 19, vertical: 19),
                  child: Column(
                    children: [
                      Text(
                        '${maPlante.plant_Desc}',
                        style: Style.Space12.copyWith(fontSize: 14),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                          future:
                              _getImage(context, '${maPlante.plant_Name}.jpg'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Container(
                                child: snapshot.data as Widget?,
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Container();
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        color: Colors.transparent,
                        shadowColor: Colors.grey,
                        elevation: 1,
                        borderOnForeground: true,
                        child: Hero(
                          tag: "conseils",
                          child: RaisedButton(
                            onPressed: () async {
                              await showAlertDialogue(
                                  context,
                                  Text(
                                    '${maPlante.conseils}',
                                    style: Style.Space12.copyWith(
                                        fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ));
                            },
                            child: Text('Conseils',
                                style: Style.Space12.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                            color: Color.fromRGBO(0, 193, 196, 1),
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 49),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}
