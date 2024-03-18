class Farmer {
  int id;
  String name;
  int number;
  String city;
  int accNumber;

  Farmer({
    required this.id,
    required this.name,
    required this.number,
    required this.city,
    required this.accNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fname': name,
      'number': number,
      'city': city,
      'accNumber': accNumber
    };
  }

  Map<String, dynamic> updateData(int id) {
    return {
      'id': id,
      'fname': name,
      'number': number,
      'city': city,
      'accNumber': accNumber
    };
  }
}
