import 'package:flutter/material.dart';
import 'package:untitled/screens/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Homepage(),
    ),
  );
}
