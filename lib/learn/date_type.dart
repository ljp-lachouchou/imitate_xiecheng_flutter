//常用数据类型
import 'package:flutter_learn/learn/function_learn.dart';

import 'oop_learn.dart';

void main() {
  Person person = Person("name", 10);
  print(person.time);
}

//数字类型
void _numType() {
  num num1 = -1.0; //数字类型的父类型，子类:int double
  num num2 = 2;
  int int1 = 1; //int只能是整数
  double double1 = 1.0; //只能是小数
  print("num1 = $num1 num2 = $num2 int1= $int1");
  print("num1的绝对值: ${num1.abs()}");
  print("num1转换成整数:${num1.toInt()}");
  FunctionLearn functionLearn = FunctionLearn();
}

//字符串
_stringType() {
  String str1 = '单引号', str2 = "双引号"; //字符串的定义
  String str3 = 'str1:$str1 str2:$str2';
  print(str3);
  String str5 = "常用数据类型,类型请看控制台输出";
  print(str5.substring(1, 5));
  print(str5.indexOf("类型"));
}

//bool类型
int _boolType() {
  bool success = true, fail = false;
  print("success = $success,fail = $fail");
  print(success || fail);
  print(success && fail);
  return 0;
}

//集合类型
_listType() {
  print("--------listType--------");
  List list = [1, 2, 3, 'sss']; //初始化添加元素
  print(list);
  List<int> intList = [1, 2, 3];
  print(intList);
  intList.add(2);
  print(intList);
  intList.addAll([1, 2, 3, 4]);
  print(intList);
  List list4 = List.generate(3, (index) => intList[index] * 2);
  print(list4);
  for (int i = 0; i < list4.length; i++) {
    print(list4[i]);
  }
  for (var item in list) {
    print(item);
  }
  list.forEach((element) {
    if (element is int) {
      print(element);
    }
  });
}

_mapType() {
  Map names = {'2': 1, '3': true, true: '小红'};
  print(names);
  Map<String, int> ages = {};
  ages['sss'] = 156;
  print(ages);
  names.forEach((k, v) {
    print("k:$k,v:$v");
  });
  Map ages2 = ages.map((k, v) {
    return MapEntry(k, v + 1);
  });
  print(ages2);
}
