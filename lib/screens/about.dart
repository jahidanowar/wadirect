import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  static final routeName = "/about";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
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
                SizedBox(
                  height: 20.0,
                ),
                Image.asset(
                  "assets/img/logo.png",
                  width: 150,
                  height: 150,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Direct Chat helps you to Message anyone on the WhatsApp without Saving their Contact  Number. It also helps you to generate personalized WhatsApp link with a predefined message and share it with your audience on your Social Networks!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    height: 1.8,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FlatButton(
                  // color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    String wpUrl = "https://directwa.foxflue.com/privacy";
                    if (await canLaunch(wpUrl)) {
                      await launch(wpUrl);
                      print(wpUrl);
                    } else {
                      throw "Coudn't Launch the $wpUrl";
                    }
                  },
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                GestureDetector(
                    onTap: () async {
                      String wpUrl = "https://directwa.foxflue.com/";
                      if (await canLaunch(wpUrl)) {
                        await launch(wpUrl);
                        print(wpUrl);
                      } else {
                        throw "Coudn't Launch the $wpUrl";
                      }
                    },
                    child: Text(
                      "Crafted with ❤️ by Foxflue",
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
