import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/image_model.dart';

class PixabayApi {
  static const String _apiKey = '46232620-c2b1e8350f1201e854548609d';

  // Fetching images from the Pixabay API.
  static Future<List<ImageModel>> fetchImages(int page) async {
    final String url =
        'https://pixabay.com/api/?key=$_apiKey&q=flowers&image_type=photo&page=$page';
    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return (data['hits'] as List)
          .map((imageJson) => ImageModel.fromJson(imageJson))
          .toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}
