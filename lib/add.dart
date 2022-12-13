import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite/db.dart';

class AddData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddData();
  }
}

class _AddData extends State<AddData> {
  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();

  MyDb mydb = new MyDb();

  @override
  void initState() {
    mydb.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Data"),
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
                        "INSERT INTO data (name, roll_no) VALUES (?, ?);",
                        [name.text, rollno.text]);

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("New Data Added")));

                    name.text = "";
                    rollno.text = "";
                  },
                  child: Text("Save Data")),
            ],
          ),
        ));
  }
}
