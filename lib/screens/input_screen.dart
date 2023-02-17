// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:notes/utils/databaseHelper.dart';

class inputPage extends StatefulWidget {
  const inputPage({super.key});

  @override
  State<inputPage> createState() => _inputPageState();
}

class _inputPageState extends State<inputPage> {
  final _textController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context, 'refresh');
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              hoverColor: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                "Enter Item:",
                style: TextStyle(
                    color: Color.fromARGB(255, 159, 154, 223), fontSize: 25),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(right: 20, left: 10),
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 36, 34, 68),
                  borderRadius: BorderRadius.circular(6)),
              child: TextField(
                controller: _textController,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note Title',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(right: 20, left: 10),
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 36, 34, 68),
                  borderRadius: BorderRadius.circular(6)),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _noteController,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note Text',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 10),
              child: ElevatedButton(
                onPressed: () async {
                  await databaseHelper.instance.add(
                    noteC(
                        title: _textController.text,
                        note: _noteController.text),
                  );
                  _textController.clear();
                  _noteController.clear();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 109, 100, 235)),
                child: Text("Create New Note"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
