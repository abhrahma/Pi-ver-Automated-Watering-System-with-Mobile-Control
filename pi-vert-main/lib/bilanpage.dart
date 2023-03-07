import 'dart:convert';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Model/my_flutter_app_icons.dart';
import 'package:projet2cp/Widgets/Style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:json_annotation/json_annotation.dart';
import 'bilanpage.dart';
import 'package:http/http.dart' as http;
import 'loginpage.dart';

class Bilanpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<Bilanpage> {
  Timer? countdownTimer=null;
  int count=0;


  Future<String> getJsonFromFirebaseRestAPI() async {
    String url = "https://system-d-arrosage-default-rtdb.firebaseio.com/Data.json";
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }

  List<ChartData> chartData = [];

  Future loadChartData() async {
    String jsonString = await getJsonFromFirebaseRestAPI();
    final jsonResponse = json.decode(jsonString);
    setState(() {
      count++;
      chartData.add(ChartData.fromJson(jsonResponse));
    });
  }
  void startTimer() {
    if(countdownTimer==null)
      countdownTimer =
          Timer.periodic(Duration(seconds: 1), (_) => loadChartData());
  }
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => startTimer());

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
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
                  'Données',
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
        backgroundColor: Color.fromRGBO(244, 243, 233, 1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      child: Text("Humidité d'air",style: Style.Space12,),
                      onPressed: () => null,
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      child: Text('Température',style: Style.Space12,),
                      onPressed: () => null,
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      child: Text('Humidité de sol',style: Style.Space12,),
                      onPressed: () => null,
                    ),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.all(10),
                child : FutureBuilder(
                    future: getJsonFromFirebaseRestAPI(),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        return SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            title: ChartTitle(text: "Humidité d'air",textStyle:Style.Space12.copyWith(fontSize: 14),),
                            series: <ChartSeries<ChartData, String>>[
                              LineSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.Time,
                                yValueMapper: (ChartData data, _) => data.Humidity,
                              )
                            ]
                        );
                      }
                      else{
                        return CircularProgressIndicator();
                      }
                    }
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.all(10),
                child: FutureBuilder(
                    future: getJsonFromFirebaseRestAPI(),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        return SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            title: ChartTitle(text: 'Humidité de sol',textStyle:Style.Space12.copyWith(fontSize: 14),),
                            series: <ChartSeries<ChartData, String>>[
                              LineSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.Time,
                                yValueMapper: (ChartData data, _) => data.Temperature,
                              )
                            ]
                        );
                      }
                      else{
                        return CircularProgressIndicator();
                      }
                    }),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.all(10),
                child: FutureBuilder(
                    future: getJsonFromFirebaseRestAPI(),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        return SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            title: ChartTitle(text: 'Temperature',textStyle:Style.Space12.copyWith(fontSize: 14),),
                            series: <ChartSeries<ChartData, String>>[
                              LineSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.Time,
                                yValueMapper: (ChartData data, _) => data.Moisture,
                              )
                            ]
                        );
                      }
                      else{
                        return CircularProgressIndicator();
                      }
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class ChartData {
  ChartData(this.Time, this.Humidity, this.Moisture, this.Temperature);

  final String Time;
  final double Humidity;
  final double Temperature;
  final double Moisture;

  factory ChartData.fromJson(Map<String, dynamic> parsedJson) {
    return ChartData(
      parsedJson['Time'].toString(),
      parsedJson['Humidity'],
      parsedJson['Temperature'],
      parsedJson['Moisture'],
    );
  }
}