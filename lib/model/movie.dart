class Movie {
  String image;
  String rating;
  String id;
  String year;
  String title;
  String release;
  String description;

  Movie(
      {required this.id,
      required this.image,
      required this.rating,
      required this.title,
      required this.description,
      required this.release,
      required this.year});

  factory Movie.fromJson(Map json) {
    return Movie(
        id: json['_id'].toString(),
        image: json['image'],
        rating: json['rating'],
        title: json['title'],
        description: json['description'],
        year: json['year'],
        release: json['release']);
  }

  factory Movie.fromJsonDatabase(Map json) {
    return Movie(
        id: json['id'].toString(),
        image: json['image'],
        rating: json['rating'],
        title: json['title'],
        description: json['description'],
        year: json['year'],
        release: json['release']);
  }
  toJson() {
    return {
      'title': title,
      'rating': rating,
      'description': description,
      'release': release,
      'movieId': id,
      'image': image,
      'year': year,
    };
  }
}
