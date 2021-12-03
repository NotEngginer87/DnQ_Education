// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference userdata = firestore.collection('user');
  static CollectionReference userdataTO = firestore.collection('user');
  static CollectionReference count = firestore.collection('count');
  static CollectionReference blog = firestore.collection('soal');

  static Future<void> updateakun(String akungoogle, String nama, String nomorHP) async {
    await userdata.doc(akungoogle).update(
      {
        'akungoogle': akungoogle,
        'nama': nama,
        'nomorhp': nomorHP,
      },
    );
  }

  static Future<void> updatepembelianTO(String akungoogle, String namaTO, String jenis, int id) async {
    await userdataTO.doc(akungoogle).collection('dataTO').doc(id.toString()).set(
      {
        'namaTO': namaTO,
        'jenis': jenis,
        'id': id,
        'statuspembayaran' : 'belum bayar',
      },
    );
  }

  static Future<void> updatecountakun() async {
    await count.doc('hitung').update(
      {
        'banyakuser' : int.tryParse('banyakuser')! + 1,
      },
    );

  }

  static Future<void> updatecountakunuser(int countt, String akungoogle) async {

    await userdata.doc(akungoogle).set(
      {
        'id' : countt,
        'akungoogle': akungoogle,
      },
    );
  }




  static Future<void> updateData(
      String? documentId,
      String nama,
      String alamat,
      int? agama,
      String telepon,
      String pekerjaan,
      String suku,
      int? gender,
      String umur,
      String keluhan,
      String? gambar) async {
    await userdata.doc(documentId).set(
      {
        'nama': nama,
        'alamat': alamat,
        'agama': (agama == 1)
            ? 'Islam'
            : (agama == 2)
            ? 'Protestan'
            : (agama == 3)
            ? 'Katolik'
            : (agama == 4)
            ? 'Budha'
            : (agama == 5)
            ? 'Hindu'
            : ' ',
        'telepon': telepon,
        'pekerjaan': pekerjaan,
        'suku': suku,
        'gender': (gender == 1)  ? 'Laki - Laki' : 'Perempuan',
        'umur': umur,
        'keluhan': keluhan,
        'urlgambar': gambar
      },
    );
  }

  static Future<void> terbacaBlog(String? id) async {

    await blog.doc(id).update(
      {
        'terbaca': int.tryParse('terbaca')! + 1,
      },
    );
  }

  static Future<void> kritikdansaran(String keluhan) async {
    await userdata.doc().set(
      {
        'keluhan': keluhan,
      },
    );
  }



  static Future<void> deleteuser(String id) async {
    await userdata.doc(id).delete();
  }
}