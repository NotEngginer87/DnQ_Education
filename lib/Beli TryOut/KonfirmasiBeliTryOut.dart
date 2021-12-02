// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class KonfirmasiBeliTO extends StatefulWidget {
  KonfirmasiBeliTO(
      this.id,
      this.jenis,
      this.kode,
      this.linkgambar,
      this.namaTO,
      this.keteranganTO,
      this.timeTanggal,
      this.timeBulan,
      this.timeTahun,
      this.docname,
      {Key? key})
      : super(key: key);
  int id;
  String jenis;
  String kode;
  String? linkgambar;
  String namaTO;
  String keteranganTO;
  int timeTanggal;
  int timeBulan;
  int timeTahun;
  String docname;
  @override
  _KonfirmasiBeliTOState createState() => _KonfirmasiBeliTOState();
}

class _KonfirmasiBeliTOState extends State<KonfirmasiBeliTO> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('keterangan pembelian Try Out'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.namaTO,
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.keteranganTO,
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Batas Pengerjaan : ' + widget.timeTanggal.toString() + ' - ' + widget.timeBulan.toString() + ' - ' + widget.timeTahun.toString(),
                      style: TextStyle(fontSize: 14),
                    ),

                  ],
                ),

                ElevatedButton(onPressed: () {}, child: Text('Daftar TryOut')),
                Text('Apakah Anda Yakin Membeli ' + widget.namaTO + ' '),
              ],
            ),
          ),
        ));
  }
}
