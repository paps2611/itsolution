import 'package:flutter/material.dart';

import '../Model/image_model.dart';

class ImageCard extends StatelessWidget {
  final ImageModel image;

  const ImageCard({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image section with rounded corners
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15),
            ),
            child: Image.network(
              image.imageUrl,
              fit: BoxFit.cover,
              height: 200, // Fixed height for images
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.thumb_up, size: 16,color: Colors.blue,),
                    const SizedBox(width: 4),
                    Text('${image.likes}'),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.remove_red_eye, size: 16,color: Colors.orangeAccent,),
                    const SizedBox(width: 4),
                    Text('${image.views}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
