class GameModel {
  String? id;
  String? title;
  String? shortDescription;
  String? description;
  String? thumbnail;
  String? url;
  String? genre;
  String? platform;
  String? publisher;
  String? developer;
  String? releaseDate;
  String? freetogameProfileUrl;
  // List<String>? minimumSystemRequirements;
  List<String> screenshots;

  GameModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.url,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.developer,
    required this.releaseDate,
    required this.freetogameProfileUrl,
    required this.shortDescription,
    required this.description,
    // required this.minimumSystemRequirements,
    required this.screenshots,
  });

  factory GameModel.fromMap(Map<String, dynamic> map) {
  return GameModel(
    id: map['id'].toString(),
    title: map['title'],
    thumbnail: map['thumbnail'],
    url: map['url'],
    genre: map['genre'],
    platform: map['platform'],
    publisher: map['publisher'],
    developer: map['developer'],
    releaseDate: map['release_date'],
    freetogameProfileUrl: map['freetogame_profile_url'],
    shortDescription: map['short_description'],
    description: map['description'],
    // minimumSystemRequirements: List<String>.from(map['minimum_system_requirements'] ?? []),
    screenshots: (map['screenshots'] != null)
        ? List<String>.from(map['screenshots'].map((screenshot) => screenshot['image']))
        : [],
  );
}

}
