import 'sources.dart';

class SourcesList {
  final List<Sources> sources;

  SourcesList(this.sources);

  SourcesList.fromJson(Map<String, dynamic> json)
      : sources =
  (json["sources"] as List).map((i) => new Sources.fromJson(i)).toList();

}
