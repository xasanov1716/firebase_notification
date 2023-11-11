


class NewsModel {
  String title;
  String image;
  String description;

  NewsModel({
    required this.title,  required this.description,required this.image
  });


  NewsModel copyWith({
    String? title,
    String? ntitle,
    String? body,
    String? description,
    String? image,
  }) {
    return NewsModel(
      title: title ?? this.title,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image': image,
    };
  }

  static NewsModel fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json["title"], description: json['description'], image: json['image']
    );
  }
}