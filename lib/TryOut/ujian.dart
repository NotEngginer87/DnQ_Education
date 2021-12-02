// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardSoal extends StatefulWidget {
  const CardSoal(this.soal, this.kunci, this.A, this.B, this.C, this.D, this.E);

  final String? soal;
  final String? kunci;
  final String A;
  final String B;
  final String C;
  final String D;
  final String E;

  @override
  _CardSoalState createState() => _CardSoalState();
}

class _CardSoalState extends State<CardSoal> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle opsi = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: Color(0xFF5d1a77),
      elevation: 10,
      minimumSize: Size(48, 48),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 10,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                widget.soal!,
                style: TextStyle(
                  fontSize: 24,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 2, 2, 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'A. ' + widget.A,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 2, 2, 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'B. ' + widget.B,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 2, 2, 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'C. ' + widget.C,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 2, 2, 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'D. ' + widget.D,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 2, 2, 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'E. ' + widget.E,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text('A'),
                    style: opsi,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('B'),
                    style: opsi,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('C'),
                    style: opsi,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('D'),
                    style: opsi,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('E'),
                    style: opsi,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageUjian extends StatefulWidget {
  PageUjian(this.docname, this.colname, {Key? key}) : super(key: key);
  String? docname;
  String colname;

  @override
  _PageUjianState createState() => _PageUjianState();
}

class _PageUjianState extends State<PageUjian> {
  int nomor = 1;
  late int k;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference tryoutdata = firestore.collection('TryOut');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman 2'),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  for (int i = 1; i <= 20; i++)
                    Padding(
                      padding: EdgeInsets.only(left: 4, right: 4),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              nomor = i;
                            });
                          },
                          child: Text(i.toString())),
                    ),
                ],
              ),
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: tryoutdata
                  .doc(widget.docname)
                  .collection(widget.colname)
                  .doc(nomor.toString())
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;

                  String? soal;
                  soal = data['soal'];
                  String? kunci;
                  kunci = data['kunci'];
                  String? A;
                  A = data['A'];
                  String? B;
                  B = data['B'];
                  String? C;
                  C = data['C'];
                  String? D;
                  D = data['D'];
                  String? E;
                  E = data['E'];

                  return CardSoal(
                    soal!,
                    A!,
                    B!,
                    C!,
                    D!,
                    E!,
                    kunci!,
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
