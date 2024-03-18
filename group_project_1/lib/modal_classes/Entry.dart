class Entry {
  int? entryId;
  int id;
  String animal;
  double fat;
  double quantity;
  String date;
  double total;

  Entry({
    // this.entryId,
    required this.id,
    required this.animal,
    required this.fat,
    required this.quantity,
    required this.date,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'entryId': entryId,
      'id': id,
      'animal': animal,
      'fat': fat,
      'quantity': quantity,
      'date': date,
      'total': total,
    };
  }
}
