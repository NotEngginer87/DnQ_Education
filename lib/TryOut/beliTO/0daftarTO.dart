// ignore_for_file: file_names, prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tryout/TryOut/SubUjian.dart';

class daftarTO extends StatefulWidget {
  const daftarTO({Key? key}) : super(key: key);

  @override
  _daftarTOState createState() => _daftarTOState();
}

class _daftarTOState extends State<daftarTO> {
  Widget buildTOCard(
    int id,
    String? jenis,
    String? kode,
    String? linkgambar,
    String? namaTO,
    int timeTanggal,
    int timeBulan,
    int timeTahun,
    String docname,
  ) =>
      Card(
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Ink.image(
                    image: NetworkImage('$linkgambar'),
                    height: MediaQuery.of(context).size.width * 0.4,
                    width: MediaQuery.of(context).size.width * 0.8,
                    fit: BoxFit.fitWidth,
                    child: InkWell(onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PilihSubSetUjian(docname)));
                    }),
                  ),
                ],
              ),
            ],
          ));

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference tryoutdata = firestore.collection('TryOut');

    return Scaffold(
      appBar: AppBar(
        title: Text('ganteng'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Pilih TryOut yang kamu inginkan',
                        style: GoogleFonts.pathwayGothicOne(
                            fontWeight: FontWeight.w500, fontSize: 24)),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: tryoutdata.snapshots(),
                builder: (_, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                        children: snapshot.data.docs
                            .map<Widget>((e) => ((e.data()['time_tahun'] * 2 +
                                        e.data()['time_bulan'] * 5 +
                                        e.data()['time_tanggal'] * 10) <=
                                    DateTime.now().year * 2 +
                                        DateTime.now().month * 5 +
                                        DateTime.now().day * 10)
                                ? buildTOCard(
                                    e.data()['id'],
                                    e.data()['jenis'],
                                    e.data()['kode'],
                                    e.data()['linkgambar'],
                                    e.data()['namaTO'],
                                    e.data()['time_tanggal'],
                                    e.data()['time_bulan'],
                                    e.data()['time_tahun'],
                                    e.data()['docname'],
                                  )
                                : Container())
                            .toList());
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
