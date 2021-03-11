class Sources {
  final String id;
  final String name;
  final String description;
  final String url;
  final String category;
  final String country;
  final String language;

  Sources(this.id, this.name, this.description, this.url, this.category,
      this.country, this.language);

  Sources.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        description = json["description"],
        url = json["url"],
        category = json["category"],
        country = json["country"],
        language = json["language"];
}
