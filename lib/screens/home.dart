import 'package:directwp/screens/about.dart';
import 'package:directwp/screens/help.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_admob/firebase_admob.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Admob Integreation
  MobileAdTargetingInfo targetingInfo;
  BannerAd myBanner;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['flutterio', 'beautiful apps'],
      contentUrl: 'https://flutter.io',
      childDirected: false,
      testDevices: <String>[], // Android emulators are considered test devices
    );
    myBanner = BannerAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
      adUnitId: "ca-app-pub-4583874558160900/1862388924",
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );

    myBanner
      // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 0.0,
        // Positions the banner ad 10 pixels from the center of the screen to the right
        horizontalCenterOffset: 0.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
  }

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
        actions: <Widget>[
          helpActionButton(),
          aboutActionButton(),
        ],
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
              margin: const EdgeInsets.all(30.0),
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
                    // credits(),
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

  Widget helpActionButton() {
    return IconButton(
      icon: Icon(Icons.help_outline),
      tooltip: "Helps",
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HelpScreen()));
      },
    );
  }

  Widget aboutActionButton() {
    return IconButton(
      icon: Icon(Icons.more_vert),
      tooltip: "About",
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AboutScreen()));
      },
    );
  }

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
        maxLines: 3,
        minLines: 3,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          // labelText: "Enter Your Message",
          hintText: "Hi, How are you?",
        ),
        validator: (String value) {
          //Return NULL if valid
          // Otherwise String with Error Message
          if (value.length >= 500) {
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
}
