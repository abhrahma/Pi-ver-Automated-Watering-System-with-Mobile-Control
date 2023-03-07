import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Model/my_flutter_app_icons.dart';
import 'package:projet2cp/Model/plant.dart';
import 'package:projet2cp/Widgets/Style.dart';

class MonJardin extends StatefulWidget {
  const MonJardin({Key? key}) : super(key: key);

  @override
  State<MonJardin> createState() => _MonJardinState();
}

class _MonJardinState extends State<MonJardin> {
  List<Plant> myPlants = [];
  List<String> nom = [];
  List<String> img = [];
  @override
  void initState() {
    // TODO: implement initState

      nom = [];
      img = [];
      myPlants = [];
      FirebaseFirestore.instance
          .collection('Informations')
          .doc('Plante 1')
          .get()
          .then((value) {
        Map<String, dynamic>? p = value.data();
        if ((p != null)&&(!myPlants.isNotEmpty)){
          setState(() {
          nom.add(p['surnom']!);
          img.add('images/${p['image']!}.png');
          myPlants.add(Plant(
              plant_Name: p['plant_Name'],
              plant_Type: p["plant_Type"],
              plant_currentName: p['plant_currentName'],
              plant_Desc: p['plant_Desc'],
              min_Temp: p['min_Temp'],
              max_Temp: p['max_Temp'],
              moisture: p['moisture'],
              conseils: p["conseils d'entretien"],

                humidity: p['humidity']));
          });
          }
        ;
      });

    super.initState();
  }
  Future<void> showAlertDialogue(BuildContext context, Widget widget) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: widget,
            actions: [
              FlatButton(
                  onPressed: () {
                    FirebaseFirestore.instance.collection('Informations').doc('Plante 1').delete();
                    setState(() {
                      myPlants.removeAt(0);
                    });


                    Navigator.of(context).pop();
                  },
                  child: Text('oui',style: Style.Space16
                    ,)),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('non',style: Style.Space16)),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      Map<String?, dynamic?> data =
          ModalRoute.of(context)?.settings.arguments as Map<String?, dynamic>;
      myPlants.add(data['plante']);
      nom.add(data['nom']);
      img.add('images/plante${data['image']}.png');
      FirebaseFirestore.instance
          .collection('Informations')
          .doc('Plante 1')
          .set({
        'plant_Name': data['plante'].plant_Name,
        'surnom': data['nom'],
        'min_Temp': data['plante'].min_Temp,
        'max_Temp': data['plante'].max_Temp,
        'moisture': data['plante'].moisture,
        'humidity': data['plante'].humidity,
        'image': 'plante${data['image']}',
        'plant_Desc': data['plante'].plant_Desc,
        "conseils d'entretien": data['plante'].conseils,
        'plant_currentName': data['plante'].plant_currentName,
        'plant_Type': data['plante'].plant_Type,
      });
    }
    if (myPlants.isEmpty) {
      return Scaffold(
        backgroundColor: Color.fromRGBO(244, 243, 233, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(0, 193, 196, 1.0),
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/acueil');
                  },
                  icon: const Icon(Icons.undo),
                  color: Colors.black,
                ),
                Text(
                  'Mon jardin',
                  style: Style.Verona,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/settings');
                  },
                  icon: const Icon(MyFlutterApp.setting),
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(MyFlutterApp.sprout),
                    Text(
                      "  Pas encore de plante!",
                      style: Style.Space16,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Image(
                  image: AssetImage('images/vide.png'),
                ),
                Text(
                  'Ajoutez une plante en cliquant sur le bouton ci-dessous',
                  style: Style.Space16,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 12,
                ),
                Center(child: Icon(MyFlutterApp.next__1_)),
              ],
            ),
          ),
        ),
      );
    } else {
      if (myPlants != null && myPlants.length > 0) {
        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 243, 233, 1),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromRGBO(0, 193, 196, 1.0),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/acueil');
                    },
                    icon: const Icon(Icons.undo),
                    color: Colors.black,
                  ),
                  Text(
                    'Mon jardin',
                    style: Style.Verona,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/settings');
                    },
                    icon: const Icon(MyFlutterApp.setting),
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: ListView.builder(
              itemCount: myPlants.length,
              itemBuilder: (context, index) {
                return SafeArea(
                  child:Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Color.fromRGBO(229, 228, 216, 1.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.all(10),
                    child: Center(
                      child: ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          child: Image.asset(
                            '${img[index]}',
                          ),
                        ),
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${myPlants[index].plant_Name}',
                              style: Style.Verona.copyWith(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '${nom[index]}',
                              style: Style.Space16,
                            ),
                            Card(
                              color: Colors.transparent,
                              shadowColor: Colors.grey,
                              elevation: 0,
                              child: Hero(
                                tag: "détail",
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/maPlante',
                                        arguments: {
                                          'plante': myPlants[index],
                                          'surnom': nom[index],
                                          'image': img[index],
                                        });
                                  },
                                  child: Text('détail',
                                      style: Style.Space12.copyWith(
                                        color: Colors.white,
                                      )),
                                  color: Color.fromRGBO(189, 125, 90, 1.0),
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              showAlertDialogue(context, Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.delete),
                                  Text('Supprimer ?',style: Style.Space16,),
                                ],
                              ));
                            },
                            icon: Icon(
                              MyFlutterApp.more__1_,
                            )),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      } else {
        return Container(
          color: Colors.teal,
          height: 50,
          width: 50,
        );
      }
    }
  }
}
