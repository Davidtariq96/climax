import 'dart:io';

void main() {
  performer();
}

void performer() async {
  task1();
  String? task2res = await task2();
  task3(task2res!);
}

void task1() {
  String name = "david is cute";
  print("task1 running");
}

Future<String?> task2() async {
  Duration timer = const Duration(seconds: 3);
  String? result;
  await Future.delayed(timer, () {
    result = "mary is beautiful";
    print("task2 running");
  });
  return result;
}

void task3(String data) {
  String name = "I'm hungry now";
  print("task3 running $data");
}
