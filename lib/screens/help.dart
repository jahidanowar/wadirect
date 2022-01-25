import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  static final routeName = "/help";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Helps"),
        centerTitle: true,
        actions: <Widget>[],
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
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                Text(
                  "Direct Chat helps you to Message anyone on the WhatsApp without Saving their Contact  Number. It also helps you to generate personalized WhatsApp link with a predefined message and share it with your audience on your Social Networks!",
                  style: TextStyle(
                    fontSize: 16.0,
                    height: 1.8,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "How to use Direct Chat?",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Step 1:",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Enter phone number in international format. Make sure that you don’t include any other characters in the phone number, only numeric/integer values.",
                  style: TextStyle(
                    fontSize: 15.0,
                    height: 1.8,
                  ),
                ),
                Text(
                  "Here is an example:",
                  style: TextStyle(
                    fontSize: 15.0,
                    height: 1.8,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "My Phone Number: 076 848 3016",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "I have to Enter the Number as: 768483016",
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Step 2:",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Write Your Message in the Message Field. You can type All types of Character. Maximum 250 Character allowed in this field. If you want to add more character You can do it from Whatsapp Message Field.",
                  style: TextStyle(fontSize: 15.0, height: 1.8),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Step 3:",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "If You want to send the message Directly then click the \"Send Message\" Button. If you want to copy the message link click on the Copy Button on the Bottom Right Corner. You can use this message link in Facebook or Twitter page. If some one click this link they can directly message the given number without saving their Phone Number.",
                  style: TextStyle(fontSize: 15.0, height: 1.8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
