class GameModel {
  String? id;
  String? title;
  String? shortDescription;
  String? description;
  String? thumbnail;
  String? url;
  String? genre;
  String? publisher;
  String? developer;
  String? releaseDate;

  GameModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.url,
    required this.genre,
    required this.publisher,
    required this.developer,
    required this.releaseDate,
    this.shortDescription,
    required this.description,
  });

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      id: map['id'].toString(),
      title: map['title'],
      thumbnail: map['thumbnail'],
      url: map['game_url'],
      genre: map['genre'],
      publisher: map['publisher'],
      developer: map['developer'],
      releaseDate: map['release_date'],
      shortDescription: map['short_description'],
      description: map['description'],
    );
  }
}
