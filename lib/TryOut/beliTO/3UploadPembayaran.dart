// ignore_for_file: file_names, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tryout/api/DatabaseServices.dart';

// ignore: must_be_immutable
class UploadPembayaran extends StatefulWidget {
  UploadPembayaran(
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
  _UploadPembayaranState createState() => _UploadPembayaranState();
}

class _UploadPembayaranState extends State<UploadPembayaran> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference userdata = firestore.collection('user');

    final ButtonStyle ButtonLebar = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: Color(0xFF5d1a77),
      elevation: 10,
      minimumSize: Size(MediaQuery.of(context).size.width * 0.4, 48),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('upload bukti pembayaran'),
        ),
        body: Center(
          child: Column(
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
                          'Pilih Bukti Pembayaran : ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
                            icon: LineIcons.moneyBill,
                            text: 'Free',
                          ),
                          GButton(
                            icon: LineIcons.bitbucket,
                            text: 'Gopay',
                          ),
                          GButton(
                            icon: LineIcons.coins,
                            text: 'Transfer Bank',
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
                  child: (_selectedIndex == 0)
                      ? Column(
                          children: [
                            Text('Kalau free, ikuti instruksi berikut : '),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                      'Upload Bukti Follow instagram @DnQEducation : '),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text('Upload'),
                                      style: ButtonLebar,
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                      'Upload Bukti Screenshoot like dan komen postingan TO : '),
                                ),
                                SizedBox(
                                    width:
                                    MediaQuery.of(context).size.width * 0.3,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text('Upload'),
                                      style: ButtonLebar,
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                      'Upload Bukti Follow instagram @DnQEducation : '),
                                ),
                                SizedBox(
                                    width:
                                    MediaQuery.of(context).size.width * 0.3,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text('Upload'),
                                      style: ButtonLebar,
                                    ))
                              ],
                            ),
                          ],
                        )
                      : (_selectedIndex == 1)
                          ? Column(
                              children: [
                                Text(
                                    'Kalau kamu menggunakan gopay, ikuti instruksi berikut : ')
                              ],
                            )
                          : (_selectedIndex == 2)
                              ? Column(
                                  children: [
                                    Text(
                                        'Kalau kamu bisanya transfer bank, ikuti instruksi berikut : ')
                                  ],
                                )
                              : Container(),
                ),
              ),
            ],
          ),
        ));
  }
}
