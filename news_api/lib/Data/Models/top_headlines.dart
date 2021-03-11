class TopHeadlines {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;

  TopHeadlines(this.author, this.title, this.description, this.url,
      this.urlToImage, this.publishedAt);

  TopHeadlines.fromJson(Map<String, dynamic> json)
      : author = json["author"] != null ? json["author"] : "",
        title = json["title"] != null ? json["title"] : "",
        description = json["description"] != null ? json["description"] : "",
        url = json["url"] != null ? json["url"] : "",
        urlToImage = json["urlToImage"] != null ? json["urlToImage"] : "",
        publishedAt = json["publishedAt"] != null ? json["publishedAt"] : "";
}
