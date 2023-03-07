import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Model/my_flutter_app_icons.dart';
import 'package:projet2cp/Model/plant.dart';
import 'package:projet2cp/Widgets/Style.dart';
class FormPlante extends StatefulWidget {
  const FormPlante({Key? key}) : super(key: key);

  @override
  State<FormPlante> createState() => _FormPlanteState();
}

class _FormPlanteState extends State<FormPlante> {
  int rImg = 0;
  final plant_NameController = TextEditingController();
  final nom = TextEditingController();
  final min_TempController = TextEditingController();
  final max_TempController = TextEditingController();
  String? moisture;
  String? humidity;
  List<String>etat=['high','low','normal'];
  List<String>etatF=['haut','bas','normal'];
  List<ImageProvider> img = [
    AssetImage(
      'images/plante0.png',
    ),
    AssetImage(
      'images/plante1.png',
    ),
    AssetImage(
      'images/plante2.png',
    ),
    AssetImage(
      'images/plante3.png',
    ),
    AssetImage(
      'images/plante4.png',
    ),
    AssetImage(
      'images/plante5.png',
    ),
    AssetImage(
      'images/plante6.png',
    ),
  ];
  ImageProvider? _currentImg;
  @override
  Widget build(BuildContext context) {
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
                  Navigator.pushReplacementNamed(context, '/monJardin');
                },
                icon: const Icon(Icons.undo),
                color: Colors.black,
              ),
              Text(
                'Nouvelle plante',
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
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(229, 228, 216, 1.0),
                  ),
                  borderRadius: BorderRadius.circular(100),
                  color: Color.fromRGBO(229, 228, 216, 1.0),
                ),
                child: DropdownButton<ImageProvider>(
                  icon: Icon(
                    MyFlutterApp.pencil,
                    textDirection: TextDirection.ltr,
                  ),
                  underline: Container(),
                  itemHeight: 200,
                  alignment: Alignment.center,
                  focusColor: Color.fromRGBO(229, 228, 216, 1.0),
                  dropdownColor: Color.fromRGBO(229, 228, 216, 1.0),
                  value: _currentImg,
                  items: img.map<DropdownMenuItem<ImageProvider>>(
                          (ImageProvider image) {
                        return DropdownMenuItem<ImageProvider>(
                            value: image,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: CircleAvatar(
                                backgroundImage: image,
                                radius: 100,
                                backgroundColor: Colors.transparent,
                              ),
                            ));
                      }).toList(),
                  onChanged: (ImageProvider? value) {
                    setState(() {
                      _currentImg = value!;
                      rImg =
                          img.indexWhere((element) => element == _currentImg);
                    });
                  },
                ),
              ),
            ),
          ),
          Text(
            "Entrez le type de votre plante : ",
            style: Style.Space16,
            textAlign: TextAlign.left,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: plant_NameController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'Type',
                hintStyle: Style.Space16,
                fillColor: Color.fromRGBO(229, 228, 216, 1.0),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.5,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(8, 76, 97, 1.0),
                    width: 1.5,
                  ),
                ),
                suffixIcon: Icon(
                  MyFlutterApp.pencil,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Text(
            "Précisez l'humidité de l'air : ",
            style: Style.Space16,
            textAlign: TextAlign.left,
          ),
          Card(
            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
            color: Color.fromRGBO(229, 228, 216, 1.0),
            shadowColor: Colors.white,
            child: DropdownButton<String>(
              icon: Icon(MyFlutterApp.continue_icon),
              focusColor: Color.fromRGBO(229, 228, 216, 1.0),
              underline: Container(),
              isExpanded: true,
              dropdownColor: Color.fromRGBO(229, 228, 216, 1.0),
              value: humidity,
              items: etat.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    '  $value ',
                    style: Style.Verona18,
                    textAlign: TextAlign.left,
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  humidity = newValue!;
                });
              },
            ),
          ),
          Text(
            "Précisez l'humidité du sol : ",
            style: Style.Space16,
            textAlign: TextAlign.left,
          ),
          Card(
            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
            color: Color.fromRGBO(229, 228, 216, 1.0),
            shadowColor: Colors.white,
            child: DropdownButton<String>(
              icon: Icon(MyFlutterApp.continue_icon),
              focusColor: Color.fromRGBO(229, 228, 216, 1.0),
              underline: Container(),
              isExpanded: true,
              dropdownColor: Color.fromRGBO(229, 228, 216, 1.0),
              value: moisture,
              items: etat.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    '  $value',
                    style: Style.Verona18,
                    textAlign: TextAlign.left,
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  moisture = newValue!;
                });
              },
            ),
          ),
          Text(
            "Précisez la température minimale : ",
            style: Style.Space16,
            textAlign: TextAlign.left,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: min_TempController,
              cursorColor: Colors.black,
              keyboardType: TextInputType.numberWithOptions(signed: true,decimal: true),
              decoration: InputDecoration(
                hintText: 'température minimale',
                hintStyle: Style.Space16,

                fillColor: Color.fromRGBO(229, 228, 216, 1.0),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.5,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(8, 76, 97, 1.0),
                    width: 1.5,
                  ),
                ),
                suffixIcon: Icon(
                  MyFlutterApp.pencil,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Text(
            "Précisez la température maximal : ",
            style: Style.Space16,
            textAlign: TextAlign.left,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: max_TempController,
              cursorColor: Colors.black,
              keyboardType: TextInputType.numberWithOptions(signed: true,decimal: true),
              decoration: InputDecoration(
                hintText: 'température maximale',
                hintStyle: Style.Space16,
                fillColor: Color.fromRGBO(229, 228, 216, 1.0),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.5,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(8, 76, 97, 1.0),
                    width: 1.5,
                  ),
                ),
                suffixIcon: Icon(
                  MyFlutterApp.pencil,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Text(
            "Donner un nom à votre plante : ",
            style: Style.Space16,
            textAlign: TextAlign.left,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: nom,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'nom',
                hintStyle: Style.Space16,
                fillColor: Color.fromRGBO(229, 228, 216, 1.0),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.5,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(8, 76, 97, 1.0),
                    width: 1.5,
                  ),
                ),
                suffixIcon: Icon(
                  MyFlutterApp.pencil,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 100,
            ),
            shadowColor: Colors.grey,
            child: Hero(
              tag: "ajout",
              child: RaisedButton(
                onPressed: () {
                  Plant p=new Plant(
                    plant_Name: plant_NameController.text,
                    plant_currentName: '',
                    plant_Desc: '',
                    plant_Type: "plante d'interieur",
                    moisture: moisture,
                    humidity: humidity,
                    conseils: '',
                    max_Temp: max_TempController.text,
                    min_Temp: min_TempController.text,
                  );
                  FirebaseFirestore.instance
                      .collection('Requête')
                      .doc('Plante1')
                      .set({
                    'plant_Name': p.plant_Name,
                    'min_Temp': p.min_Temp,
                    'max_Temp': p.max_Temp,
                    'moisture': p.moisture,
                    'humidity': p.humidity,
                  });
                  Navigator.pushReplacementNamed(context, '/monJardin',
                      arguments: {
                        'plante':p,
                        'nom':nom.text as String,
                        'image':rImg,
                      });
                },
                child: Text('Ajouter',
                    style: Style.Space12.copyWith(
                      color: Colors.white,
                    )),
                color: Color.fromRGBO(210, 146, 111, 1.0),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
