import 'dart:convert';

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}



BarangService barangServiceFromJson(String str) => BarangService.fromJson(json.decode(str));

String barangServiceToJson(BarangService data) => json.encode(data.toJson());

class BarangService {
  BarangService({
    this.pesan,
    this.sukses,
    required this.barang,
  });

  String? pesan;
  bool? sukses;
  List<Barang> barang;

  factory BarangService.fromJson(Map<String, dynamic> json) => BarangService(
    pesan: json["pesan"],
    sukses: json["sukses"],
    barang: List<Barang>.from(json["barang"].map((x) => Barang.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pesan": pesan,
    "sukses": sukses,
    "barang": List<dynamic>.from(barang.map((x) => x.toJson())),
  };
}

class Barang {
  Barang({
    this.barangId,
    this.barangNama,
    this.barangJumlah,
    this.barangGambar,
  });

  String? barangId;
  String? barangNama;
  String? barangJumlah;
  String? barangGambar;

  factory Barang.fromJson(Map<String, dynamic> json) => Barang(
    barangId: json["barang_id"],
    barangNama: json["barang_nama"],
    barangJumlah: json["barang_jumlah"],
    barangGambar: json["barang_gambar"],
  );

  Map<String, dynamic> toJson() => {
    "barang_id": barangId,
    "barang_nama": barangNama,
    "barang_jumlah": barangJumlah,
    "barang_gambar": barangGambar,
  };
}
