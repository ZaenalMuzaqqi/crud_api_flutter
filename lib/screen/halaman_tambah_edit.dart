import 'package:flutter/material.dart';
import '../model/model.dart';
import '/model/model2.dart';
import '../service/repository.dart';
import 'package:toast/toast.dart';

import 'halaman_beranda.dart';

class HalamanTambahEdit extends StatefulWidget {
  static const String id = "HALAMANTAMBAHEDIT";
  final Barang? barang;

  HalamanTambahEdit({this.barang});

  @override
  _HalamanTambahEditState createState() => _HalamanTambahEditState();
}

class _HalamanTambahEditState extends State<HalamanTambahEdit> {
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  bool _isUpdate = false;

  String? _idBarang;
  TextEditingController? _nmBarang, _jmlBarang, _urlBarang;

  ApiService service = ApiService();
  bool? _sukses;
  ResponsePost? response;

  void cekValidasi() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      if (_isUpdate) {
        response = await service.updateBarang(
            _idBarang, _nmBarang?.text, _jmlBarang?.text, _urlBarang?.text);
      } else {
        response = await service.postBarang(
            _nmBarang?.text, _jmlBarang?.text, _urlBarang?.text);
        print(response?.pesan);
      }

      _sukses = response?.sukses;

      if (_sukses == true) {
        setState(() {
          Navigator.pushNamedAndRemoveUntil(
              context, HalamanBeranda.id, (Route<dynamic> route) => false);
        });
        Toast.show("Berhasil",
            duration: Toast.lengthShort, gravity: Toast.bottom);
      } else {
        print('gagal');
      }
    } else {
      _validate = true;
    }
  }

  String? validator(String? value) {
    if (value == null) {
      return "jangan kosong";
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.barang != null) {
      _isUpdate = true;
      _idBarang = widget.barang?.barangId;

      _nmBarang = TextEditingController(text: widget.barang?.barangNama);
      _jmlBarang = TextEditingController(text: widget.barang?.barangJumlah);
      _urlBarang = TextEditingController(text: widget.barang?.barangGambar);
    } else {
      _nmBarang = TextEditingController();
      _jmlBarang = TextEditingController();
      _urlBarang = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        _isUpdate ? const Text('Update Data') : const Text('Tambah Data'),
        actions: <Widget>[
          _isUpdate
              ? IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await service.delBarang(_idBarang).then((value) {
                if (value?.sukses == true) {
                  Navigator.pushNamedAndRemoveUntil(context,
                      HalamanBeranda.id, (Route<dynamic> route) => false);
                } else {}
              });
            },
          )
              : const Text('')
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(
                    controller: _nmBarang,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Nama Barang'),
                    validator: validator,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(
                    controller: _jmlBarang,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Jumlah Barang'),
                    validator: validator,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(
                    controller: _urlBarang,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Url Barang'),
                    validator: validator,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: cekValidasi,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: const Text(
                      'SIMPAN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
