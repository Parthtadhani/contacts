import 'package:contacts/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'main.dart';

class add extends StatefulWidget {
  @override
  State<add> createState() => _addState();
}

class _addState extends State<add> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  getdata() {
    data().helo().then((value) {
      setState(() {
        db = value;
      });
    });
  }
  Database? db;
  bool err = false, err1 = false, err2 = false, err3 = false;
  TextEditingController name = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    GlobalKey gf = GlobalKey();
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
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return demo1();
                      },
                    ));
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
          context: context,
        );
        return Future.value();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("New Contact"),
          backgroundColor: Colors.black,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                  onPressed: () {
                    err = false;
                    err1 = false;
                    err2 = false;
                    err3 = false;

                    String name1 = name.text;
                    String company1 = company.text;
                    String title1 = title.text;
                    String phone1 = phone.text;
                    setState(() {
                      if (name1.isEmpty) {
                        err = true;
                      } else if (company1.isEmpty) {
                        err1 = true;
                      } else if (title1.isEmpty) {
                        err2 = true;
                      } else if (phone1.isEmpty) {
                        err3 = true;
                      } else {
                        err = false;
                        err1 = false;
                        err2 = false;
                        err3 = false;

                        data()
                            .insertdata(name1, company1, title1, phone1, db!)
                            .then((value) {
                          print(
                              "------------------------------------------------------------------erer----------");
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return demo1();
                            },
                          ));
                        });
                      }
                    });
                  },
                  icon: Icon(Icons.check)),
            )
          ],
        ),
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  // margin: EdgeInsets.all(tbody*0.005),
                  padding: EdgeInsets.only(top: tbody * 0.020),
                  height: tbody * 0.1,
                  width: tw * 0.14,
                  // color: Colors.blue,
                  child: Icon(Icons.account_circle_rounded),
                ),
                Container(
                  // margin: EdgeInsets.all(tbody*0.005),
                  padding: EdgeInsets.only(top: tbody * 0.020),
                  height: tbody * 0.1,
                  width: tw * 0.82,
                  // color: Colors.red,
                  child: TextField(
                    controller: name,
                    decoration: InputDecoration(
                      errorText: err ? "error is First name" : null,
                      // border: OutlineInputBorder(),
                      hintText: "First name",
                      // labelText: "First name"
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: tbody * 0.020),
                  height: tbody * 0.1,
                  width: tw * 0.14,
                  child: Icon(Icons.add_business),
                ),
                Container(
                  padding: EdgeInsets.only(top: tbody * 0.020),
                  height: tbody * 0.1,
                  width: tw * 0.82,
                  // color: Colors.red,
                  child: TextField(
                    controller: company,
                    decoration: InputDecoration(
                      errorText: err1 ? "error is Company" : null,
                      // border: OutlineInputBorder(),
                      hintText: "Company",
                      // labelText: "Company"
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: tbody * 0.020),
                  height: tbody * 0.1,
                  width: tw * 0.14,
                ),
                Container(
                  padding: EdgeInsets.only(top: tbody * 0.020),
                  height: tbody * 0.1,
                  width: tw * 0.82,
                  child: TextField(
                    controller: title,
                    decoration: InputDecoration(
                      errorText: err2 ? "error is Title" : null,
                      // border: OutlineInputBorder(),
                      hintText: "Title",
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: tbody * 0.020),
                  height: tbody * 0.1,
                  width: tw * 0.14,
                  child: Icon(Icons.phone),
                ),
                Container(
                  padding: EdgeInsets.only(top: tbody * 0.020),
                  height: tbody * 0.1,
                  width: tw * 0.82,
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    autofillHints: [AutofillHints.telephoneNumber],
                    controller: phone,
                    decoration: InputDecoration(
                      errorText: err3 ? "error is num" : null,
                      // border: OutlineInputBorder(),
                      hintText: "phone",
                      // labelText: "phone"
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }


}
