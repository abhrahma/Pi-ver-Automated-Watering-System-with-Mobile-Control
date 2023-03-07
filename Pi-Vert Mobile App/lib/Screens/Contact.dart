import 'package:flutter/material.dart';
import 'package:projet2cp/Widgets/Style.dart';

class Mycontact extends StatefulWidget {
  @override
  Mycontact_State createState() => Mycontact_State();
}

class Mycontact_State extends State<Mycontact> {
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
                  'Contactez-nous',
                  style:Style.Verona.copyWith(fontSize: 30,color: Color.fromRGBO(8, 76, 97, 1),),),),
              SizedBox(height: 100.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text("En cas de problème contacter :",style: Style.Space16,),
                    Text("pi.6.vert2022@gmail.com",textAlign: TextAlign.center,style: Style.Space16.copyWith(color: Color.fromRGBO(8, 76, 97, 1),),)
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
