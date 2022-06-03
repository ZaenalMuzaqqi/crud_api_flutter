import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/model.dart';
import '../model/model2.dart';

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class ApiService {
  static final Uri _url =
  Uri.parse('https://qolibri.id/api/index.php/api/getbarang');
  static final Uri _urlInsert =
  Uri.parse('https://qolibri.id/api/index.php/api/insertbarang');
  static final Uri _urlUpdate =
  Uri.parse('https://qolibri.id/api/index.php/api/updatebarang');
  static final Uri _urlDelete =
  Uri.parse('https://qolibri.id/api/index.php/api/deletebarang');
  static Future<List<Barang>> fetchBarang() async {
    List<Barang> listBarang = [];
    final response = await http.get(_url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      BarangService respBarang = BarangService.fromJson(json);
      for (var value in respBarang.barang) {
        listBarang.add(value);
      }

      return listBarang;
    } else {
      return [];
    }
  }

  Future<ResponsePost?> postBarang(nama, jumlah, gambar) async {
    final response = await http.post(_urlInsert,
        body: {'nama': nama, 'jumlah': jumlah, 'gambar': gambar});

    if (response.statusCode == 200) {
      ResponsePost responseRequest =
      ResponsePost.fromJson(jsonDecode(response.body));
      return responseRequest;
    } else {
      return null;
    }
  }

  Future<ResponsePost?> updateBarang(id, nama, jumlah, gambar) async {
    final response = await http.post(_urlUpdate,
        body: {"id": id, 'nama': nama, 'jumlah': jumlah, 'gambar': gambar});

    if (response.statusCode == 200) {
      ResponsePost responseRequest =
      ResponsePost.fromJson(jsonDecode(response.body));
      return responseRequest;
    } else {
      return null;
    }
  }

  Future<ResponsePost?> delBarang(id) async {
    final response = await http.post(_urlDelete, body: {'id': id});

    if (response.statusCode == 200) {
      ResponsePost responseRequest =
      ResponsePost.fromJson(jsonDecode(response.body));

      return responseRequest;
    } else {
      return null;
    }
  }
}
