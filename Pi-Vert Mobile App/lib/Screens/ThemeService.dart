
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final darkTheme = ThemeData.dark().copyWith(
      primaryColor: Colors.black,
      //appBarTheme: AppBarTheme(),
      dividerColor:Colors.black,
  );
  final lightTheme = ThemeData.light().copyWith(
      primaryColor: Color.fromRGBO(244, 243, 233, 1),
      //appBarTheme: AppBarTheme(),
      dividerColor:Colors.black,
  );

  final _getstorage = GetStorage();
  final _darkThemekey ='isDarkTheme';

  void saveThemeData(bool isDarkMode){
    _getstorage.write(_darkThemekey,isDarkMode);
  }
  bool isSavedDarkMode(){
    return _getstorage.read(_darkThemekey) ?? false;
  }

   ThemeMode geThemeMode(){
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
   }
   void changeTheme(){
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
        saveThemeData(!isSavedDarkMode());

   }
}


