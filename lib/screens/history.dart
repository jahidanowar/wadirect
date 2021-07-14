import 'package:directwp/models/Contact.dart';
import 'package:directwp/services/DbProvider.dart';
import 'package:directwp/utils/sendMessage.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  static final routeName = '/history';

  const HistoryScreen({Key key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Contact> _contacts;

  @override
  void initState() {
    // TODO: Fetch All the data from DB
    _getHistory();
    super.initState();
  }

  void _getHistory() async {
    var dbProvider = DbProvider();
    await dbProvider.init();
    List<Map> contacts = await dbProvider.fetchItems();
    setState(() {
      _contacts = contacts.map((e) => Contact.fromMap(e)).toList();
    });

    print(_contacts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        centerTitle: true,
      ),
      body: _contacts != null && _contacts.length > 0
          ? ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (ctx, index) {
                return Card(
                  child: ListTile(
                    tileColor: Colors.white,
                    title: Text(_contacts[index].number),
                    subtitle: Text(_contacts[index].message),
                    horizontalTitleGap: 10.0,
                    trailing: IconButton(
                      color: Theme.of(context).accentColor,
                      icon: Icon(
                        Icons.north_east_rounded,
                      ),
                      onPressed: () {
                        print(_contacts[index].number);
                        sendMessage(
                            number: _contacts[index].number,
                            message: _contacts[index].message);
                      },
                    ),
                  ),
                );
              })
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
