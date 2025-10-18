import 'package:flutter/material.dart';
import 'pages/home.dart'; // Import file halaman utama

void main() {
  runApp(const ShoppingListApp());
}

class ShoppingListApp extends StatelessWidget {
  const ShoppingListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ShoppingListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
