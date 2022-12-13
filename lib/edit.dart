import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'db.dart';

class EditData extends StatefulWidget {
  int rollno;
  EditData({required this.rollno});

  @override
  State<StatefulWidget> createState() {
    return _EditData();
  }
}

class _EditData extends State<EditData> {
  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();

  MyDb mydb = new MyDb();

  @override
  void initState() {
    mydb.open();

    Future.delayed(Duration(milliseconds: 500), () async {
      var data = await mydb.getData(widget.rollno);
      if (data != null) {
        name.text = data["name"];
        rollno.text = data["roll_no"].toString();
        setState(() {});
      } else {
        print("No any data with roll no : " + widget.rollno.toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Data"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Produk",
                ),
              ),
              TextField(
                controller: rollno,
                decoration: InputDecoration(
                  hintText: "Kategory",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "UPDATE data SET name = ?, roll_no = ? WHERE roll_no = ?",
                        [name.text, rollno.text, widget.rollno]);

                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Data Updated")));
                  },
                  child: Text("Update Data")),
            ],
          ),
        ));
  }
}
