class GameModel {
  // final String id;
  final String title;
  // final String shortDescription;
  // final String description;
  // final String thumbnail;
  // final String url;
  // final String genre;
  // final String platform;
  // final String publisher;
  // final String developer;
  // final String releaseDate;
  // final String freetogameProfileUrl;
  // final List<String> minimumSystemRequirements;
  // final List<String> screenshots;

  GameModel({
    // required this.id,
    required this.title,
    // required this.thumbnail,
    // required this.url,
    // required this.genre,
    // required this.platform,
    // required this.publisher,
    // required this.developer,
    // required this.releaseDate,
    // required this.freetogameProfileUrl,
    // required this.shortDescription,
    // required this.description,
    // required this.minimumSystemRequirements,
    // required this.screenshots,
  });

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      // id: map['id'],
      title: map['title'],
      // thumbnail: map['thumbnail'],
      // url: map['url'],
      // genre: map['genre'],
      // platform: map['platform'],
      // publisher: map['publisher'],
      // developer: map['developer'],
      // releaseDate: map['release_date'],
      // freetogameProfileUrl: map['freetogame_profile_url'],
      // shortDescription: map['short_description'],
      // description: map['description'],
      // minimumSystemRequirements:
      //     List<String>.from((map['minimum_system_requirements'] as List)),
      // screenshots: List<String>.from((map['screenshots']['image'] as List)),
    );
  }
}