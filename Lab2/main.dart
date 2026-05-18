// Lab 2 – Dart Essentials Practice Lab

import 'dart:async';

// SETUP CHO EXERCISE 3: Functions
// Hàm thông thường (Normal syntax)
int add(int a, int b) {
  return a + b;
}

// Hàm mũi tên (Arrow syntax)
int multiply(int a, int b) => a * b;

// SETUP CHO EXERCISE 4: Intro to OOP
// Tạo class Car với 1 property và 1 method
class Car {
  String brand;

  // Constructor mặc định
  Car(this.brand);

  // Named constructor
  Car.guest() : brand = 'Unknown Brand';

  // Method để override
  void drive() {
    print('The $brand is driving on fuel.');
  }
}

// Subclass ElectricCar kế thừa từ Car
class ElectricCar extends Car {
  ElectricCar(String brand) : super(brand);

  // Ghi đè (override) method
  @override
  void drive() {
    print('The $brand is driving silently on electricity.');
  }
}

// SETUP CHO EXERCISE 5: Async, Future, Streams
// Hàm bất đồng bộ (Async function) kết hợp Future + await
Future<void> simulateLoading() async {
  print('Loading data...');
  // Sử dụng Future.delayed() để giả lập thời gian tải
  await Future.delayed(Duration(seconds: 2));
  print('Data loaded successfully!');
}

// Hàm tạo Stream đơn giản
Stream<int> countStream() async* {
  for (int i = 1; i <= 3; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

// HÀM MAIN - CHẠY TẤT CẢ CÁC BÀI TẬP
void main() async {
  // --- Exercise 1: Basic Syntax & Data Types ---
  print('--- Exercise 1 ---');
  // Khai báo biến
  int age = 21;
  double height = 1.75;
  String name = 'Dart User';
  bool isStudent = true;

  // In ra console sử dụng String Interpolation
  print('Name: $name, Age: $age');
  print('Height is ${height}m. Student status: $isStudent\n');

  // Exercise 2: Collections & Operators
  print('--- Exercise 2 ---');
  // List số nguyên
  List<int> numbers = [10, 20, 30];
  numbers.add(40);
  numbers.remove(10);
  print('List sau khi add và remove: $numbers');
  print('Phần tử đầu tiên (indexing): ${numbers[0]}');

  // Operators (Toán tử số học và so sánh)
  int a = 15, b = 5;
  print('Arithmetic: a + b = ${a + b}, a - b = ${a - b}');
  print('Comparison: a == b: ${a == b}, && operator: ${a > 10 && b < 10}');
  // Toán tử ba ngôi (Ternary ? :)
  print('Ternary: ${a > b ? "a is larger" : "b is larger"}');

  // Set (Chỉ chứa các giá trị duy nhất)
  Set<String> uniqueTags = {
    'Dart',
    'Flutter',
    'Dart',
  }; // 'Dart' bị lặp sẽ tự động loại bỏ
  print('Set: $uniqueTags');

  // Map (Key-Value)
  Map<String, int> scores = {'Math': 90, 'Science': 85};
  scores['English'] = 88; // Thêm phần tử mới
  print('Map: $scores');
  print('Điểm Math (Map access): ${scores['Math']}\n');

  // Exercise 3: Control Flow & Functions
  print('--- Exercise 3 ---');
  // if/else block
  int score = 85;
  if (score >= 90) {
    print('Grade: A');
  } else if (score >= 80) {
    print('Grade: B');
  } else {
    print('Grade: C');
  }

  // switch case
  int dayOfWeek = 3;
  switch (dayOfWeek) {
    case 1:
      print('Monday');
      break;
    case 2:
      print('Tuesday');
      break;
    case 3:
      print('Wednesday');
      break;
    default:
      print('Other Day');
  }

  // Loops (for, for-in, forEach)
  print('For loop:');
  for (int i = 0; i < 2; i++) {
    print('Index $i');
  }

  print('For-in loop:');
  for (var num in numbers) {
    print('Number: $num');
  }

  print('forEach() loop:');
  numbers.forEach((num) => print('Item: $num'));

  // Gọi hàm
  print('Normal Function (5 + 3): ${add(5, 3)}');
  print('Arrow Function (5 * 3): ${multiply(5, 3)}\n');

  // Exercise 4: Intro to OOP
  print('--- Exercise 4 ---');
  // Khởi tạo object từ constructor mặc định
  Car myCar = Car('Toyota');
  myCar.drive();

  // Khởi tạo object từ named constructor
  Car unknownCar = Car.guest();
  unknownCar.drive();

  // Khởi tạo object từ Subclass (Inheritance & Overriding)
  ElectricCar myTesla = ElectricCar('Tesla');
  myTesla.drive();
  print('');

  // Exercise 5: Async, Future, Null Safety & Streams
  print('--- Exercise 5 ---');
  // Null safety operators
  String? nullableString; // Biến có thể null
  print('Giá trị ban đầu: $nullableString');

  // ?? operator (Nếu null thì lấy giá trị mặc định)
  String result = nullableString ?? 'Giá trị mặc định';
  print('Sử dụng ??: $result');

  // ? operator (Tránh lỗi null pointer)
  print('Độ dài chuỗi (dùng ?.): ${nullableString?.length}');

  // Chạy hàm async có await
  await simulateLoading();

  // Lắng nghe (listen) giá trị từ Stream
  print('Listening to stream...');
  await for (int val in countStream()) {
    print('Stream emitted: $val');
  }
  print('Stream done!');
}
