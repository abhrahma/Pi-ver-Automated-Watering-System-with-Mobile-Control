import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Model/database.dart';
import 'package:projet2cp/Model/my_flutter_app_icons.dart';
import 'package:projet2cp/Model/plant.dart';
import 'package:projet2cp/Widgets/Style.dart';

class NouvellePlante extends StatefulWidget {
  const NouvellePlante({Key? key}) : super(key: key);

  @override
  State<NouvellePlante> createState() => _NouvellePlanteState();
}

class _NouvellePlanteState extends State<NouvellePlante> {
  final List<int> capteurs = [0, 1];
  List planteList = [];
  int? _currentCapteur;
  String? _currentPlante;
  int resault = 0;
  int rImg = 0;
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
  final nom = TextEditingController();
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getPlantList();
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        planteList = resultant;
      });
    }
  }
  Widget form()
  {
    return Column(
      children: [
        Text('add'),
      ],
    );
  }
  /* void showAlertDialog(BuildContext context){
    showDialog(context: context, builder:
    (BuildContext context){
      return Custo;
    });
  }*/
  @override
  Widget build(BuildContext context) {
    planteList.sort((a, b) => a['plant_Name'].compareTo(b['plant_Name']));
    List<Plant> p = [];
    planteList.forEach((element) {
      p.add(Plant(
          plant_Name: element['plant_Name'],
          plant_Type: element['plant_Type'],
          plant_currentName: element['plant_currentName'],
          plant_Desc: element['plant_Desc'],
          min_Temp: element['min_Temp'],
          max_Temp: element['max_Temp'],
          moisture: element['moisture'],
          conseils: element["conseils d'entretien"],
          humidity: element['humidity']));
    });
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
            "Selectionnez le type de plante : ",
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
              value: _currentPlante,
              items: p.map<DropdownMenuItem<String>>((plante) {
                return DropdownMenuItem<String>(
                  value: plante.plant_Name,
                  child: Text(
                    '${plante.plant_Name} ( ${plante.plant_currentName} )',
                    style: Style.Verona18,
                    textAlign: TextAlign.left,
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _currentPlante = newValue!;
                  resault = p.indexWhere(
                          (element) => element.plant_Name == _currentPlante);
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Hero(
              tag: 'form',
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/form');
                },
                child: Text(
                  "Cliquez ici si vous n'arrivez pas retrouver votre plante!",
                  style: Style.Space12,textAlign: TextAlign.right,
                ),
              ),
            ),
          ),
          Text(
            "Donnez un nom à votre plante : ",
            style: Style.Space16,
            textAlign: TextAlign.left,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: nom,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'Nom',
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
              tag: "a",
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/monJardin',
                      arguments: {
                        'plante': p[resault],
                        'nom': nom.text,
                        'image': rImg,
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

