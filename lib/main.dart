import 'package:flutter/material.dart';
import 'inputHarga.dart';
import 'inputDP.dart';
import 'dropdown.dart';
import 'buttonHitung.dart';
import 'result.dart';
import 'riwayat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  double _hargaBarang = 0; //variabel harga barang
  double _dp = 0; // variabel DP
  String _lamaCicilan = "6 Bulan"; //value dari dropdown
  double _result = 0; //variabel hasil dari perhitungan

  final inputHargaController = TextEditingController(); //untuk menangani inputan harga
  final inputDPController = TextEditingController(); //untuk menangani inputan DP

  List<String> listViewItem = []; //List dari riwayat perhitungan

  void _perhitunganCicilan(){ //method untuk melakukan perhitungan
    setState((){ //untuk mem-build ulang kode
      _hargaBarang = double.parse(inputHargaController.text); //memberikan nilai inputan ke variabel _hargaBarang
      _dp = double.parse(inputDPController.text); //memberikan nilai inputan ke variabel _dp
      int _lama = 6 ; //variabel pembantu untuk perhitungan pembagian

      if (_lamaCicilan == "6 Bulan") //kondisi apabila pilihan dropdown = 6 bulan
        _lama = 6;
      else if (_lamaCicilan == "12 Bulan") //kondisi apabila pilihan dropdown = 12 bulan
        _lama = 12;
      else //kondisi apabila pilihan dropdown = 624bulan
        _lama = 24;

      _result = ((_hargaBarang - _dp) / _lama) + ((2/100 * _hargaBarang)); //perhitungan angsuran perbualan
      String _resultString = _result.toStringAsFixed(0);
      listViewItem.add("Angsuran per bulan : $_resultString"); //menambahkan data ke list riwayat perhitungan
    });
  }

  void dropdownOnChanged(String changeValue){
    setState(() {
      _lamaCicilan = changeValue; //mengubah nilai variabel _lamaCicilan
      _perhitunganCicilan(); //memanggil p_perhitunganCiciclan
    });
  }

  Widget build(BuildContext context) {

    //list untuk pilihan dropdown
     var listItem = [
      "6 Bulan",
      "12 Bulan",
      "24 Bulan",
    ];

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:  Scaffold(
      appBar: AppBar(
      title: Text("Kalkulator Cicilan Kredit"), //judul di app bar
      ),
       body: Container(
         margin: EdgeInsets.all(8),
          child: Column(
            children: [
              InputHarga(inputHargaController: inputHargaController), //memanggil class InputHarga
              InputDP(inputDPController: inputDPController), //memanggil class InputDP
              DropdownPilihan(listItem: listItem, newValue: _lamaCicilan, dropdownOnChanged : dropdownOnChanged), //memanggil class DropdownPilihan
              Result(result: _result), //memanggil class Result
              ButtonHitung(hitung: _perhitunganCicilan), //memanggil class ButtonHitung
              Container( //Container untuk menampilkan tulisan 
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Riwayat",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                child: Riwayat(listViewItem: listViewItem), //menampilkan riwayat perhitungan
              ),
            ],
          ),
       ),
      ),
    );
  }
}

