// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names, unnecessary_null_comparison, avoid_print, deprecated_member_use

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';
import 'package:tryout/TryOut/beliTO/4TungguVerifikasiAdmin.dart';
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
  late String MetodePembayaran;
  String? PicTFBANK;
  String? PicGopay;
  String? PicFree1;
  String? PicFree2;
  String? PicFree3;

  String? $gambar;
  late bool switchfototfbank = false;
  late bool switchfotogopay = false;
  late bool switchfotofree1 = false;
  late bool switchfotofree2 = false;
  late bool switchfotofree3 = false;

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              'upload : $percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );

  String? _valMetodepembayaran;
  final List _myMetodepembayaran = [
    "FREE",
    "GOPAY",
    "TFBANK",
  ];

  @override
  Widget build(BuildContext context) {
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

    final ButtonStyle ButtonKonfirmasiPembayaran = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: Color(0xFF5d1a77),
      elevation: 10,
      minimumSize: Size(MediaQuery.of(context).size.width, 48),
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
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  DropdownButton(
                    hint: Text("Pilih Metode Pembayaranmu"),
                    value: _valMetodepembayaran,
                    items: _myMetodepembayaran.map((value) {
                      return DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _valMetodepembayaran = value as String?;
                        PicFree1 = null;
                        PicFree2 = null;
                        PicFree3 = null;
                        PicTFBANK = null;
                        PicGopay = null;
                        switchfotofree1 = false;
                        switchfotofree2 = false;
                        switchfotofree3 = false;
                        switchfotogopay = false;
                        switchfototfbank = false;
                      });
                    },
                  ),
                  StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('AkunPembayaran')
                          .doc('1')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          String TFBANKnama;
                          String TFBANKrekening;
                          String TFBANKnamabank;
                          String gopaynama;
                          String gopaynomor;
                          TFBANKnama = snapshot.data!['TFBANKnama'];
                          TFBANKrekening = snapshot.data!['TFBANKrekening'];
                          TFBANKnamabank = snapshot.data!['TFBANKnamabank'];
                          gopaynama = snapshot.data!['gopaynama'];
                          gopaynomor = snapshot.data!['gopaynomor'];
                          return Padding(
                            padding: EdgeInsets.all(12),
                            child: Center(
                              child: ((_valMetodepembayaran == 'FREE'))
                                  ? Column(
                                      children: [
                                        Text(
                                            'Kalau free, ikuti instruksi berikut : '),
                                        SizedBox(
                                          height: 24,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: Text(
                                                  'Upload Bukti Follow instagram @DnQEducation : '),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    UploadBuktiFree1();
                                                    switchfotofree1 = true;
                                                    MetodePembayaran = 'FREE';
                                                  },
                                                  child: Text('Upload'),
                                                  style: ButtonLebar,
                                                ))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: Text(
                                                  'Upload Bukti Screenshoot like dan komen postingan TO : '),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    UploadBuktiFree2();
                                                    switchfotofree2 = true;
                                                    MetodePembayaran = 'FREE';
                                                  },
                                                  child: Text('Upload'),
                                                  style: ButtonLebar,
                                                ))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: Text(
                                                  'Upload Bukti Follow instagram @DnQEducation : '),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    UploadBuktiFree3();
                                                    switchfotofree3 = true;
                                                    MetodePembayaran = 'FREE';
                                                  },
                                                  child: Text('Upload'),
                                                  style: ButtonLebar,
                                                ))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: <Widget>[
                                                (PicFree1 != null)
                                                    ? Card(
                                                        elevation: 4,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Stack(
                                                              children: [
                                                                Ink.image(
                                                                  image: NetworkImage(
                                                                      PicFree1!),
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      4,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      4,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                            Column(
                                              children: <Widget>[
                                                (PicFree2 != null)
                                                    ? Card(
                                                        elevation: 4,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Stack(
                                                              children: [
                                                                Ink.image(
                                                                  image: NetworkImage(
                                                                      PicFree2!),
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      4,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      4,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                            Column(
                                              children: <Widget>[
                                                (PicFree3 != null)
                                                    ? Card(
                                                        elevation: 4,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Stack(
                                                              children: [
                                                                Ink.image(
                                                                  image: NetworkImage(
                                                                      PicFree3!),
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      4,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      4,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : (_valMetodepembayaran == 'GOPAY')
                                      ? Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  24, 12, 24, 12),
                                              child: Column(
                                                children: [
                                                  Text(
                                                      'Transfer gopaymu ke nomer berikut : '),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        child: Text(
                                                            'Gopay atas nama : '),
                                                      ),
                                                      SizedBox(
                                                          child:
                                                              Text(gopaynama)),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        child: Text(
                                                            'Nomor Telepon : '),
                                                      ),
                                                      SizedBox(
                                                          child:
                                                              Text(gopaynomor)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 24,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  24, 12, 24, 12),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    child: Text(
                                                        'Upload Bukti Pembayaran Gopaymu '),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          UploadBuktiGopay();
                                                          switchfotogopay =
                                                              true;
                                                          MetodePembayaran =
                                                              'GOPAY';
                                                        },
                                                        child: Text('Upload'),
                                                        style: ButtonLebar,
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                (PicGopay != null)
                                                    ? Card(
                                                        elevation: 4,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Stack(
                                                              children: [
                                                                Ink.image(
                                                                  image: NetworkImage(
                                                                      PicGopay!),
                                                                  height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                          ],
                                        )
                                      : (_valMetodepembayaran == 'TFBANK')
                                          ? Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      24, 12, 24, 12),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                          'Transfer ke rekening  : '),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            child: Text(
                                                                'Rekening atas nama : '),
                                                          ),
                                                          SizedBox(
                                                              child: Text(
                                                                  TFBANKnama)),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            child: Text(
                                                                'Nomor BANK : '),
                                                          ),
                                                          SizedBox(
                                                              child: Text(
                                                                  TFBANKnamabank)),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            child: Text(
                                                                'Nomor Rekening : '),
                                                          ),
                                                          SizedBox(
                                                              child: Text(
                                                                  TFBANKrekening)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 24,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      24, 12, 24, 12),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                        child: Text(
                                                            'Upload Bukti Transfermu '),
                                                      ),
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              UploadBuktiTransfer();
                                                              switchfototfbank =
                                                                  true;
                                                              MetodePembayaran =
                                                                  'TFBANK';
                                                            },
                                                            child:
                                                                Text('Upload'),
                                                            style: ButtonLebar,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    (PicTFBANK != null)
                                                        ? Card(
                                                            elevation: 4,
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    Ink.image(
                                                                      image: NetworkImage(
                                                                          PicTFBANK!),
                                                                      height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : Container()
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Container(),
                            ),
                          );
                        }
                        //this will load first
                        return CircularProgressIndicator();
                      }),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: ((switchfototfbank == true) ||
                (switchfotogopay == true) ||
                ((switchfotofree1 == true) ||
                    (switchfotofree2 == true) ||
                    (switchfotofree3 == true)))
            ? Padding(
                padding: EdgeInsets.only(left: 32),
                child: (MetodePembayaran == 'TFBANK')
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TungguVerifikasiAdmin(
                                    widget.id,
                                    widget.jenis,
                                    widget.kode,
                                    widget.linkgambar,
                                    widget.namaTO,
                                    widget.keteranganTO,
                                    widget.timeTanggal,
                                    widget.timeBulan,
                                    widget.timeTahun,
                                    widget.docname,
                                    widget.emaila,
                                  )));
                          DatabaseServices.updatepembelianTO(widget.emaila.toString(),
                              widget.namaTO, widget.jenis, widget.id);
                          DatabaseServices.updatepembelianTO2TFBANK(
                            widget.emaila,
                            widget.id,
                            MetodePembayaran,
                            PicTFBANK!,
                          );
                        },
                        child: Text('Konfirmasi pembayaran'),
                        style: ButtonKonfirmasiPembayaran,
                      )
                    : (MetodePembayaran == 'GOPAY')
                        ? ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => TungguVerifikasiAdmin(
                                        widget.id,
                                        widget.jenis,
                                        widget.kode,
                                        widget.linkgambar,
                                        widget.namaTO,
                                        widget.keteranganTO,
                                        widget.timeTanggal,
                                        widget.timeBulan,
                                        widget.timeTahun,
                                        widget.docname,
                                        widget.emaila,
                                      )));
                              DatabaseServices.updatepembelianTO(widget.emaila.toString(),
                                  widget.namaTO, widget.jenis, widget.id);
                              DatabaseServices.updatepembelianTO2TFGOPAY(
                                widget.emaila,
                                widget.id,
                                MetodePembayaran,
                                PicGopay!,
                              );
                            },
                            child: Text('Konfirmasi pembayaran'),
                            style: ButtonKonfirmasiPembayaran,
                          )
                        : (MetodePembayaran == 'FREE')
                            ? ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          TungguVerifikasiAdmin(
                                            widget.id,
                                            widget.jenis,
                                            widget.kode,
                                            widget.linkgambar,
                                            widget.namaTO,
                                            widget.keteranganTO,
                                            widget.timeTanggal,
                                            widget.timeBulan,
                                            widget.timeTahun,
                                            widget.docname,
                                            widget.emaila,
                                          )));
                                  DatabaseServices.updatepembelianTO(widget.emaila.toString(),
                                      widget.namaTO, widget.jenis, widget.id);
                                  DatabaseServices.updatepembelianTO2FREE(
                                    widget.emaila,
                                    widget.id,
                                    MetodePembayaran,
                                    PicFree1!,
                                    PicFree2!,
                                    PicFree3!,
                                  );
                                },
                                child: Text('Konfirmasi pembayaran'),
                                style: ButtonKonfirmasiPembayaran,
                              )
                            : Container(),
              )
            : Container());
  }

  UploadBuktiTransfer() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile? image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);

      var file = File(image!.path);

      final fileName = basename(file.path);
      final destination = 'BuktiPembayaran/TransferBank/$fileName';

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _storage
            .ref()
            .child(destination)
            .putFile(file)
            .whenComplete(() => null);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          PicTFBANK = downloadUrl;
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }

  UploadBuktiGopay() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile? image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);

      var file = File(image!.path);

      final fileName = basename(file.path);
      final destination = 'BuktiPembayaran/Gopay/$fileName';

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _storage
            .ref()
            .child(destination)
            .putFile(file)
            .whenComplete(() => null);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          PicGopay = downloadUrl;
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }

  UploadBuktiFree1() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile? image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);

      var file = File(image!.path);

      final fileName = basename(file.path);
      final destination = 'BuktiPembayaran/Free1/$fileName';

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _storage
            .ref()
            .child(destination)
            .putFile(file)
            .whenComplete(() => null);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          PicFree1 = downloadUrl;
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }

  UploadBuktiFree2() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile? image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);

      var file = File(image!.path);

      final fileName = basename(file.path);
      final destination = 'BuktiPembayaran/Free2/$fileName';

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _storage
            .ref()
            .child(destination)
            .putFile(file)
            .whenComplete(() => null);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          PicFree2 = downloadUrl;
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }

  UploadBuktiFree3() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile? image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);

      var file = File(image!.path);

      final fileName = basename(file.path);
      final destination = 'BuktiPembayaran/Free3/$fileName';

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _storage
            .ref()
            .child(destination)
            .putFile(file)
            .whenComplete(() => null);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          PicFree3 = downloadUrl;
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
}
