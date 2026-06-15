import 'package:flutter/material.dart';

// Biến toàn cục để quản lý Theme cho Exercise 4
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const Lab4App());
}

class Lab4App extends StatelessWidget {
  const Lab4App({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lab 4 - Flutter UI',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: currentMode,
          home: const MainMenuScreen(),
        );
      },
    );
  }
}

// Màn hình chính chứa Menu để điều hướng đến 5 bài tập
class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 4 – Flutter UI Fundamentals')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildMenuCard(
            context,
            'Exercise 1 – Core Widgets Demo',
            const Exercise1Screen(),
          ),
          _buildMenuCard(
            context,
            'Exercise 2 – Input Controls Demo',
            const Exercise2Screen(),
          ),
          _buildMenuCard(
            context,
            'Exercise 3 – Layout Demo',
            const Exercise3Screen(),
          ),
          _buildMenuCard(
            context,
            'Exercise 4 – App Structure & Theme',
            const Exercise4Screen(),
          ),
          _buildMenuCard(
            context,
            'Exercise 5 – Common UI Fixes',
            const Exercise5Screen(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, Widget screen) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
  }
}

// ==========================================
// EXERCISE 1: Core Widgets
// ==========================================
class Exercise1Screen extends StatelessWidget {
  const Exercise1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 1 – Core Widgets')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Flutter UI',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Icon(Icons.movie, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            // Sử dụng Image.network với một ảnh mẫu
            Image.network(
              'https://picsum.photos/400/200',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Card(
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.star),
                title: Text('Movie Item'),
                subtitle: Text('This is a sample ListTile inside a Card.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// EXERCISE 2: Input Controls
// ==========================================
class Exercise2Screen extends StatefulWidget {
  const Exercise2Screen({super.key});

  @override
  State<Exercise2Screen> createState() => _Exercise2ScreenState();
}

class _Exercise2ScreenState extends State<Exercise2Screen> {
  double _rating = 50;
  bool _isActive = false;
  String _genre = 'None';
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 2 – Input Controls')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rating (Slider)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _rating,
              min: 0,
              max: 100,
              divisions: 100,
              onChanged: (value) => setState(() => _rating = value),
            ),
            Text('Current value: ${_rating.toInt()}'),
            const Divider(),
            const Text(
              'Active (Switch)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: const Text('Is movie active?'),
              value: _isActive,
              onChanged: (value) => setState(() => _isActive = value),
            ),
            const Divider(),
            const Text(
              'Genre (RadioListTile)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RadioListTile<String>(
              title: const Text('Action'),
              value: 'Action',
              groupValue: _genre,
              onChanged: (value) => setState(() => _genre = value!),
            ),
            RadioListTile<String>(
              title: const Text('Comedy'),
              value: 'Comedy',
              groupValue: _genre,
              onChanged: (value) => setState(() => _genre = value!),
            ),
            Text('Selected genre: $_genre'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text('Open Date Picker'),
              ),
            ),
            if (_selectedDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Text(
                    'Selected Date: ${_selectedDate!.toLocal()}'.split(' ')[0],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// EXERCISE 3: Layout Basics
// ==========================================
class Exercise3Screen extends StatelessWidget {
  const Exercise3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> movies = [
      'Avatar',
      'Inception',
      'Interstellar',
      'Joker',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 3 – Layout Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Now Playing',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(movies[index][0]), // Chữ cái đầu
                      ),
                      title: Text(movies[index]),
                      subtitle: const Text('Sample description'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// EXERCISE 4: App Structure & Theme
// ==========================================
class Exercise4Screen extends StatelessWidget {
  const Exercise4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = themeNotifier.value == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 4 – App Structure'),
        actions: [
          Row(
            children: [
              const Text('Dark'),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  themeNotifier.value = value
                      ? ThemeMode.dark
                      : ThemeMode.light;
                },
              ),
            ],
          ),
        ],
      ),
      body: const Center(
        child: Text('This is a simple screen with theme toggle.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ==========================================
// EXERCISE 5: Common UI Fixes
// ==========================================
class Exercise5Screen extends StatelessWidget {
  const Exercise5Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> movies = ['Movie A', 'Movie B', 'Movie C', 'Movie D'];

    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 5 – Common UI Fixes')),
      // Bọc toàn bộ trong SingleChildScrollView nếu nội dung quá dài (Sửa lỗi Overflow)
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Correct ListView inside Column using Expanded (Simulated with ShrinkWrap here to work inside ScrollView)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Khi dùng ListView trong Column (nằm trong SingleChildScrollView),
              // ta cần dùng shrinkWrap: true thay vì Expanded để tránh xung đột chiều cao.
              // Nếu KHÔNG có SingleChildScrollView ở ngoài, ta sẽ dùng Expanded() bọc ListView.
              ListView.builder(
                shrinkWrap:
                    true, // Sửa lỗi chiều cao vô hạn khi nằm trong cột có cuộn
                physics:
                    const NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn riêng của list
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.movie_creation),
                    title: Text(movies[index]),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
