import 'dart:async';

class Product {
  final String id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});

  @override
  String toString() => 'Product(id: $id, name: $name, price: \$$price)';
}

class ProductRepository {
  final StreamController<Product> _controller =
      StreamController<Product>.broadcast();

  Future<List<Product>> getAll() async {
    await Future.delayed(Duration(milliseconds: 500));
    return [
      Product(id: 'P1', name: 'Bàn phím cơ', price: 50.0),
      Product(id: 'P2', name: 'Chuột không dây', price: 20.0),
    ];
  }

  Stream<Product> liveAdded() => _controller.stream;

  void addProduct(Product product) {
    _controller.sink.add(product);
  }

  void dispose() {
    _controller.close();
  }
}

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'], email: json['email']);
  }

  @override
  String toString() => 'User(name: $name, email: $email)';
}

Future<List<User>> fetchUsers() async {
  List<Map<String, dynamic>> apiJson = [
    {"name": "Alice", "email": "alice@example.com"},
    {"name": "Bob", "email": "bob@example.com"},
  ];

  await Future.delayed(Duration(milliseconds: 300));
  return apiJson.map((json) => User.fromJson(json)).toList();
}

class Settings {
  static final Settings _instance = Settings._internal();

  Settings._internal() {
    print("  -> Khởi tạo Settings instance lần đầu tiên.");
  }

  factory Settings() {
    return _instance;
  }
}

void main() async {
  // --- BÀI TẬP 1 ---
  print('--- EXERCISE 1: Product Model & Repository ---');
  final repo = ProductRepository();

  repo.liveAdded().listen((product) {
    print('[Stream] Vừa thêm sản phẩm mới: $product');
  });

  print('[Future] Đang tải danh sách...');
  final products = await repo.getAll();
  print('Danh sách ban đầu: $products');

  repo.addProduct(Product(id: 'P3', name: 'Màn hình 24-inch', price: 150.0));

  await Future.delayed(Duration(milliseconds: 100));
  repo.dispose();

  print('\n--- EXERCISE 2: User Repository with JSON ---');
  print('Đang fetch và parse dữ liệu JSON...');
  List<User> users = await fetchUsers();
  users.forEach((user) => print('  $user'));

  print('\n--- EXERCISE 3: Async + Microtask Debugging ---');
  print('1. Sync: Bắt đầu hàm');

  Future(() {
    print('4. Event Queue: Future thực thi');
  });

  scheduleMicrotask(() {
    print('3. Microtask Queue: Microtask thực thi');
  });

  print('2. Sync: Kết thúc khối đồng bộ');

  await Future.delayed(Duration(milliseconds: 100));

  print('\n--- EXERCISE 4: Stream Transformation ---');
  Stream<int> numbersStream = Stream.fromIterable([1, 2, 3, 4, 5]);

  print('Stream gốc: 1, 2, 3, 4, 5');
  await numbersStream.map((n) => n * n).where((n) => n % 2 == 0).listen((
    result,
  ) {
    print('Kết quả sau khi map() và where(): $result');
  }).asFuture();

  print('\n--- EXERCISE 5: Factory Constructors & Cache ---');
  Settings s1 = Settings();
  Settings s2 = Settings();

  bool isIdentical = identical(s1, s2);
  print(
    'Biến s1 và s2 có trỏ về cùng một đối tượng bộ nhớ (Singleton) không? => $isIdentical',
  );
}
