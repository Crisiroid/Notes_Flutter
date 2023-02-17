// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:notes/screens/about_me.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Notes"),
            Builder(builder: (context) {
              return IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => aboutMe()));
                },
                icon: Icon(Icons.ac_unit),
              );
            })
          ],
        ),
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 6,
            mainAxisSpacing: 4,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Card(
                color: Colors.white,
                child: Center(
                  child: Text(
                    index.toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                ));
          },
        ),
      ),
    );
  }
}
