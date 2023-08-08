
class NewsModelSqlFields {
  static const String id = "_id";
  static const String title = "title";
  static const String body = "body";
  static const String news = "news";
  static const String imageUrl = "image url";
  static const String description = "description";

  static const String contactsTable = "my_notification";
}

class NewsModelSql {
  int? id;
  final String title;
  final String? body;
  final String news;
  final String imageUrl;
  final String description;

  NewsModelSql({
    this.id,
    required this.body,
    required this.news,
    required this.imageUrl,
    required this.description,
    required this.title,
  });

  NewsModelSql copyWith({
    String? title,
    String? body,
    String? news,
    String? imageUrl,
    String? description,
    int? id,
  }) {
    return NewsModelSql(
      title: title ?? this.title,
      body: body ?? this.body,
      news: news ?? this.news,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      id: id ?? this.id,
    );
  }

  factory NewsModelSql.fromJson(Map<String, dynamic> json) {
    return NewsModelSql(
      title: json[NewsModelSqlFields.title] ?? "",
      body: json[NewsModelSqlFields.body] ?? "",
      id: json[NewsModelSqlFields.id] ?? 0, news: json[NewsModelSqlFields.news]?? "", imageUrl: json[NewsModelSqlFields.imageUrl]?? "", description: json[NewsModelSqlFields.description]?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NewsModelSqlFields.title: title,
      NewsModelSqlFields.news: news,
      NewsModelSqlFields.description: description,
      NewsModelSqlFields.imageUrl: imageUrl,
      NewsModelSqlFields.body: body,
    };
  }

  @override
  String toString() {
    return '''
      name: $title
      news : $news
      image: $imageUrl
      description : $description
      body: $body
      id: $id, 
    ''';
  }
}