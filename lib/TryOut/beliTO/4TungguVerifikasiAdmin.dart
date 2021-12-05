// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../main.dart';

// ignore: must_be_immutable
class TungguVerifikasiAdmin extends StatefulWidget {
  TungguVerifikasiAdmin(
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
      this.emaila,
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
  String emaila;

  @override
  _TungguVerifikasiAdminState createState() => _TungguVerifikasiAdminState();
}

class _TungguVerifikasiAdminState extends State<TungguVerifikasiAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tunggu Verifikasi Admin'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.namaTO,
                      style: TextStyle(fontSize: 30),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.keteranganTO,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Batas Pengerjaan : ' +
                                  widget.timeTanggal.toString() +
                                  ' - ' +
                                  widget.timeBulan.toString() +
                                  ' - ' +
                                  widget.timeTahun.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Tunggu Pembayaranmu diverifikasi admin !!! ',
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'jika dalam 24 jam pembayaranmu tidak diverifikasi admin, maka hubungi ig @asyiqqin ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);


                  },
                  child: Text('kembali ke halaman utama'))
            ],
          ),
        ));
  }
}
