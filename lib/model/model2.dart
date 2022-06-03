import 'dart:convert';

ResponsePost responseRequestFromJson(String str) =>
    ResponsePost.fromJson(json.decode(str));

String responseRequestToJson(ResponsePost data) =>
    json.encode(data.toJson());

class ResponsePost {
  bool? sukses;
  String? pesan;
  int? lastId;

  ResponsePost({this.sukses, this.pesan, this.lastId});

  factory ResponsePost.fromJson(Map<String, dynamic> json) =>
      ResponsePost(
          sukses: json["sukses"],
          pesan: json["pesan"],
          lastId: json["last_id"]);

  Map<String, dynamic> toJson() =>
      {"sukses": sukses, "pesan": pesan, "last_id": lastId};
}