class ImageModel {
  final String imageUrl;
  final int likes;
  final int views;

  ImageModel({
    required this.imageUrl,
    required this.likes,
    required this.views,
  });

  // Factory method to create an ImageModel from JSON.
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      imageUrl: json['webformatURL'],
      likes: json['likes'],
      views: json['views'],
    );
  }
}
