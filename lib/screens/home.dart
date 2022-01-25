import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:directwp/models/Contact.dart';
import 'package:directwp/screens/about.dart';
import 'package:directwp/screens/help.dart';
import 'package:directwp/services/DbProvider.dart';
import 'package:directwp/utils/sendMessage.dart';
import 'package:directwp/utils/trimWhiteSpaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  static final routeName = "/home";

  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Global Key TO Access Form State
  final formKey = GlobalKey<FormState>();

  //Global Key to Access Scafold State
  final scafoldKey = GlobalKey<ScaffoldState>();

  //Form Data
  String countryCode;
  String phoneNumber;
  String message;

  @override
  void initState() {
    super.initState();
    _getCountryCode();
  }

  void _getCountryCode() async {
    try {
      print("Inside initState");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      countryCode = prefs.getString("countryCode");
      if (countryCode == null || countryCode.isEmpty) {
        countryCode = "IN";
      }
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void _setCountryCode(String isoCode) async {
    print("Inside setCountryCode");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("countryCode", isoCode);
    print('$isoCode Country Code Saved');
  }

  _saveData(number, message) async {
    var dbProvider = DbProvider();
    await dbProvider.init();
    dbProvider
        .insertItem(Contact(number: trimWhiteSpaces(number), message: message));
    // print(dbProvider.insertItem(Contact(number: number, message: message)));
    // print(Contact(number: number, message: message).toMap());
    // print(await dbProvider.fetchItems());
  }

  // Function to send message
  _sendMessage() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      // Save Data
      String completePhoneNumber =
          CountryPickerUtils.getCountryByIsoCode(countryCode).phoneCode +
              phoneNumber;
      _saveData(completePhoneNumber, message);
      // Redirect to whatsapp

      var messageSent =
          await sendMessage(number: completePhoneNumber, message: message);
      if (!messageSent) {
        throw "Coudn't Launch the $phoneNumber";
      }
    }
  }

  // FUnction to Copy Chat Link
  _copyLink() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      String completePhoneNumber =
          CountryPickerUtils.getCountryByIsoCode(countryCode).phoneCode +
              phoneNumber;
      _saveData(completePhoneNumber, message);
      String wpUrl =
          "https://api.whatsapp.com/send?phone=$completePhoneNumber&text=$message";
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
        title: Text('Direct Chat'),
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
                    myLabel("Selected Country"),
                    countryPicker(),
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
        child: Icon(Icons.content_copy_rounded),
      ),
    );
  }

//Widgets
  Widget helpActionButton() {
    return IconButton(
      icon: Icon(Icons.help_outline_rounded),
      tooltip: "Helps",
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HelpScreen()));
      },
    );
  }

  Widget aboutActionButton() {
    return IconButton(
      icon: Icon(Icons.more_vert_rounded),
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
      width: 100,
      height: 100,
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

  Widget countryPicker() {
    return Builder(builder: (context) {
      return countryCode != null && countryCode.isNotEmpty
          ? Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: CountryPickerDropdown(
                dropdownColor: Colors.white,
                isDense: true,
                icon: Icon(Icons.arrow_drop_down_rounded),
                initialValue: countryCode,
                priorityList: [
                  CountryPickerUtils.getCountryByIsoCode('IN'),
                  CountryPickerUtils.getCountryByIsoCode('BD'),
                  CountryPickerUtils.getCountryByIsoCode('PK'),
                  CountryPickerUtils.getCountryByIsoCode('GB'),
                ],
                onValuePicked: (Country country) {
                  print(country.isoCode);
                  print(countryCode);
                  setState(() {
                    countryCode = country.isoCode;
                  });
                  // Save the country code to shared preferences
                  _setCountryCode(countryCode);
                },
              ),
            )
          : Container();
    });
  }

  Widget phoneNumberField() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          // labelText: "Phone No. with Country Code",
          hintText: "6295790000",
          // border: OutlineInputBorder(),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return "Enter a Phone Number";
          } else if (value.length != 10) {
            return "Enter a Valid phone number with the country Code";
          }
          if (value.contains('+')) {
            return "Remove the + sign";
          }
          return null;
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
          return null;
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
      child: ElevatedButton(
        onPressed: _sendMessage,
        child: Text(
          "Send Message",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
