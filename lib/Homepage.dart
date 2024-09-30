import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:itsolution/util/image_card.dart';
import 'API/pixbay_api.dart';
import 'Model/image_model.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class ImageGalleryScreen extends StatefulWidget {
  const ImageGalleryScreen({super.key});

  @override
  _ImageGalleryScreenState createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<ImageModel> _images = [];
  int _page = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchImages();

    // Infinite scrolling to load more images
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        _fetchImages();
      }
    });
  }

  Future<void> _fetchImages() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final List<ImageModel> newImages = await PixabayApi.fetchImages(_page);
      setState(() {
        _images.addAll(newImages);
        _page++;
      });
    } catch (error) {
      // Handle error
      debugPrint('Error fetching images: $error');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pixabay Image Gallery',
          style: GoogleFonts.alike(
            fontSize: 24,
            fontWeight: FontWeight.bold, // Optional: Add more styles
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _images.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : MasonryGridView.count(
          controller: _scrollController,
          crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
          itemCount: _images.length,
          itemBuilder: (BuildContext context, int index) {
            return ImageCard(
              image: _images[index],
            );
          },
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
