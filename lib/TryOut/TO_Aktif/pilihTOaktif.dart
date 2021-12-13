// ignore_for_file: file_names, prefer_const_constructors, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tryout/TryOut/beliTO/2KonfirmasiBeliTryOut.dart';

import 'SubUjian.dart';


class PilihTOAktif extends StatefulWidget {
  const PilihTOAktif({Key? key}) : super(key: key);

  @override
  _PilihTOAktifState createState() => _PilihTOAktifState();
}

class _PilihTOAktifState extends State<PilihTOAktif> {
  Widget buildTOCard(
      int id,
      String? jenis,
      String? kode,
      String? linkgambar,
      String? namaTO,
      String? keteranganTO,
      int timeTanggal,
      int timeBulan,
      int timeTahun,
      String docname,
      emaila,
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
                alignment: Alignment.center,
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
                  Text(
                    namaTO!,
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ],
          ));
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference tryoutdata = firestore.collection('TryOut');

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final emaila = user!.email;

    return Scaffold(
      appBar: AppBar(
        title: Text('AYO IKUT TRYOUTNYAA'),
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
                    child: Text('Ayo Ujian',
                        style: GoogleFonts.pathwayGothicOne(
                            fontWeight: FontWeight.w500, fontSize: 24)),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('user')
                    .doc(emaila.toString())
                    .collection('dataTO')
                    .snapshots(),
                builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return Column(
                    children:
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                      return Column(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: tryoutdata.snapshots(),
                            builder: (_, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  children: [
                                    Column(
                                        children: snapshot.data.docs
                                            .map<Widget>((e) =>
                                        ((e.data()['time_tahun'] * 12 +
                                            e.data()['time_bulan'] *
                                                30 +
                                            e.data()['time_tanggal']) >=
                                            (DateTime.now().year * 12 +
                                                DateTime.now().month * 30 +
                                                DateTime.now().day))
                                            ?  (data['namaTO'] == e.data()['namaTO']) ? (data['statuspembayaran'] == 'verified') ?
                                        buildTOCard(
                                          e.data()['id'],
                                          e.data()['jenis'],
                                          e.data()['kode'],
                                          e.data()['linkgambar'],
                                          e.data()['namaTO'],
                                          e.data()['keteranganTO'],
                                          e.data()['time_tanggal'],
                                          e.data()['time_bulan'],
                                          e.data()['time_tahun'],
                                          e.data()['docname'],
                                          emaila,
                                        ) : Container() : Container()
                                            : Container())
                                            .toList()),
                                    Column(
                                        children: snapshot.data.docs
                                            .map<Widget>((e) =>
                                        ((e.data()['time_tahun'] * 12 +
                                            e.data()['time_bulan'] *
                                                30 +
                                            e.data()['time_tanggal']) <=
                                            (DateTime.now().year * 12 +
                                                DateTime.now().month * 30 +
                                                DateTime.now().day))
                                            ?  (data['namaTO'] == e.data()['namaTO']) ? (data['statuspembayaran'] == 'verified') ?
                                        buildTOCard(
                                          e.data()['id'],
                                          e.data()['jenis'],
                                          e.data()['kode'],
                                          e.data()['linkgambar'],
                                          e.data()['namaTO'],
                                          e.data()['keteranganTO'],
                                          e.data()['time_tanggal'],
                                          e.data()['time_bulan'],
                                          e.data()['time_tahun'],
                                          e.data()['docname'],
                                          emaila,
                                        ) : Container() : Container()
                                            : Container())
                                            .toList())
                                  ],
                                );
                              } else {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Center(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          )
                        ],
                      );
                    }).toList(),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}

