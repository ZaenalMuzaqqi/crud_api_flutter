import 'package:flutter/material.dart';

import '../model/model.dart';

Widget itemBarang(Barang barang) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          child: Image.network(
            "${barang.barangGambar}",
            height: 100.0,
            width: double.infinity,
            fit: BoxFit.cover,
            // width: double.infinity,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "${barang.barangNama}",
                  style: const TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                Text("${barang.barangJumlah} buah")
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
