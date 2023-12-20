import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:uas_mobile/models/mahasiswa.dart';

class MahasiswaService {
  final String url =
      "https://uas-mobile-60b2b-default-rtdb.firebaseio.com/mahasiswa.json";
  List<Mahasiswa> allMhs = [];

  Future getData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        jsonResponse.forEach((key, value) {
          allMhs.add(Mahasiswa(
              id: key,
              nim: value['nim'],
              nama: value['nama'],
              kelas: value['kelas']));
        });
        return allMhs;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future addData(String nim, String nama, String kelas) {
    return http.post(Uri.parse(url),
        body: json.encode({"nim": nim, "nama": nama, "kelas": kelas}));
  }

  Future deleteData(String id) {
    Uri urlData = Uri.parse(
        "https://uas-mobile-60b2b-default-rtdb.firebaseio.com/mahasiswa/$id.json");
    return http.delete(urlData);
  }
}
