class Movie {
  final String title;
  final String director;

  Movie({required this.title, required this.director});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(title: json['Title'] as String, director: json['Director'] as String);
  }

  Map<String, dynamic> toJson() => {
        'Title': title,
        'Director': director,
      };
}
