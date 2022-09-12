import 'package:contacts/data.dart';
import 'package:contacts/main.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class edit extends StatefulWidget {
  List<Map> list1;
  int index;

  edit(this.list1, this.index);

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  Database? db;
  bool err = false, err1 = false, err2 = false, err3 = false;

  TextEditingController name = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController phone = TextEditingController();


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = widget.list1[widget.index]['name'];
    company.text = widget.list1[widget.index]['company'];
    title.text = widget.list1[widget.index]['title'];
    phone.text = widget.list1[widget.index]['number'];
    getdate();
  }
  void getdate() {
    data().helo().then((value) {
      setState(() {
        db=value;
      });
    },);
  }


  @override
  Widget build(BuildContext context) {
    double th = MediaQuery.of(context).size.height;
    double tw = MediaQuery.of(context).size.width;
    double ap = kToolbarHeight;
    double st = MediaQuery.of(context).padding.top;
    double nt = MediaQuery.of(context).padding.bottom;
    double tbody = th - st - ap - nt;
    return Scaffold(
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
                      int id=widget.list1[widget.index]['id'];
                      data().update(name1,company1,title1,phone1,db!,id);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return demo1();
                      },));
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
                padding: EdgeInsets.only(top: tbody * 0.020),
                height: tbody * 0.1,
                width: tw * 0.14,
                child: Icon(Icons.account_circle_rounded),
              ),
              Container(
                padding: EdgeInsets.only(top: tbody * 0.020),
                height: tbody * 0.1,
                width: tw * 0.82,
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    errorText: err ? "error is First name" : null,
                    hintText: "First name",
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
                child: TextField(
                  controller: company,
                  decoration: InputDecoration(
                    errorText: err1 ? "error is Company" : null,
                    hintText: "Company",
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
    );
  }


}
