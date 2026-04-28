class Movie {
  final int? id;
  final String imdbId;
  final String title;
  final String plot;
  final String genre;
  final String actors;
  final String poster;
  final double imdbRating;

  Movie({
    this.id,
    required this.imdbId,
    required this.title,
    required this.plot,
    required this.genre,
    required this.actors,
    required this.poster,
    required this.imdbRating,
  });

  /// Creates a Movie from a JSON map (as loaded from movie_data.json / HTTP).
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      imdbId: json['imdbID'] as String? ?? json['Title'] as String? ?? '',
      title: json['Title'] as String? ?? '',
      plot: json['Plot'] as String? ?? '',
      genre: json['Genre'] as String? ?? '',
      actors: json['Actors'] as String? ?? '',
      poster: json['Poster'] as String? ?? '',
      imdbRating: double.tryParse(json['imdbRating']?.toString() ?? '') ?? 0.0,
    );
  }

  /// Serialises back to a JSON-compatible map (keys match movie_data.json).
  Map<String, dynamic> toJson() => {
    'imdbID': imdbId,
    'Title': title,
    'Plot': plot,
    'Genre': genre,
    'Actors': actors,
    'Poster': poster,
    'imdbRating': imdbRating.toString(),
  };

  /// Creates a Movie from a SQLite row map.
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int?,
      imdbId: map['imdbId'] as String? ?? '',
      title: map['title'] as String? ?? '',
      plot: map['plot'] as String? ?? '',
      genre: map['genre'] as String? ?? '',
      actors: map['actors'] as String? ?? '',
      poster: map['poster'] as String? ?? '',
      imdbRating: (map['imdbRating'] as num?)?.toDouble() ?? 0.0,
    );
  }

  /// Converts to a SQLite row map (lowercase keys matching the DB schema).
  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'imdbId': imdbId,
    'title': title,
    'plot': plot,
    'genre': genre,
    'actors': actors,
    'poster': poster,
    'imdbRating': imdbRating,
  };
}
