import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:projet2cp/Widgets/Style.dart';
import 'package:weather/weather.dart';

final Uri _url = Uri.parse('https://flutter.dev');

class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF),
      home: Scaffold(
        backgroundColor: Color(0xffF4F3E9),

        body: SingleChildScrollView (
          child: Stack(
              children: <Widget> [

                Positioned(

                  child: (DateTime.now().hour > 4) & (DateTime.now().hour < 17)  ?
                  new Container(
                    width: double.infinity,
                    child: FittedBox(
                      child:
                      new Image.asset('Assets/home.png'),
                      fit: BoxFit.fitWidth,
                    ),

                    //),
                  ): (DateTime.now().hour > 16) & (DateTime.now().hour < 20)  ?
                  new Container(
                    width: double.infinity,
                    child: FittedBox(
                      child:
                      new Image.asset('Assets/sunset.png'),
                      fit: BoxFit.fitWidth,


                    ),
                  ):new Container( width: double.infinity,
                    child: FittedBox(
                      child:
                      new Image.asset('Assets/night.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),

                Positioned(child: Container(
                  width: double.infinity,
                  height: 1650,
                  child: FittedBox(
                    child:
                    new Image.asset('Assets/home3.png'),
                  ),
                ),
                ),

                Positioned(child: Container(
                  width: double.infinity,
                  height: 1970,
                  child: FittedBox(
                    child:
                    new Image.asset('Assets/home3.png'),
                  ),
                ),
                ),




                Positioned(child: Container(
                  width: double.infinity,
                  height: 2290,
                  child: FittedBox(
                    child:
                    new Image.asset('Assets/home3.png'),
                  ),
                ),
                ),



                Positioned(
                  top: 657,
                  left: 203,
                  child: Container(
                    child: MyWidget(),
                  ),
                ),

                Positioned(
                  top: 927,
                  left: 33,

                  child: Container(
                    width: 35,
                    height: 35,
                    child:
                    new Image.asset('Assets/watering-plants.png'),

                  ),
                ),


                Positioned(
                  top: 1090,
                  left: 35,
                  child: Container(
                    width: 33,
                    height: 33,
                    child:
                    new Image.asset('Assets/settings.png'),

                  ),
                ),


                Positioned(
                  top: 780,
                  left: 35,

                  child: Container(
                    width: 35,
                    height: 35,

                    child:
                    new Image.asset('Assets/raspberry-pi.png'),

                  ),
                ),


                Positioned(
                  top: 0,
                  bottom: 1600,
                  left: 25,
                  child: Container(
                    width: 27,
                    height: 27,
                    child:
                    new Image.asset('Assets/calendar.png'),

                  ),
                ),



                Positioned(
                  top: 390,
                  right: -110,
                  child: Container(
                    width: 570,
                    height: 570,
                    child:
                    new Image.asset('Assets/planteillustration.png'),

                  ),
                ),

                Positioned(
                  top: 200,
                  right: -100,
                  child: Container(
                    width: 480,
                    height: 480,
                    child:
                    new Image.asset('Assets/pivertillustration.png'),

                  ),
                ),

                Positioned(
                  top: 790,
                  left: 75,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 170,
                    height: 170,
                    child:
                    Text(
                      'Configuration',
                      style:Style.Verona.copyWith(fontSize: 17,color:Color(0xff084C61) ) ,
                    ),

                  ),
                ),

                Positioned(
                  top: 943,
                  left: 75,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 170,
                    height: 170,
                    child:
                    Text(
                      'Mode d\'arrosage',
                      style: Style.Verona.copyWith(fontSize: 17,color:Color(0xff084C61) ) ,
                    ),

                  ),
                ),


                Positioned(
                  top: 993,
                  left: 72,
                  right: 0,
                  bottom: 0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Manuel',
                        style: Style.Space16.copyWith(fontSize: 15,color:Colors.black ) ,
                      ),

                    ],
                  ),
                ),


                Positioned(
                  top: 993,
                  left: 242,
                  right: 0,
                  bottom: 0,
                  child: Text(
                    'Automatique',
                    style: Style.Space16.copyWith(fontSize: 15,color:Colors.black ) ,
                  ),
                ),


                Positioned(
                  top: 1100,
                  left: 75,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 170,
                    height: 170,
                    child:
                    Text(
                      'Réglages',
                      style: Style.Verona.copyWith(fontSize: 17,color:Color(0xff084C61) ) ,
                    ),

                  ),
                ),

                Positioned(
                  top: 0,//30,
                  left: 0,//240,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 170,
                    height: 170,
                    child:
                    Meteo(),
                  ),


                ),

                Positioned(
                  top: 600,
                  left: 179,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 170,
                    height: 170,
                    child:
                    Text(
                      ' Vérifiez l\'état de vos \nplantes en temps réel',
                      style: Style.Space16.copyWith(fontSize: 14) ,
                    ),

                  ),
                ),

                Positioned(
                  top: 825,
                  left: 34,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    child:
                    Text(
                      'Terminez la configuration de votre\nRaspberry Pi et système d\'arrosage',
                      style: Style.Space16.copyWith(fontSize: 14) ,
                    ),

                  ),
                ),



                Positioned(
                  top: 1140,
                  left: 34,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 170,
                    height: 170,
                    child:
                    Text(
                      'Personnalisez votre experience',
                      style: Style.Space16.copyWith(fontSize: 14) ,
                    ),
                  ),

                ),
                Positioned(
                  top: -40,
                  left: 27,
                  right: 170,
                  bottom: 245,
                  child: MyHomePage(),
                ),

                Positioned(
                  top: 0,
                  left: 0,
                  right: 150,
                  bottom:1630,
                  child: Container(
                    width: 170,
                    height: 170,
                    child: Jour(),
                  ),
                ),


                Positioned(
                  top: 0,
                  left: 0,
                  right: 150,
                  bottom:1580,
                  child: Container(
                    width: 170,
                    height: 170,
                    child: Mois(),
                  ),
                ),


                Positioned(
                  top: 0,
                  left: 320,
                  right: 25,
                  bottom:690,
                  child: IconButton(
                      icon: Image.asset('Assets/continue.png'),
                      iconSize: 20,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/Modemploi');
                      }//_launchURL,

                  ),
                ),


                Positioned(
                  top: 0,
                  left: 320,
                  right: 25,
                  bottom:70,
                  child: IconButton(
                    icon: Image.asset('Assets/continue.png'),
                    iconSize: 20,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/settings');
                    },
                  ),
                ),






              ]
          ),
        ),

      ),
      //child: Center(child: FlutterLogo(size: 160)),
      //),
    );;
  }
}



