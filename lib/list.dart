import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite/db.dart';
import 'package:sqlite/edit.dart';

class ListData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListData();
  }
}

class _ListData extends State<ListData> {
  List<Map> slist = [];
  MyDb mydb = new MyDb();

  @override
  void initState() {
    mydb.open();
    getdata();
    super.initState();
  }

  getdata() {
    Future.delayed(Duration(milliseconds: 500), () async {
      slist = await mydb.db.rawQuery('SELECT * FROM data');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Data"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: slist.length == 0
              ? Text("No any Data.")
              : Column(
                  children: slist.map((stuone) {
                    return Card(
                      child: ListTile(
                        title: Text(stuone["name"]),
                        subtitle:
                            Text("Kategory : " + stuone["roll_no"].toString()),
                        trailing: Wrap(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return EditData(rollno: stuone["roll_no"]);
                                  }));
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () async {
                                  await mydb.db.rawDelete(
                                      "DELETE FROM data WHERE roll_no = ?",
                                      [stuone["roll_no"]]);
                                  print("Data Deleted");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Data Deleted")));
                                  getdata();
                                },
                                icon: Icon(Icons.delete, color: Colors.red))
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
