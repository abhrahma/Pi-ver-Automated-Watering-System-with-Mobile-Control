import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:projet2cp/Screens/Contact.dart';
import 'package:projet2cp/Screens/Credit.dart';
import 'package:projet2cp/Screens/Modemploi.dart';
import 'package:projet2cp/Screens/ThemeService.dart';
import 'package:projet2cp/Screens/acueil.dart';
import 'package:projet2cp/Screens/formPlant.dart';
import 'package:projet2cp/Screens/maPlante.dart';
import 'package:projet2cp/Screens/monJardin.dart';
import 'package:projet2cp/Screens/nouvellePlante.dart';
import 'package:projet2cp/Screens/setting.dart';
import 'package:projet2cp/WelcomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projet2cp/bilanpage.dart';
import 'package:projet2cp/login_screen.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeService().lightTheme,
    darkTheme: ThemeService().darkTheme,
    themeMode: ThemeService().geThemeMode(),
    home: MyApp(),
    routes: {
      '/acueil': (context) => Acueil(),
      '/bilan': (context) => Bilanpage(),
      '/monJardin': (context) => MonJardin(),
      '/nouvellePlante': (context) => NouvellePlante(),
      '/maPlante': (context) => MaPlante(),
      '/settings': (context) => MySettings(),
      '/form': (context) => FormPlante(),
      '/Contact': (context) => Mycontact(),
      '/Modemploi': (context) => MyModemploi(),
      '/Credit': (context) => Mycredit(),
      '/loginScreen': (context) => Login_screen(),
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return /*MaterialApp(inside a get material app and we use ThemeService().changeTheme();
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
      theme:ThemeService().lightTheme,
      darkTheme:ThemeService().darkTheme,
      themeMode:ThemeService().geThemeMode(),
    );*/
        Scaffold(
      body: WelcomePage(),
      extendBody: true,
      backgroundColor: const Color.fromRGBO(244, 243, 233, 1.0),
    );
  }
}
