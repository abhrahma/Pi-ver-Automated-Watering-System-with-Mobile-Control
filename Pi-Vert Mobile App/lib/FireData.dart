class Data {
  Data({required this.Humidity, /*required this.Moisture, required this.Temperature,*/ required this.Time});

   final double Humidity;
   //final double Moisture;
   //final double Temperature;
   final double Time;
  /*Data.fromJson(var value) {
    this.Humidity=value['Humidity'];
    this.Time=value['Time'];
    this.Temperature=value['Temperature'];
    this.Moisture=value['Moisture'];
  } */
  factory Data.fromJson(Map<dynamic, dynamic> json) {
    double parser(dynamic source) {
      try {
        return double.parse(source.toString());
      } on FormatException {
        return -1;
      }
    }

    return Data(
        Humidity: parser(json['Humidity']),
        //Moisture: parser(json['Moisture']),
        //Temperature: parser(json['Temperature']),
        Time: parser(json['Time']));
  }

}