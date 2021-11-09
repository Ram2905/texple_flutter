import 'package:flutter/material.dart';
import 'package:texple_flutter/screens/secondScreen1.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class MyApp1 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Login Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  final _dataService = DataService();
  String _response;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  checkAuth() async {
    _auth.onAuthStateChanged.listen((user) {
      if (user != Null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SecondScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuth();
  }

  void _makeRequest() async {
    final response = await _dataService.makeRequestToApi();
    setState(() => _response = response);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    Icons.call,
                    size: 40,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: TextField(
                      controller: myController,
                      maxLength: 10,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter the number'),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                ],
              ),
              SizedBox(
                height: 100.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    child: const Text(' Login ',
                        style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Builder(builder: (_) {
                    String input = myController.text;
                    if (_response ==
                            '{"message":"The mobile number is not registered!!!"}' &&
                        input == '8169965998') {
                      return Text(_response);
                    } else {
                      return OutlinedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue)),
                        onPressed: () {
                          _makeRequest;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondScreen()),
                          );
                        },
                        child: const Text('Register',
                            style: TextStyle(color: Colors.white)),
                      );
                    }
                  }),
                ],
              ),

              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataService {
  Future<String> makeRequestToApi() async {
    final Map<String, String> _qParam = <String, String>{
      'MobileNumber': '8169965998'
    };
    final url = Uri.http('13.235.89.254:3001', '/api/transactions', _qParam);
    final response = await http.post(url);
    return response.body;
  }
}
