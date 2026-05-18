import 'dart:async';

// 1. Tạo Product model
class Product {
  final String id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});

  // Ghi đè phương thức toString để in thông tin đẹp mắt hơn [cite: 292]
  @override
  String toString() => 'Product(id: $id, name: $name, price: \$$price)';
}

// 2. Tạo Repository [cite: 289]
class ProductRepository {
  // Dữ liệu mô phỏng sẵn có trong hệ thống
  final List<Product> _initialData = [
    Product(id: 'P01', name: 'Laptop', price: 1200.0),
    Product(id: 'P02', name: 'Smartphone', price: 800.0),
  ];

  // Trả về Future<List<Product>> mô phỏng việc gọi API lấy danh sách
  Future<List<Product>> fetchProducts() async {
    print('[Future] Đang tải dữ liệu sản phẩm...');
    // Dùng Future.delayed để mô phỏng thời gian chờ của mạng (1 giây)
    await Future.delayed(Duration(seconds: 1));
    return _initialData;
  }

  // Trả về Stream<Product> mô phỏng việc có sản phẩm mới được thêm vào realtime
  Stream<Product> liveProductAdditions() async* {
    print('[Stream] Bắt đầu lắng nghe các sản phẩm mới được thêm vào...');

    // Danh sách các sản phẩm sẽ được thêm vào hệ thống theo thời gian thực
    List<Product> incomingProducts = [
      Product(id: 'P03', name: 'Smartwatch', price: 250.0),
      Product(id: 'P04', name: 'Mechanical Keyboard', price: 150.0),
    ];

    for (var product in incomingProducts) {
      // Mỗi 2 giây sẽ có một sản phẩm mới được "live add"
      await Future.delayed(Duration(seconds: 2));
      yield product; // Phát dữ liệu (yield) ra stream
    }
  }
}

// 3. Hàm main để chạy chương trình và in ra console [cite: 292]
void main() async {
  final repository = ProductRepository();

  print('--- KIỂM TRA FUTURE ---');
  // Chờ (await) Future hoàn thành để lấy List<Product>
  List<Product> products = await repository.fetchProducts();
  print('Danh sách sản phẩm hiện tại:');
  for (var product in products) {
    print(' - $product');
  }

  print('\n--- KIỂM TRA STREAM ---');
  // Lắng nghe (await for) Stream để nhận từng Product ngay khi nó được phát ra
  await for (var newProduct in repository.liveProductAdditions()) {
    print(' Sản phẩm mới vừa xuất hiện: $newProduct');
  }

  print('\n Đã hoàn thành mô phỏng Data Layer!');
}
