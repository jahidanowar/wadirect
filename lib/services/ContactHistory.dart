import 'package:directwp/models/Contact.dart';

class ContactHistory {
  Contact contact;

  ContactHistory({this.contact});

  void save() {
    // Do something to save the contact
    print(this.contact.toMap());
  }
}
