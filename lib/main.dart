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
        primarySwatch: Colors.lightBlue,
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
  final myEmailController = TextEditingController();
  final myPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _validated = false;
  var _name = '';
  var _email = '';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myNameController.dispose();
    myEmailController.dispose();
    super.dispose();
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _validated = true;
      _formKey.currentState.save();
    }
  }

  String validateName(String value) {
    if (value.length < 3)
      return 'Name must be filled';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SafeArea(
            child: Container(
              child : new Form(
                key: _formKey,
                autovalidate: _validated,
                child: FormUI(),
              )
            )
        )
      );
  }

  // Here is our Form UI
  Widget FormUI() {
    return new Column(
      children: <Widget>[
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 100),
            child: new Image.asset(
              "assets/images/home_banner.jpeg",
              fit: BoxFit.cover,
            )
        ),

        new Container(
          width: 300.0,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Name',
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              prefixIcon: Icon(Icons.person_outline),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
            ),
            keyboardType: TextInputType.text,
            controller: myNameController,
            validator: validateName,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
            onSaved: (String val) {
              _name = val;
            },
          ),
        ),

        new SizedBox(
          height: 10.0,
        ),

        new Container(
          width: 300.0,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              contentPadding: EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 15.0),
              prefixIcon: Icon(Icons.email),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            controller: myEmailController,
            validator: validateEmail,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
            onSaved: (String val) {
              _email = val;
            },
          ),
        ),

        new SizedBox(
          height: 10.0,
        ),

        new RaisedButton(
              color: Colors.lightBlue,
              child: Text(
                'Join in!',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _validateInputs();
                if (_validated == false){
                  return null;
                }
                else{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FirstRoute(),
                      settings: RouteSettings(
                          arguments: ScreenArguments(_name, _email))),
                );
                }
              },
          )

      ]
    );
  }

}

class ScreenArguments {
  final String name;
  final String email;

  ScreenArguments(this.name, this.email);
}

  _launchURL() async {
  const url = 'https://www.meetup.com/coding-dojo-toronto/';
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
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                  image: NetworkImage(
                      'https://media3.giphy.com/media/aOften89vRbG/giphy.gif?cid=790b761191dcb1e98801cd65b752f66f9e8a99334de7bf39&rid=giphy.gif')),
              Text('Hey ' + info.name),
              Text('an Email was sent to: ' + info.email),
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
        backgroundColor: Colors.lightBlue,
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
