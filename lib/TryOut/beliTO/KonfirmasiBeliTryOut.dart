// ignore_for_file: file_names, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tryout/api/DatabaseServices.dart';

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
  _KonfirmasiBeliTOState createState() => _KonfirmasiBeliTOState();
}

class _KonfirmasiBeliTOState extends State<KonfirmasiBeliTO> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference userdata = firestore.collection('user');

    final ButtonStyle ButtonLebar = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: Color(0xFF5d1a77),
      elevation: 10,
      minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 48),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('keterangan pembelian Try Out'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
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
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    DatabaseServices.updatepembelianTO(widget.emaila.toString(),
                        widget.namaTO, widget.jenis, widget.id);
                  },
                  child: Text('Daftar TryOut'),
                  style: ButtonLebar,
                ),



              ],
            ),
          ),
        ));
  }
}
