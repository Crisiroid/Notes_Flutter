// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:notes/screens/about_me.dart';
import 'package:notes/screens/input_screen.dart';
import 'package:notes/screens/view_note.dart';
import 'package:notes/utils/databaseHelper.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  bool value = false;

  void changeData() {
    setState(
      () {
        value = true;
      },
    );
  }

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => aboutMe(),
                    ),
                  );
                },
                icon: Icon(Icons.ac_unit),
              );
            })
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: FutureBuilder<List<noteC>>(
                  future: databaseHelper.instance.getNoteList(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<noteC>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                          "Processing...",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return snapshot.data!.isEmpty
                        ? Center(
                            child: Text("No daata"),
                          )
                        : GridView.builder(
                            itemCount: snapshot.data?.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  String refresh = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => view_note(
                                        title: snapshot.data![index].title,
                                        note: snapshot.data![index].note,
                                      ),
                                    ),
                                  );

                                  if (refresh == 'refresh') {
                                    changeData();
                                  }
                                },
                                onLongPress: () {
                                  setState(() {
                                    databaseHelper.instance
                                        .remove(snapshot.data![index].id);
                                  });
                                },
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.only(left: 4, top: 4),
                                        child: Text(
                                          snapshot.data![index].title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Expanded(
                                        child: Container(
                                          padding:
                                              EdgeInsets.only(left: 4, top: 4),
                                          child: Text(
                                            snapshot.data![index].note,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
            ),
            Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    String refresh = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => inputPage(),
                      ),
                    );

                    if (refresh == 'refresh') {
                      changeData();
                    }
                  },
                  child: Text("Create New Note"),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
