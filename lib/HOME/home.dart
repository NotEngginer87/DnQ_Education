// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tryout/TryOut/beliTO/1PilihBeliTryOut.dart';
import 'package:tryout/api/AuthServices.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('RocketEdu'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('ini tampilan home'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BeliTryOut()));
                },
                child: Text('BELI TRY OUT'),
              ),
              ElevatedButton(
                onPressed: () {
                  AuthServices.signInWithGoogle();
                },
                child: Text('Login'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
