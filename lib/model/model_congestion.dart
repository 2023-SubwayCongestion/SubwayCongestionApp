class Congestion{
  final String lastDest;
  final String time;
  final List<int> items;

  Congestion.fromMap(Map<String, dynamic> map)
      : lastDest = map['lastDest'],
        time = map['time'],
        items = map['items'];

  @override
  String toString() {
    // TODO: implement toString
    return "Congestion<$lastDest>";
  }
}