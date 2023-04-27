part of 'model.dart';

class WilayahCuacaModel {
  String? jamCuaca;
  String? kodeCuaca;
  String? cuaca;
  String? humidity;
  String? tempC;
  String? tempF;

  WilayahCuacaModel({
    this.jamCuaca,
    this.kodeCuaca,
    this.cuaca,
    this.humidity,
    this.tempC,
    this.tempF,
  });

  WilayahCuacaModel.fromJson(Map<String, dynamic> json) {
    jamCuaca = json['jamCuaca'] as String?;
    kodeCuaca = json['kodeCuaca'] as String?;
    cuaca = json['cuaca'] as String?;
    humidity = json['humidity'] as String?;
    tempC = json['tempC'] as String?;
    tempF = json['tempF'] as String?;
  }
}
