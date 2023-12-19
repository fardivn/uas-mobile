import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:uas_mobile/models/mahasiswa.dart';

class MahasiswaService {
  final String url =
      "https://uas-mobile-60b2b-default-rtdb.firebaseio.com/mahasiswa.json";

  Future getData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        final dataMhs = jsonResponse['data'];
        List mhs = dataMhs.map((i) => Mahasiswa.fromJson(i)).toList();
        return mhs;
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
}
