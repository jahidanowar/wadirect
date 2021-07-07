class Contact {
  String number, message;
  Contact({this.number, this.message});

  Map<String, dynamic> toMap() {
    return {'number': this.number, 'message': this.message};
  }

  Contact.fromMap(Map<String, dynamic> mapObject) {
    this.number = mapObject['number'];
    this.message = mapObject['message'];
  }
}
