// ignore_for_file: camel_case_types, file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tryout/TryOut/beliTO/1PilihBeliTryOut.dart';
import 'package:tryout/TryOut/beliTO/0daftarTO.dart';

import 'TO_Aktif/pilihTOaktif.dart';

class tryoutPage extends StatefulWidget {
  const tryoutPage({Key? key}) : super(key: key);

  @override
  _tryoutPageState createState() => _tryoutPageState();
}

class _tryoutPageState extends State<tryoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('TryOut'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text('ini tampilan TO'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PilihTOAktif()));
                  }, child: Text('TO Aktif')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BeliTryOut()));
                      },
                      child: Text('Beli TO')),
                ],
              ),
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => daftarTO()));
                  },
                  child: const Text('Tampilan Regis Ujian')),
            ],
          ),
        ],
      ),
    );
  }
}
