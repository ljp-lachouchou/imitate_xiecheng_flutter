///方法的构成
///可选参数用{}包起来
void main() {
  sum(1, 2);
  FunctionLearn functionLearn = FunctionLearn();
  functionLearn._learn();
  FunctionLearn.doSome();
}

int sum(int val1, int val2, {bool? isPrint = false}) {
  var result = val1 + val2;
  if (isPrint ?? false) {
    //如果是空的就是false
    print(result);
  }
  return result;
}

class FunctionLearn {
  _learn() {
    print("function_learn");
  }

  static doSome() {
    print("doSome");
  }
}
