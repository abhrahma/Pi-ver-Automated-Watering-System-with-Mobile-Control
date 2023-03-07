import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet2cp/Model/plant.dart';

class DatabaseManager {
  final CollectionReference plantList =
  FirebaseFirestore.instance.collection('plant');

  Future<void> createPlant(
      String nom, String surnom, int min_Temp, int max_Temp, String moisture,String humidity,String uid) async {
    return await plantList
        .doc(uid)
        .set({'nom': nom, 'surnom': surnom, 'min_Temp': min_Temp,'max_Temp':max_Temp,'moisture':moisture,'humidity':humidity});
  }

  Future updatePlantList(String name, String gender, int score, String uid) async {
    return await plantList.doc(uid).update({
      'name': name, 'gender': gender, 'score': score
    });
  }

  Future getPlantList() async {
    List itemsList = [];

    try {
      await plantList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}