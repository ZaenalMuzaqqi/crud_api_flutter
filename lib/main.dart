import 'screen/halaman_beranda.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: HalamanBeranda.id,
      routes: {
        HalamanBeranda.id: (context) => HalamanBeranda(),
        // HalamanTambahEdit.id: (context) => HalamanTambahEdit()
      },
    );
  }
}
