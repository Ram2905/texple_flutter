import 'dart:ui';
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  //const secondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyPage(title: 'Second Screen'),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool _expanded = false;
  TextEditingController alertController = TextEditingController();

  List<Myitem> _items = <Myitem>[
    Myitem(header: 'DTH Recharge    ', body: 'description'),
    Myitem(header: 'Salary Credited   ', body: 'description'),
    Myitem(header: 'Mobile Recharge', body: 'description'),
  ];
  //String header;
  // String description;
  String accountBal = '0';

  int notificationnum = 0;
//Dialogue Box for adding credit
  Future<String> createAlertDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Credit Amount'),
            content: TextField(
              controller: alertController,
            ),
            actions: [
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop(alertController.text.toString());
                  //accountBal = alertController; //.toString();
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              //Account Balance
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    //foregroundDecoration: ,
                    height: 50.0,
                    color: Colors.white.withOpacity(0.7),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: Text(
                              'Total Balance: $accountBal',
                              style: TextStyle(
                                  fontSize: 30.0, color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 20.0,
              ),
              //Expansion Panels for Dth,mobile recharge
              Expanded(
                child: Container(
                  height: 350.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: ListView(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ExpansionPanelList(
                            // animationDuration: Duration(milliseconds: 500),
                            expansionCallback: (int index, bool isExpanded) {
                              setState(() {
                                _items[index].isExpanded =
                                    !_items[index].isExpanded;
                              });
                            },
                            children: _items.map((Myitem item) {
                              return ExpansionPanel(
                                  headerBuilder:
                                      (BuildContext context, bool isExpanded) {
                                    return Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            item.header,
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 90.0,
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            height: 30,
                                            color: Colors.white,
                                            width: 45.0,
                                            child: Center(
                                              child: Text(
                                                '$notificationnum',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20.0),
                                              ),
                                            ),
                                          ),
                                        ) ///////////////////////////
                                      ],
                                    );
                                  },
                                  isExpanded: item.isExpanded,
                                  body: Container(
                                    child: Text(item.body,
                                        style: TextStyle(fontSize: 20.0)),
                                  ));
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // FloatingActionButton for credit
          Padding(
            padding: const EdgeInsets.only(right: 20.0, bottom: 20.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                //elevation: 100.0,
                // isExtended: true,
                child: Icon(Icons.add),
                backgroundColor: Colors.white,
                onPressed: () {
                  createAlertDialogue(context).then(
                    (onvalue) {
                      setState(() {
                        accountBal = onvalue;
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class Myitem {
  Myitem({this.isExpanded: false, this.header, this.body});

  bool isExpanded;
  final String header;
  final String body;
}
