class Contact {
  int id;
  String number, message;
  DateTime createdAt;

  Contact({this.id, this.number, this.message, this.createdAt});

  Map<String, dynamic> toMap() {
    return {'id': this.id, 'number': this.number, 'message': this.message};
  }

  Contact.fromMap(Map<String, dynamic> mapObject) {
    this.id = mapObject['id'];
    this.number = mapObject['number'];
    this.message = mapObject['message'];
    this.createdAt = mapObject['createdAt'];
  }
}
