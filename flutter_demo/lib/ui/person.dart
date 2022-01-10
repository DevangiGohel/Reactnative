
import 'package:flutter_demo/ui/DatabaseHelper.dart';

class person {
  int id;
  String name;
  int age;

  person(this.id, this.name, this.age);

  person.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    age = map['age'];
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnAge: age,
    };
  }
}
