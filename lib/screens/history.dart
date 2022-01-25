import 'package:directwp/models/Contact.dart';
import 'package:directwp/services/DbProvider.dart';
import 'package:directwp/utils/formatTimestamp.dart';
import 'package:directwp/utils/sendMessage.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  static final routeName = '/history';

  const HistoryScreen({Key key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  var dbProvider = DbProvider();
  List<Contact> _contacts;

  @override
  void initState() {
    // TODO: Fetch All the data from DB
    _getHistory();
    super.initState();
  }

  void _getHistory() async {
    await dbProvider.init();
    List<Map> contacts = await dbProvider.fetchItems();
    print(contacts);
    if (contacts != null && contacts.length > 0) {
      setState(() {
        _contacts = contacts.map((e) => Contact.fromMap(e)).toList();
      });
    }
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
                return Dismissible(
                  key: ValueKey<int>(_contacts[index].id),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      await dbProvider.deleteItem(_contacts[index].id);
                      setState(() {
                        _contacts.removeAt(index);
                      });
                      return true;
                    } else if (direction == DismissDirection.startToEnd) {
                      sendMessage(
                          number: _contacts[index].number,
                          message: _contacts[index].message);
                    }
                    return false;
                  },
                  background: slideRightBackground(),
                  secondaryBackground: slideLeftBackground(),
                  child: Card(
                    child: ListTile(
                      // Eclude the first two characters from the number
                      title: Text(_contacts[index].number.substring(2)),
                      subtitle: Text(_contacts[index].message),
                      horizontalTitleGap: 10.0,
                      trailing: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 12,
                        children: <Widget>[
                          Icon(
                            Icons.query_builder_rounded,
                          ),
                          Text(formatTimeStamp(_contacts[index].createdAt))
                        ],
                      ),
                    ),
                  ),
                );
              })
          : Center(
              child: Text("You don't have any records"),
            ),
    );
  }
}

Widget slideRightBackground() {
  return Card(
    color: Colors.green,
    child: Align(
      alignment: Alignment.centerLeft,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        SizedBox(
          width: 20,
        ),
        Icon(
          Icons.open_in_new_rounded,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
        Text("Send",
            style: TextStyle(color: Colors.white), textAlign: TextAlign.left)
      ]),
    ),
  );
}

Widget slideLeftBackground() {
  return Card(
    color: Colors.red,
    child: Align(
      alignment: Alignment.centerRight,
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        Icon(
          Icons.delete_rounded,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
        Text("Delete",
            style: TextStyle(color: Colors.white), textAlign: TextAlign.left),
        SizedBox(
          width: 20,
        ),
      ]),
    ),
  );
}
