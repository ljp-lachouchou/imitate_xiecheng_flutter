import 'package:flutter_learn/learn/oop_learn.dart';

///Dart泛型
void main() {
  Cache<String> cache1 = Cache();
  cache1.setItem("key", "ss");
  print(cache1.getItem("key"));
  Cache<Person> cache = Cache();
}

class Cache<T extends Object> {
  //用extend进行约束，代表只能是Object的类或者子类
  final Map<String, T> _cached = {};
  void setItem(String key, T value) {
    _cached[key] = value;
  }

  T? getItem(String key) => _cached[key];
}
