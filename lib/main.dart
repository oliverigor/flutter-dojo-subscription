import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OLIVER FLUTTER',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Join Meet up Toronto'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myNameController = TextEditingController();
  final myPasswordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myNameController.dispose();
    myPasswordController.dispose();
    super.dispose();
  }

  var _name = '';
  var _email = '';

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _name = myNameController.text;
      _email = myPasswordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: SafeArea(
          child: Column(children: <Widget>[
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 100),
            child: CircleAvatar(
              radius: 100.0,
              backgroundImage: NetworkImage(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
            )),
        Container(
            height: 150.0,
            margin: const EdgeInsets.symmetric(horizontal: 6.0),
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.person_outline),
                  title: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                    controller: myNameController,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    controller: myPasswordController,
                  ),
                ),
              ],
            )),
        Container(
            width: 100,
            child: RaisedButton(
              color: Colors.lightBlue,
              child: Text(
                'Join in!',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _incrementCounter();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FirstRoute(),
                      settings: RouteSettings(
                          arguments: ScreenArguments(_name, _email))),
                );
              },
            )),
      ])),
    );
  }
}

class ScreenArguments {
  final String name;
  final String email;

  ScreenArguments(this.name, this.email);
}

  _launchURL() async {
  const url = 'https://flutter.dev';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments info = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                  image: NetworkImage(
                      'https://media3.giphy.com/media/aOften89vRbG/giphy.gif?cid=790b761191dcb1e98801cd65b752f66f9e8a99334de7bf39&rid=giphy.gif')),
              Text('Hey ' + info.name),
              Text('And email was sent to: ' + info.email),
              Container(
                width: 200,
                child: RaisedButton(
                  color: Colors.lightBlue,
                  child: Text(
                    "Go to Meetup Page",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  onPressed: () {
                     _launchURL();
                  },
              )
            ),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(
            context,
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.arrow_left),
      ),
    );
  }
}
