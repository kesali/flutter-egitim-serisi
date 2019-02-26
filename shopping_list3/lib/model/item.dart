class Item {
  int id;
  String name;
  bool isCompleted;
  bool isArchived;

  Item(this.id, this.name, this.isCompleted, this.isArchived);

  factory Item.fromJson(Map<String, dynamic> map){
    return Item(map['id'], map['name'], map['isCompleted'], map['isArchived']);
  }
}