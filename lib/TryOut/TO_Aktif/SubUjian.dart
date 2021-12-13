// ignore_for_file: file_names, prefer_const_constructors, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:tryout/TryOut/ujian.dart';

class PilihSubSetUjian extends StatefulWidget {
  PilihSubSetUjian(this.docname, {Key? key}) : super(key: key);
  String? docname;

  @override
  _PilihSubSetUjianState createState() => _PilihSubSetUjianState();
}

class _PilihSubSetUjianState extends State<PilihSubSetUjian> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Subset Ujian'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: ListView(
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PageUjian(widget.docname, 'PU')));
                    },
                    child: Text('PPU'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PageUjian(widget.docname, 'PPU')));
                    },
                    child: Text('PPU'),
                  ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PageUjian(widget.docname, 'PBM')));
                    },
                    child: Text('PBM'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PageUjian(widget.docname, 'PK')));
                    },
                    child: Text('PK'),
                  ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PageUjian(widget.docname, 'INGG')));
                    },
                    child: Text('INGG'),
                  ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PageUjian(widget.docname, 'MTK')));
                    },
                    child: Text('MTK'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PageUjian(widget.docname, 'FIS')));
                    },
                    child: Text('FIS'),
                  ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PageUjian(widget.docname, 'KIM')));
                    },
                    child: Text('KIM'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PageUjian(widget.docname, 'BIO')));
                    },
                    child: Text('BIO'),
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
