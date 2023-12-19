class Mahasiswa {
  late String id;
  late String nim;
  late String nama;
  late String kelas;

  Mahasiswa(this.id, this.nim, this.nama, this.kelas);

  Mahasiswa.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nim = json["nim"];
    nama = json["nama"];
    kelas = json["kelas"];
  }

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "nim": nim,
  //       "nama": nama,
  //       "kelas": kelas,
  //     };
}