class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool isChecked=false;
  String? mode;
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
            mode = p['mode'];
            if(mode=='automatique')
              {
                isChecked=true;
              }
            else{
              isChecked=false;
            }
          }
        });

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SwitchListTile(
        activeColor: Color(0xffBD7D5A),
        inactiveThumbColor: Color(0xffF4F3E9),
        inactiveTrackColor: Color(0xffBD7D5A),
        value: isChecked,
        onChanged: (bool value){
          setState(() {
            print(isChecked);
            if(isChecked==false)
            {

              FirebaseFirestore.instance
                  .collection('Informations')
                  .doc('System').update({'mode':'automatique'});
              isChecked = true;
            }
            else
            {
              FirebaseFirestore.instance
                  .collection('Informations')
                  .doc('System').update({'mode':'manuel'});
              isChecked = false;
            }
          });
        },
      ),
    );


  }



}







class MyWidget extends StatelessWidget {
  get borderRadius => BorderRadius.circular(15.0);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 0,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: () {
          },
          child: Container(
            padding: EdgeInsets.all(0.0),
            height: 26.0,//MediaQuery.of(context).size.width * .08,
            width: 121.0,//MediaQuery.of(context).size.width * .3,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: Color(0xff00C1C4),
            ),
            child: Row(
              children: <Widget>[

                Expanded(
                  child: Text(
                    'Mon jardin',
                    textAlign: TextAlign.center,
                    style:Style.Space16.copyWith(fontSize: 13,color:Color(0xffF4F3E9) ) ,

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class Jour extends StatelessWidget {
  const Jour({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center (
      child: DateFormat('EEEE').format(DateTime.now()) == 'Saturday' ?
      new Container(
          child: Text(
            'Samedi',style:Style.Verona.copyWith(fontSize: 20,color:Color(0xff084C61) ),

          )
      ):
      DateFormat('EEEE').format(DateTime.now()) == 'Friday' ?
      new Container(child: Text(
        'Vendredi',style: Style.Verona.copyWith(fontSize: 20,color:Color(0xff084C61) )),):


      DateFormat('EEEE').format(DateTime.now()) == 'Sunday' ?
      new Container(child: Text(
        'Dimanche',style: Style.Verona.copyWith(fontSize: 20,color:Color(0xff084C61) ),),):


      DateFormat('EEEE').format(DateTime.now()) == 'Monday' ?
      new Container(child: Text(
        'Lundi',style: Style.Verona.copyWith(fontSize: 20,color:Color(0xff084C61) ),),):



      DateFormat('EEEE').format(DateTime.now()) == 'Tuesday' ?
      new Container(child: Text(
        'Mardi',style: Style.Verona.copyWith(fontSize: 20,color:Color(0xff084C61) ),),):


      DateFormat('EEEE').format(DateTime.now()) == 'Wednesday' ?
      new Container(child: Text(
        'Mercredi',style: Style.Verona.copyWith(fontSize: 20,color:Color(0xff084C61) ),),):

      DateFormat('EEEE').format(DateTime.now()) == 'Thursday' ?
      new Container(child: Text(
        'Jeudi',style: Style.Verona.copyWith(fontSize: 20,color:Color(0xff084C61) ),),):
      new Container(),
    );
  }
}



class Mois extends StatelessWidget {
  const Mois({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center (
      child: DateFormat('MMM').format(DateTime.now()) == 'May' ?
      new Container(
        child: Text(
          DateFormat('dd ').format(DateTime.now())+
              'Mai',style: Style.Verona.copyWith(fontSize: 20,color:Color(0xff084C61) ),

        ),
      ):  DateFormat('MMM').format(DateTime.now()) == 'Apr' ?
      new Container(
          child: Text(
            'Avril',style: Style.Verona.copyWith(fontSize: 20,color:Color(0xff084C61) ),
          )
      ):
      DateFormat('MMM').format(DateTime.now()) == 'Jan' ?
      new Container(
          child: Text(
            'Janvier',style: Style.Verona.copyWith(fontSize: 20,color:Color(0xff084C61) ),
          )
      ):

      DateFormat('MMM').format(DateTime.now()) == 'Feb' ?
      new Container(
          child: Text(
            'Février',style: Style.Verona.copyWith(fontSize: 20,color:Color(0xff084C61) ),
          )
      ):

      DateFormat('MMM').format(DateTime.now()) == 'Mar' ?
      new Container(
          child: Text(
            'Mars',style: Style.Verona.copyWith(fontSize: 20,color:Color(0xff084C61) ),
          )
      ):

      DateFormat('MMM').format(DateTime.now()) == 'Jun' ?
      new Container(
          child: Text(
            'Juin',style: Style.Verona.copyWith(fontSize: 20,color:Color(0xff084C61) ),
          )
      ):

      DateFormat('MMM').format(DateTime.now()) == 'Jul' ?
      new Container(
          child: Text(
            'Juillet',style: Style.Verona.copyWith(fontSize: 20,color:Color(0xff084C61) ),
          )
      ):

      DateFormat('MMM').format(DateTime.now()) == 'Aug' ?
      new Container(
          child: Text(
            'Août',style: Style.Verona.copyWith(fontSize: 20,color:Color(0xff084C61) ),
          )
      ):

      DateFormat('MMM').format(DateTime.now()) == 'Sep' ?
      new Container(
          child: Text(
            'Septembre',style: Style.Verona.copyWith(fontSize: 20,color:Color(0xff084C61) ),
          )
      ):

      DateFormat('MMM').format(DateTime.now()) == 'Oct' ?
      new Container(
          child: Text(
            'Octobre',style: Style.Verona.copyWith(fontSize: 20,color:Color(0xff084C61) ),
          )
      ):

      DateFormat('MMM').format(DateTime.now()) == 'Nov' ?
      new Container(
          child: Text(
            'Novembre',style: Style.Verona.copyWith(fontSize: 20,color:Color(0xff084C61) ),
          )
      ):

      DateFormat('MMM').format(DateTime.now()) == 'Dec' ?
      new Container(
          child: Text(
            'Décembre',style: Style.Verona.copyWith(fontSize: 20,color:Color(0xff084C61) ),
          )
      ):new Container(),

    );
  }
}




enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }
class Meteo extends StatefulWidget {

  @override
  _MeteoState createState() => _MeteoState();

}

class _MeteoState extends State<Meteo> {
  String key = '63027ce7a27c0b8d5df00b05f734c987';
  late WeatherFactory ws;
  List<Weather> _data = [];
  AppState _state = AppState.NOT_DOWNLOADED;
  String? CityName = "vancouver";


  @override
  void initState() {
    super.initState();
    ws = new WeatherFactory(key);
  }


  void queryWeather() async {
    /// Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _state = AppState.DOWNLOADING;
    });

    Weather weather = await ws.currentWeatherByCityName(CityName!);
    setState(() {
      _data = [weather];
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  Widget contentFinishedDownload() {

    return Center(
      child: ListView.separated(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text((_data[index].toString()).substring((_data[index].toString()).indexOf("Temp:")+6,(_data[index].toString()).indexOf("Celsius"))+"°",
              style: Style.Space16.copyWith(fontSize: 35,color:Colors.white )
            ),

          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }



  Widget WeatherIcon() {

    return Container(
      child: ListView.separated(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          String weather = ( (_data[index].toString()).substring((_data[index].toString()).indexOf("code:")+6,(_data[index].toString()).length-4)).replaceAll("\n", "");
          print (weather);
          int weath= int.parse(weather);
          return ListTile(
            title: (( weath ==800)? Container():
            ( weath>=200 && weath<=232 )?
            Container(child: Image.asset('Assets/storm.png')):
            ( weath>=300 && weath<=321 )?
            Container(
                width:200,
                height:200,
                child: Image.asset('Assets/rain.png')): //averse
            ( weath>=500 && weath<=511 )?
            Container(width:200,
                height:200,
                child: Image.asset('Assets/rain.png')):  //pluie
            ( weath>=511 && weath<=531 )?
            Container(
                width:200,
                height:200,
                child: Image.asset('Assets/rain.png')):   //averse
            ( weath>=600 && weath<=622 )?
            Container(child: Image.asset('Assets/snow.png')):  //neige
            ( weath>=701 && weath<=781 )?
            Container(child: Image.asset('Assets/haze.png')):   //brouillard
            ( weath>=802 && weath<=804 )?
            Container(width:200,
                height:200,
                child: Image.asset('Assets/clouds.png')):  //nuageux
            ( weath==801 )?
            Container(width:170,
                height:170,
                child: Image.asset('Assets/cloud.png')):  //partiellement nuageux
            Container()

                //( weather ==" Clouds, overcast clouds ")||( weather ==" Clouds, broken clouds ")||( weather ==" Clouds, scattered clouds ")?

            ),
          );
          //Container(child: new Image.asset('Assets/home3.png')):Container(child: new Image.asset('Assets/home4.png')) );
          //Container(child:Text("clear oui")):Container(child:Text("not clear non")));


        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }




  Widget contentDownloading() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(children: [
        Text(
          'Chargement...',
          style: Style.Space16.copyWith(fontSize: 15,color:Colors.black ),
        ),
        Container(
            margin: EdgeInsets.only(top: 10),
            child: Center(child: CircularProgressIndicator(strokeWidth: 5, color: Color(0xffBD7D5A))))
      ]),
    );
  }

  Widget contentNotDownloaded() {
    return Center(
      child: Column(

        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
              '   Cliquez pour\nobtenir la météo', style: Style.Space12.copyWith(fontSize: 13,color:Colors.white ))
        ],
      ),
    );
  }

  Widget _resultView() => _state == AppState.FINISHED_DOWNLOADING
      ? contentFinishedDownload()
      : _state == AppState.DOWNLOADING
      ? contentDownloading()
      : contentNotDownloaded();



  Widget _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          child: IconButton(
            icon: Image.asset('Assets/refresh.png'),
            iconSize: 33,
            onPressed: () {queryWeather();},
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack( children: <Widget> [



      Positioned(
        top: 100,
        left: 240,
        bottom:-100,
        right: 0,
        child:
        Container(child:
        _resultView()
        ),
      ),

      Positioned(
        top: 40,
        left: 290,
        //bottom:2500,
        //right: 10,
        child:

        Container(child: _buttons(),
        ),
      ),


      Positioned(
        top: 35,
        left: 5,
        bottom:2000,
        right: 115,
        child:
        Container(child: _state == AppState.FINISHED_DOWNLOADING
            ? WeatherIcon():Container(),
        ),
      ),


    ],
    );
  }
}