
import 'dart:ffi';

class Plant {
  final String? plant_Name;
  final String? plant_Type;
  final String? plant_currentName;
  final String? plant_Desc;
  final dynamic? min_Temp;
  final dynamic? max_Temp;
  final String? conseils;
  final String? humidity;
  final String? moisture;

  Plant({this.plant_Name,
    this.plant_Type,
    this.plant_currentName,
    this.plant_Desc,
    this.conseils,
    this.min_Temp,
    this.max_Temp,
    this.humidity,
    this.moisture});
}


