class Overview {
  int total;
  int current;
  int completed;
  int deleted;

  Overview({this.total, this.current, this.completed, this.deleted});

  factory Overview.fromJson(Map<String, dynamic> map) {
    return Overview(
        total: map['total'],
        current: map['current'],
        completed: map['completed'],
        deleted: map['deleted']);
  }
}
