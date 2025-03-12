import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyCrud extends StatefulWidget {
  const MyCrud({super.key});

  @override
  State<MyCrud> createState() => _MyCrudState();
}

class _MyCrudState extends State<MyCrud> {
  late Database database;
  TextEditingController name = TextEditingController();
  TextEditingController dept = TextEditingController();

  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  Future<void> initDatabase() async {
    database = await openDatabase(join(await getDatabasesPath(), 'my.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE DEMO(ID INTEGER PRIMARY KEY AUTOINCREMENT,NAME TEXT,DEPT TEXT)',
          );
        }, version: 1);
  }

  Future<void> fetchData() async {
    List<Map<String, dynamic>> tempdata = await database.query('DEMO');
    setState(() {
      data = tempdata;
    });
  }

  Future<void> addData(String name, String dept) async {
    if (name.isNotEmpty && dept.isNotEmpty) {
      await database.insert('DEMO', {'NAME': name, 'DEPT': dept});
    }
    fetchData();
  }

  Future<void> updateData(int id, String name, String dept) async {
    if (name.isNotEmpty && dept.isNotEmpty) {
      await database.update('DEMO', {'NAME': name, 'DEPT': dept}, where: 'ID = ?', whereArgs: [id]);
    }
    fetchData();
  }

  Future<void> deleteData(int id) async {
    await database.delete('DEMO', where: 'ID = ?', whereArgs: [id]);
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Database Demo"),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: name,
                          decoration: InputDecoration(labelText: "Name", border: OutlineInputBorder()),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: dept,
                          decoration: InputDecoration(labelText: "Department", border: OutlineInputBorder()),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10)),
                            onPressed: () {
                              addData(name.text, dept.text);
                              name.clear();
                              dept.clear();
                              Navigator.pop(context);
                            },
                            child: Text('Submit', style: TextStyle(fontSize: 16)))
                      ],
                    ),
                  );
                });
          },
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.add, color: Colors.white),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                elevation: 5,
                child: ListTile(
                  title: Text(data[index]['NAME']?.toString() ?? 'No NAME',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Text(data[index]['DEPT']?.toString() ?? 'No DEPT',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            name.text = data[index]['NAME']?.toString() ?? '';
                            dept.text = data[index]['DEPT']?.toString() ?? '';
                            showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                                builder: (context) {
                                  return Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: name,
                                          decoration: InputDecoration(labelText: "Name", border: OutlineInputBorder()),
                                        ),
                                        SizedBox(height: 10),
                                        TextField(
                                          controller: dept,
                                          decoration: InputDecoration(labelText: "Department", border: OutlineInputBorder()),
                                        ),
                                        SizedBox(height: 10),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blueAccent,
                                                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10)),
                                            onPressed: () {
                                              updateData(data[index]["ID"], name.text, dept.text);
                                              name.clear();
                                              dept.clear();
                                              Navigator.pop(context);
                                            },
                                            child: Text("Update", style: TextStyle(fontSize: 16)))
                                      ],
                                    ),
                                  );
                                });
                          },
                          icon: Icon(Icons.edit, color: Colors.blue)),
                      IconButton(
                          onPressed: () {
                            deleteData(data[index]["ID"]);
                          },
                          icon: Icon(Icons.delete, color: Colors.red))
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}