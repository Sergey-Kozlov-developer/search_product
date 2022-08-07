
class Item {
  final String name;
  final String subName;
  final String unit;
  final String image;

  Item({
    required this.name,
    required this.subName,
    required this.unit,
    required this.image,
  });

  Map toJson() {
    return {
      'name': name,
      'subName': subName,
      'unit': unit,
      'image': image,
    };
  }
}
