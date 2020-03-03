import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final inputBorder = BorderRadius.vertical(
    bottom: Radius.circular(10.0),
    top: Radius.circular(20.0),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Direct Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.teal,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 0.0, style: BorderStyle.none),
              borderRadius: const BorderRadius.all(
                const Radius.circular(5.0),
              ),
            ),
          ),
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.teal,
              padding: EdgeInsets.symmetric(vertical: 15.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)))),
      home: MyHomePage(title: 'Direct Chat'),
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

  //Global Key TO Access Form State
  final formKey = GlobalKey<FormState>();

  //Global Key to Access Scafold State

  final scafoldKey = GlobalKey<ScaffoldState>();

  //Form Data 
  String phoneNumber;
  String message;

  // Function to send message
  _sendMessage() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      // String wpUrl = "https://api.whatsapp.com/send?phone=$phoneNumber&text=$message";
      String wpUrl = "https://wa.me/$phoneNumber?text=$message";

      if (await canLaunch(wpUrl)) {
        await launch(wpUrl);
        print(wpUrl);
      } else {
        throw "Coudn't Launch the $wpUrl";
      }
    }
  }

  // FUnction to Copy Chat Link
  _copyLink() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      String wpUrl =
          "https://api.whatsapp.com/send?phone=$phoneNumber&text=$message";
      Clipboard.setData(ClipboardData(text: wpUrl));
      final snackBar = SnackBar(
        content: Text('Whatsapp chat link copied to clipboard'),
      );
      // Find the Scaffold in the widget tree and use
      // it to show a SnackBar.
      scafoldKey.currentState.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/img/bg.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Container(
              margin: EdgeInsets.all(30.0),
              child: Form(
                key: formKey,
                child: ListView(
                  children: <Widget>[
                    logo(),
                    SizedBox(height: 30.0),
                    myLabel("Phone Number"),
                    phoneNumberField(),
                    SizedBox(
                      height: 20.0,
                    ),
                    myLabel("Message"),
                    messageField(),
                    SizedBox(height: 20),
                    submitButton(),
                    SizedBox(height: 30),
                    credits(),
                  ],
                ),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _copyLink,
        tooltip: 'Copy Chat Link',
        child: Icon(Icons.content_copy),
      ),
    );
  }


//Widgets
  Widget logo() {
    return Image.asset(
      "assets/img/logo-outlined.png",
      width: 120,
      height: 120,
    );
  }

  Widget myLabel(String myLabelText) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        myLabelText,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  Widget phoneNumberField() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          // labelText: "Phone No. with Country Code",
          hintText: "916295790000",
          // border: OutlineInputBorder(),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return "Enter a Phone Number";
          } else if (value.length != 12) {
            return "Enter a Valid phone number with the country Code";
          }
          if (value.contains('+')) {
            return "Remove the + sign";
          }
        },
        onSaved: (String value) {
          phoneNumber = value;
        },
      ),
    );
  }

  Widget messageField() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: TextFormField(
        maxLines: 4,
        minLines: 4,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          // labelText: "Enter Your Message",
          hintText: "Hi, How are you?",
        ),
        validator: (String value) {
          //Return NULL if valid
          // Otherwise String with Error Message
          if (value.length >= 100) {
            return "Maximum 100 Character Allowed";
          }
        },
        onSaved: (String value) {
          message = value;
        },
      ),
    );
  }

  Widget submitButton() {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        onPressed: _sendMessage,
        child: Text(
          "Send Message",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget credits() {
    return Align(
      alignment: Alignment.center,
      child: Text("Crafted with ❤️ by Foxflue Network"),
    );
  }
}