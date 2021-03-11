import 'sources.dart';

class SourcesList {
  final List<Sources> sources;
  final String status;

  SourcesList(this.sources, this.status);

  SourcesList.fromJson(Map<String, dynamic> json)
      : sources =
  (json["sources"] as List).map((i) => new Sources.fromJson(i)).toList(),
        status = json["status"];

  SourcesList.withError(String status)
      : sources = [],
        status = status;
}
