import 'package:news_api_flutter_package/model/source.dart';

class Articles {
  final Source source;
  final String? author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content;

  Articles(
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  );

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
      Source.fromJson(json["source"]),
      json["author"],
      json["title"],
      json["description"],
      json["url"],
      json["urlToImage"],
      json["publishedAt"],
      json["content"],
    );
  }

  static List<Articles> parseList(List<dynamic> list) {
    return list.map((e) => Articles.fromJson(e)).toList();
  }
}