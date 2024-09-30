import 'package:flutter/material.dart';
import 'Homepage.dart';

void main() => runApp(const PixabayGalleryApp());

/// The main application widget.
class PixabayGalleryApp extends StatelessWidget {
  const PixabayGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pixabay Image Gallery',
      home: ImageGalleryScreen(),
    );
  }
}
