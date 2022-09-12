import 'dart:io';

import 'package:contacts/data.dart';
import 'package:contacts/delete_and_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'addcontacts.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: demo1()));
}

class demo1 extends StatefulWidget {
  @override
  State<demo1> createState() => _demo1State();
}

class _demo1State extends State<demo1> {
  bool st1 = true;
  Database? db;
  List<Map> list1 = [];
  List<Map> lists = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewdat();
  }

  viewdat() {
    data().helo().then((value) {
      setState(() {
        db = value;
      });
      data().viewdat(db!).then((viewlist) {
        setState(() {
          list1 = viewlist;
          lists = viewlist;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double th = MediaQuery.of(context).size.height;
    double tw = MediaQuery.of(context).size.width;
    double ap = kToolbarHeight;
    double st = MediaQuery.of(context).padding.top;
    double nt = MediaQuery.of(context).padding.bottom;

    double tbody = th - st - ap - nt;

    return WillPopScope(
      onWillPop: () {
        showDialog(
          builder: (context) {
            return AlertDialog(
              title: Text("Exit"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      exit(0);
                    },
                    child: Text("yes")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("No"))
              ],
            );
          },
          context: context,
        );
        return Future.value();
      },
      child: Scaffold(
        appBar: st1
            ? AppBar(
                title: Text("Contacts"),
                backgroundColor: Colors.black,
                actions: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            st1 = false;
                          });
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : AppBar(
                backgroundColor: Colors.black,
                title: TextField(
                  decoration: InputDecoration(
                      suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              lists = list1;
                              st1 = true;
                            });
                          },
                          icon: Icon(Icons.close))),
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        lists = [];
                        for (int i = 0; i < list1.length; i++) {
                          String name = list1[i]['name'];
                          if (name.toLowerCase().contains(value.toLowerCase()))
                          {
                            lists.add(list1[i]);
                            print(
                                "======================================$lists");
                          }
                        }
                      } else {
                        lists = list1;
                      }
                    });
                  },
                  style: TextStyle(color: Colors.white),
                ),
              ),
        body: ListView.builder(
          itemCount: st1 ? list1.length : lists.length,
          itemBuilder: (context, index) {
            Map map = st1 ? list1[index] : lists[index];
            return Card(
                elevation: 2,
                child: ListTile(
                  title: Text("${map['name']}"),
                  subtitle: Text("${map['number']}"),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: PopupMenuButton(
                          onSelected: (int value) {
                            if (value == 1) {
                              int id = list1[index]['id'];
                              data().detel(id, db!);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return demo1();
                                },
                              ));
                            } else if (value == 2) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return edit(list1, index);
                                },
                              ));
                            }
                          },
                          elevation: 20,
                          enabled: true,
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Text("delete"),
                                  value: 1,
                                ),
                                PopupMenuItem(
                                  child: Text("edit"),
                                  value: 2,
                                ),
                              ])),
                ));
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return add();
                },
              ));
            },
            label: Icon(
              Icons.add,
              color: Colors.white,
            )),
      ),
    );
  }
}
