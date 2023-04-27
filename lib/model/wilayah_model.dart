part of 'model.dart';

class WilayahModel {
  String? id;
  String? propinsi;
  String? kota;
  String? kecamatan;
  String? lat;
  String? lon;

  WilayahModel({
    this.id,
    this.propinsi,
    this.kota,
    this.kecamatan,
    this.lat,
    this.lon,
  });

  WilayahModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    propinsi = json['propinsi'] as String?;
    kota = json['kota'] as String?;
    kecamatan = json['kecamatan'] as String?;
    lat = json['lat'] as String?;
    lon = json['lon'] as String?;
  }
}
