import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/model.dart';

class ServiceBmkg {
  Future<List<WilayahModel>> getWilayah() async {
    var res = await http.get(
        Uri.parse("https://ibnux.github.io/BMKG-importer/cuaca/wilayah.json"));

    var data = jsonDecode(res.body);

    var model =
        (data as Iterable).map((e) => WilayahModel.fromJson(e)).toList();

    return model;
  }

  Future<List<WilayahCuacaModel>> getCuaca(id) async {
    var res = await http
        .get(Uri.parse("https://ibnux.github.io/BMKG-importer/cuaca/$id.json"));

    var data = jsonDecode(res.body);

    List<WilayahCuacaModel> model = [];

    model.clear();

    model =
        (data as Iterable).map((e) => WilayahCuacaModel.fromJson(e)).toList();

    return model;
  }
}
