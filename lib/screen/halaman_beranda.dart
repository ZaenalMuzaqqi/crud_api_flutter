import '../service/repository.dart';
import 'package:flutter/material.dart';
import '../model/model.dart';
import '../widget/item_barang.dart';
import 'halaman_tambah_edit.dart';

class HalamanBeranda extends StatelessWidget {
  static const String id = "HALAMANBERANDA";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Inventory'),
      ),
      body: GridBarang(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HalamanTambahEdit(
                    barang: null,
                  )));
        },
      ),
    );
  }
}

class GridBarang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<List<Barang>>(
              future: ApiService.fetchBarang(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  List<Barang>? listBarang = snapshot.data;

                  return GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: listBarang?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        splashColor: Colors.indigo,
                        borderRadius: BorderRadius.circular(10.0),
                        child: itemBarang(listBarang![index]),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HalamanTambahEdit(
                                      barang: listBarang[index])));
                        },
                      );
                    },
                  );
                }
              },
            )));
  }
}
