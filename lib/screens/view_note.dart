// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class view_note extends StatelessWidget {
  final String title;
  final String note;
  const view_note({super.key, required this.title, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, left: 5),
              width: MediaQuery.of(context).size.width - 20,
              padding: EdgeInsets.only(left: 12),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 10, left: 5),
                padding: EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width - 20,
                child: Text(
                  note,
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_sharp),
                onPressed: () {
                  Navigator.pop(context, 'refresh');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
