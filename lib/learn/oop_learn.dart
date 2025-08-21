void main() {
  Person person = Person('jack', 10);
  print(person.toString());
  Student student = Student.cover(person);
  print(student.toString());
  Logger logger1 = Logger();
  Logger logger2 = Logger();
  print(logger2 == logger1);
  logger1.log("msg");
}

//定义一个类，所有类都继承Object
class Person {
  String? name;
  int? age;
  String _time = "ss";
  Person(this.name, this.age);
  String get time => _time;
  set time(String t) => _time = t;
  @override
  String toString() {
    return "name:$name,age:$age";
  }
}

class Student extends Person {
  String? _school;
  String? city;
  String? country;
  String? funName;
  final String? stu;
  //final修饰的必须在构造函数里面
  Student(
    this._school,
    String? name,
    int? age, {
    this.stu,
    this.city,
    this.country = "china",
  }) : funName = "$country.$city",
       super(name, age); //:初始化列表

  //命名构造方法 [类名.方法名] 不能有返回值
  //final修饰的必须在构造函数里面
  Student.cover(Person stu)
    : funName = "ssss",
      stu = "2",
      super(stu.name, stu.age) {
    print("命名构造方法");
  }

  ///命名工厂构造方法: factory [类名.方法名]
  ///必须返回Student，不需要将类的final变量作为参数
  factory Student.fac(Person stu) {
    return Student("清华", stu.name, stu.age);
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'name:$name school: $_school, funName: $funName';
  }
}

//工厂构造方法演示：
class Logger {
  static Logger? logger;
  factory Logger() {
    logger ??= Logger._internal(); //如果为空 赋值为Logger()
    return logger!; //java、kotlin中实现单例的方式
  }
  Logger._internal();
  void log(String msg) => print(msg);
}

//dart无接口的概念，抽象类既可以被继承也可以被别的类实现
//注意：！！！ 被实现的话  即便不是抽象方法也要被类复写
abstract class Study {
  //抽象方法:没有方法体的方法,不需要abstract修饰
  void study();
}

mixin StudyMixin {
  //抽象方法:没有方法体的方法,不需要abstract修饰
  void study();
}

///为类添加特征：mixins
///mixins 是在多个类层次结构中重用代码的一种方式
///要使用mixins，在with关键字后面跟一个或多个 mixin的名字（用逗号分开），并且with要用在extends之后，符合mixin的声明时用mixin
///mixins的特征：实现mixin，就创建一个继承object的子类，不声明任何构造方法，不调用super
class Test extends Person with StudyMixin {
  Test(super.name, super.age);

  @override
  void study() {}
}
