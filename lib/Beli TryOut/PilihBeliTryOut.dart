// ignore_for_file: file_names, prefer_const_constructors, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'KonfirmasiBeliTryOut.dart';

class BeliTryOut extends StatefulWidget {
  const BeliTryOut({Key? key}) : super(key: key);

  @override
  _BeliTryOutState createState() => _BeliTryOutState();
}

class _BeliTryOutState extends State<BeliTryOut> {
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
                          builder: (context) => KonfirmasiBeliTO(
                              id,
                              jenis!,
                              kode!,
                              linkgambar,
                              namaTO!,
                              keteranganTO!,
                              timeTanggal,
                              timeBulan,
                              timeTahun,
                              docname)));
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Beli TryOut kamu'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8),
                      child: GNav(
                        rippleColor: Colors.grey[300]!,
                        hoverColor: Colors.grey[100]!,
                        gap: 8,
                        activeColor: Colors.black,
                        iconSize: 24,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        duration: Duration(milliseconds: 400),
                        tabBackgroundColor: Colors.grey[100]!,
                        color: Colors.black,
                        tabs: const [
                          GButton(
                            icon: LineIcons.home,
                            text: 'TO BARU',
                          ),
                          GButton(
                            icon: LineIcons.book,
                            text: 'TO LAMA',
                          ),
                        ],
                        selectedIndex: _selectedIndex,
                        onTabChange: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
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
              Center(
                child: (_selectedIndex == 0)
                    ? StreamBuilder<QuerySnapshot>(
                        stream: tryoutdata.snapshots(),
                        builder: (_, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                                children: snapshot.data.docs
                                    .map<Widget>((e) =>
                                        ((e.data()['time_tahun'] * 12 +
                                                    e.data()['time_bulan'] *
                                                        30 +
                                                    e.data()['time_tanggal']) >=
                                                DateTime.now().year * 12 +
                                                    DateTime.now().month * 30 +
                                                    DateTime.now().day)
                                            ? buildTOCard(
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
                                              )
                                            : Container())
                                    .toList());
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
                    : (_selectedIndex == 1)
                        ? StreamBuilder<QuerySnapshot>(
                            stream: tryoutdata.snapshots(),
                            builder: (_, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                    children: snapshot.data.docs
                                        .map<Widget>((e) => ((e.data()[
                                                            'time_tahun'] *
                                                        12 +
                                                    e.data()['time_bulan'] *
                                                        30 +
                                                    e.data()['time_tanggal']) <=
                                                DateTime.now().year * 12 +
                                                    DateTime.now().month * 30 +
                                                    DateTime.now().day)
                                            ? buildTOCard(
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
                                              )
                                            : Container())
                                        .toList());
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
                        : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
