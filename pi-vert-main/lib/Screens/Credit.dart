import 'package:flutter/material.dart';
import 'package:projet2cp/Widgets/Style.dart';

class Mycredit extends StatefulWidget {
  @override
  Mycredit_State createState() => Mycredit_State();
}

class Mycredit_State extends State<Mycredit> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(244, 243, 233, 1),
        body: SafeArea(
          child: Column(
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
              SizedBox(height: 25.0),
              Center(
                child: Text(
                  'Crédits',
                  style: Style.Verona.copyWith(fontSize:30,color: Color.fromRGBO(8, 76, 97, 1),),
              ),),
              SizedBox(height: 70.0),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Maria BOUSSENAH',
                      style: const TextStyle(
                        fontFamily: 'Space  Grotesk',
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Rosa BOUBAHA',
                      style: const TextStyle(
                        fontFamily: 'Space  Grotesk',
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Amina LAROUBI',
                      style: const TextStyle(
                        fontFamily: 'Space  Grotesk',
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Houda HIOUL',
                      style: const TextStyle(
                        fontFamily: 'Space  Grotesk',
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Rahma ABDELHAMID',
                      style: const TextStyle(
                        fontFamily: 'Space  Grotesk',
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Maria BAHMANE',
                      style: const TextStyle(
                        fontFamily: 'Space  Grotesk',
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 190.0),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Copyright© 2021-2022 ESI Alger ',
                      style: const TextStyle(
                        fontFamily: 'Space  Grotesk',
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Projet 2CP Tout droit réservé',
                      style: const TextStyle(
                        fontFamily: 'Space  Grotesk',
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
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
