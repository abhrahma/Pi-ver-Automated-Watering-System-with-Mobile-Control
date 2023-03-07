import 'package:flutter/material.dart';
import 'package:projet2cp/Widgets/Style.dart';

class MyModemploi extends StatefulWidget {
  @override
  MyModemploi_State createState() => MyModemploi_State();
}

class MyModemploi_State extends State<MyModemploi> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(244, 243, 233, 1),
        body: SafeArea(
          child: ListView(
            children: [
              Row(
                children: [
                  SizedBox(width: 5.0),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                    icon: Icon(Icons.undo),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  "Mode d'emploi",
                  style: Style.Verona.copyWith(fontSize: 30,color: Color.fromRGBO(8, 76, 97, 1),),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color:Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                child:Column(
                  children: [
                    Text('Comment ajouter une nouvelle plante au jardin ?',style: Style.Verona.copyWith(fontSize: 20,color: Color.fromRGBO(8, 76, 97, 1),),textAlign: TextAlign.center,),
                    SizedBox(height: 10,),
                    Text("1- Aller à la page Nouvelle Plante en cliquant sur le bouton situé au milieu de la barre de navigation",style: Style.Space12.copyWith(fontSize: 15),),
                    Text("2- Chercher le type de votre plante dans la liste offerte par la base de données si vous ne la trouvez pas cliquer sur le bouton text affiché en dessus qui vous conduit vers un formulaire à remplire pour introduire une nouvelle plante",style: Style.Space12.copyWith(fontSize: 15),),
                    Text("3- Dans les deux cas précédant choisissez un avatar et un nom carractérisant votre plante",style: Style.Space12.copyWith(fontSize: 15),),
                    Text("4- Cliquer sur le bouton 'Ajouter' qui vous enmène vers la page Mon Jardin",style: Style.Space12.copyWith(fontSize: 15),),
                    SizedBox(height: 5,),
                  ],
                )
              ),
              SizedBox(height: 20,),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color:Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  child:Column(
                    children: [
                      Text('Comment supprimer une plante du jardin?',style: Style.Verona.copyWith(fontSize: 20,color: Color.fromRGBO(8, 76, 97, 1),),textAlign: TextAlign.center,),
                      SizedBox(height: 10,),
                      Text("- Cliquer sur le bouton situé à droite du cadre contenant les informations de la plante",style: Style.Space12.copyWith(fontSize: 15),),
                      SizedBox(height: 5,),
                    ],
                  )
              ),
              SizedBox(height: 20,),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color:Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  child:Column(
                    children: [
                      Text('Comment faire un arrosage manuel?',style: Style.Verona.copyWith(fontSize: 20,color: Color.fromRGBO(8, 76, 97, 1),),textAlign: TextAlign.center,),
                      SizedBox(height: 10,),
                      Text("1- Activer le mode manuel dans la page d'accueil.",style: Style.Space12.copyWith(fontSize: 15),),
                      Text("2- Aller vers la page Mon Jardin et cliquer sur le bouton 'détail' dans le cadre de la plante.",style: Style.Space12.copyWith(fontSize: 15),),
                      Text("3- Cliquer sur le bouton arroser dans la page carractéristique de la plante.",style: Style.Space12.copyWith(fontSize: 15),),
                      SizedBox(height: 5,),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
