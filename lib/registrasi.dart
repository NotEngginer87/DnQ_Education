// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'api/DatabaseServices.dart';
import 'main.dart';

class Registrasi extends StatefulWidget {
  const Registrasi({Key? key}) : super(key: key);

  @override
  _RegistrasiState createState() => _RegistrasiState();
}

class _RegistrasiState extends State<Registrasi> {
  TextEditingController controllernama = TextEditingController();
  TextEditingController controllertelepon = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllernama = TextEditingController();
  }

  @override
  void dispose() {
    controllernama.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final emaila = user!.email;


    final ButtonStyle submit = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: const Color(0xFF5d1a77),
      elevation: 10,
      minimumSize: Size(MediaQuery.of(context).size.width, 48),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Ujian'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 4, 24, 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    TextField(
                      // nama
                      scrollPadding: EdgeInsets.all(20),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Nama Lengkap",
                          hintText: "Nama sesuai identitas",
                          hintStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),

                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                        });
                      },
                      controller: controllernama,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      // nama
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "Nomor HP",
                        hintText: "08XXXXXXXXXX",
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onChanged: (value) {
                        setState(() {
                        });
                      },
                      controller: controllertelepon,
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                    DatabaseServices.updateakun(
                        emaila.toString(),
                        controllernama.text,
                        controllertelepon.text);
                  },
                  child: Text('Submit'),
                  style: submit,
                )
              ],
            ),
          ),
        ));
  }
}
