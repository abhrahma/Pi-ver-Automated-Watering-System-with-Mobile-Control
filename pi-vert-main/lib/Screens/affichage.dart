
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projet2cp/Model/database.dart';
import 'package:projet2cp/Model/plant.dart';

class Affichage extends StatefulWidget {
  const Affichage({Key? key}) : super(key: key);
  @override
  State<Affichage> createState() => _AffichageState();
}

class _AffichageState extends State<Affichage> {
  @override
  List plantList = [];
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
        plantList = resultant;
      });
    }
  }
  Future<Widget> _getImage(BuildContext context, String imageName) async {
    Image image = Image.network('');
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image.network(
        value.toString(),
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      );
    });
    return image;
  }

  @override
  Widget build(BuildContext context) {
    plantList.sort((a, b) => a['plant_Name'].compareTo(b['plant_Name']));
    List<Plant> p = [];
    plantList.forEach((element) {
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
      appBar: AppBar(
        title: Text("Affichage"),
      ),
      body: ListView.builder(
        itemCount: p.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: (){Navigator.pushReplacementNamed(context, '/maPlante',arguments: {
                'plante':p[index],
                'surnom':'',
                'image':'images/plante4.png',
              });},
              title: Text('${p[index].plant_Name}'),
              subtitle: Text('${p[index].plant_currentName}'),
              trailing: Text('${p[index].plant_Type}'),
              leading: FutureBuilder(
                  future: _getImage(
                      context, '${p[index].plant_Name}.jpg'),
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
                        child: CircularProgressIndicator(color: Colors.teal,),
                      );
                    }
                    return Container();
                  }),
            ),
          );
        },
      ),
    );
  }



}
class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}

