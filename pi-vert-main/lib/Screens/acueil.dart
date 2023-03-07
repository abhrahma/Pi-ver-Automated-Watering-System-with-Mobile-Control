import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:projet2cp/Acceuil.dart';
import 'package:projet2cp/Model/my_flutter_app_icons.dart';
import 'package:projet2cp/Screens/ThemeService.dart';
import 'package:projet2cp/Screens/affichage.dart';
import 'package:projet2cp/Screens/monJardin.dart';
import 'package:projet2cp/Screens/nouvellePlante.dart';
import 'package:projet2cp/Screens/profile.dart';
import 'package:projet2cp/Widgets/Style.dart';
import 'package:projet2cp/bilanpage.dart';

class Acueil extends StatefulWidget {
  const Acueil({Key? key}) : super(key: key);
  @override
  State<Acueil> createState() => _AcueilState();
}

class _AcueilState extends State<Acueil> {
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String? token = " ";
  @override
  void initState() {
    super.initState();

    requestPermission();

    loadFCM();

    listenFCM();

    getToken();

    FirebaseMessaging.instance.subscribeToTopic("Arroser");
  }

  void sendPushMessage(String title) async {
    try {
      http.Response r=await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAAxmi3RDo:APA91bFRWfylWUOZ0zZ8lbR4NrIaIZ6A4uO-1cC3TqjrgF-hJ2sh5fGZhbV1Z9F9tLpRbo09PK-o-MvfaxlyqEHV4ytry0xYURStTztna-fMuxzKnSUTvASrjJX0u_lGdvYs3B7_AaqV',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': title,
              'title': 'Pi-Vert'
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": "$token",
          },
        ),
      );
      if(r==200)
      {
        print("good");
      }
      else{
        print("bad");
      }

    } catch (e) {
      print("error push notification");
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then(
            (token) {
          setState(() {
            this.token = token;
          });
        }
    );
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  int currentIndex=0;
  final List<Widget>pages=[
    //Acueil
    Accueil(),
    //Bilan
    Bilanpage(),
    //Nouvelle Plante
    NouvellePlante(),
    //Mon Jardin
    MonJardin(),
    MyLogin(),
  ];
  bool newNotif=false;
  bool notifier=false;
  String Notif='';
  @override
  Widget build(BuildContext context) {


    FirebaseFirestore.instance.collection('Informations').doc('System').get().then((value) {
      Map<String, dynamic>? p = value.data();
      setState(() {
        if (p != null) {
          notifier=p['notification'];
        }
      });


    });


    if(notifier) {
      FirebaseFirestore.instance.collection('Informations').doc('Sortie')
          .get()
          .then((value) {
        Map<String, dynamic>? p = value.data();
        if (p != null) {
          setState(() {
            newNotif = p['NewNotif'];
            Notif = p['notification'];
          });
        }
      });
      if(newNotif)
        {
          sendPushMessage(Notif);
          FirebaseFirestore.instance.collection('Informations').doc('Sortie').update(
              {'NewNotif': false});
        }
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 233, 1),
      extendBody: true,
      body: pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(items: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(MyFlutterApp.home,semanticLabel: 'Acueil',),
            Text('Acueil',style: Style.Space12,),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(MyFlutterApp.line_graph),
            Text('Bilan',style: Style.Space12,),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(onPressed: (){},child: Icon(MyFlutterApp.more,color: Colors.black,),backgroundColor: Color.fromRGBO(210, 146, 111, 1.0),),
            Text('Ajouter'),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(MyFlutterApp.sprout),
            Text('Jardin',style: Style.Space12,),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(MyFlutterApp.user),
            Text('profile',style: Style.Space12,),
          ],
        ),
      ],
        index:currentIndex,
        onTap: (index)=>setState(() {
          currentIndex=index;
        }),
        buttonBackgroundColor: Color.fromRGBO(229, 228, 216, 1.0),
        backgroundColor: Colors.transparent,
        color: Color.fromRGBO(229, 228, 216, 1.0),
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

