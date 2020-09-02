import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/data.dart';

class testList extends StatefulWidget {
  @override
  _testListState createState() => _testListState();
}

class _testListState extends State<testList> {

  var loading = false;
  List<Record> dataModel = [];

  Future<Null> getData() async {
    final responseData = await http.get(
        "https://test.chatongo.in/testdata.json");

    if (responseData.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(responseData.body);
      LinkedHashMap<String, dynamic> data = map["data"];
      List<dynamic> newData = data["Records"];

      //print("newData: $newData");
      setState(() {
        for (Map i in newData) {
          dataModel.add(Record.fromJson(i));
          // print("newData: $data");
        }
        loading = false;
      });
    }
  }
  

  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Machine Test Chinmay Chalke",style: TextStyle(
            color: Colors.black87
          ),),
          backgroundColor: Color(0xffffea00),
        ),
        body: Container(
            child: loading ? Center(
                child: CircularProgressIndicator()) :
            ListView.builder(
              itemCount: dataModel.length,
              itemBuilder: (context, i) {
                final nDataList = dataModel[i];
                DateTime startDate = new DateFormat("dd/MM/yyyy").parse(nDataList.startDate);
                DateTime endDate = new DateFormat("dd/MM/yyyy").parse(nDataList.endDate);
                final difference = endDate.difference(startDate).inDays;
                print("startDate $startDate");
                print("endDate $endDate");
                print("difference $difference");

                return Container(
                  color: Color(0xff00838f),
                  child: Stack(
                    children: <Widget>[
                  Align(
                  alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,100),
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            //color: Colors.lightBlueAccent,
                            image: DecorationImage(
                                image:NetworkImage(nDataList.mainImageUrl),
                              fit: BoxFit.cover
                            )),
                      ),
                    ),
                  ),
                  Positioned(
                  top: 220,
                  right: 10,
                  left: 10,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Card(
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.fromLTRB(0,8.0,0,0),
                                  child: Text(nDataList.title,
                                      style: TextStyle(fontWeight: FontWeight.w500)),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.fromLTRB(0,15.0,0,5.0),
                                  child: Text(nDataList.shortDescription,style: TextStyle(
                                      color: Colors.black,fontSize: 15.0
                                  ),),
                                ),
                                trailing: Container(
                                  height: 20.0,
                                  child: Image.asset('images/heart.png'),
                                ),

                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10,0,0,0),
                            child: CircleAvatar(
                              radius: 35.0,
                              backgroundColor: Color(0xff004d40),
                              child: Text('100%',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 5, 30, 5),
                              child: Text(nDataList.collectedValue.toString(),style: TextStyle(
                                color: Colors.white,fontSize: 15.0
                              ),),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 50, 5),
                              child: Text(nDataList.totalValue.toString(),style: TextStyle(
                                color: Colors.white,fontSize: 15.0
                              ),),
                            ),
                          ),
                          Container(

                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 2.5, 5),
                              child: Text(difference.toString(),style: TextStyle(
                                color: Colors.white,fontSize: 15.0
                              ),),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(50.0,0,0,0),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.0),
                                  side: BorderSide(color: Colors.white)),
                              onPressed: () {},
                              textColor: Color(0xff00838f),
                              color: Colors.white,
                              child: Text("PLEDGE".toUpperCase(),
                                  style: TextStyle(fontSize: 14)),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 5, 25, 20),
                              child: Text('Funds',style: TextStyle(
                                  color: Colors.white,fontSize: 15.0
                              ),),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 5, 25, 20),
                              child: Text('Goals',style: TextStyle(
                                  color: Colors.white,fontSize: 15.0
                              ),),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 5, 2.5, 20),
                              child: Text('Ends In',style: TextStyle(
                                  color: Colors.white,fontSize: 15.0
                              ),),
                            ),
                          ),
                        ],
                      ),

                    ],

                  ),
                  )
                  ]
                  ,
                  ),
                );
              },
            )
        ),
      ),
    );
  }
}
