import 'dart:convert';

class Movie {
  final int? id;
  final String imdbId;
  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String plot;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String language;
  final String country;
  final String awards;
  final String metascore;
  final String poster;
  final double imdbRating;
  final String imdbVotes;
  final List<String> images;

  Movie({
    this.id,
    required this.imdbId,
    required this.title,
    this.year = '',
    this.rated = '',
    this.released = '',
    this.runtime = '',
    required this.plot,
    required this.genre,
    this.director = '',
    this.writer = '',
    required this.actors,
    this.language = '',
    this.country = '',
    this.awards = '',
    this.metascore = '',
    required this.poster,
    required this.imdbRating,
    this.imdbVotes = '',
    this.images = const [],
  });

  /// Creates a Movie from a JSON map (as loaded from movie_data.json / HTTP).
  factory Movie.fromJson(Map<String, dynamic> json) {
    final imagesRaw = json['Images'];
    final images = imagesRaw is List
        ? imagesRaw.whereType<String>().toList()
        : <String>[];

    return Movie(
      imdbId: json['imdbID'] as String? ?? json['Title'] as String? ?? '',
      title: json['Title'] as String? ?? '',
      year: json['Year'] as String? ?? '',
      rated: json['Rated'] as String? ?? '',
      released: json['Released'] as String? ?? '',
      runtime: json['Runtime'] as String? ?? '',
      plot: json['Plot'] as String? ?? '',
      genre: json['Genre'] as String? ?? '',
      director: json['Director'] as String? ?? '',
      writer: json['Writer'] as String? ?? '',
      actors: json['Actors'] as String? ?? '',
      language: json['Language'] as String? ?? '',
      country: json['Country'] as String? ?? '',
      awards: json['Awards'] as String? ?? '',
      metascore: json['Metascore'] as String? ?? '',
      poster: json['Poster'] as String? ?? '',
      imdbRating: double.tryParse(json['imdbRating']?.toString() ?? '') ?? 0.0,
      imdbVotes: json['imdbVotes'] as String? ?? '',
      images: images,
    );
  }

  /// Serialises back to a JSON-compatible map (keys match movie_data.json).
  Map<String, dynamic> toJson() => {
    'imdbID': imdbId,
    'Title': title,
    'Year': year,
    'Rated': rated,
    'Released': released,
    'Runtime': runtime,
    'Plot': plot,
    'Genre': genre,
    'Director': director,
    'Writer': writer,
    'Actors': actors,
    'Language': language,
    'Country': country,
    'Awards': awards,
    'Metascore': metascore,
    'Poster': poster,
    'imdbRating': imdbRating.toString(),
    'imdbVotes': imdbVotes,
    'Images': images,
  };

  /// Creates a Movie from a SQLite row map.
  factory Movie.fromMap(Map<String, dynamic> map) {
    final imagesRaw = map['images'] as String?;
    final images = imagesRaw != null && imagesRaw.isNotEmpty
        ? (jsonDecode(imagesRaw) as List).whereType<String>().toList()
        : <String>[];

    return Movie(
      id: map['id'] as int?,
      imdbId: map['imdbId'] as String? ?? '',
      title: map['title'] as String? ?? '',
      year: map['year'] as String? ?? '',
      rated: map['rated'] as String? ?? '',
      released: map['released'] as String? ?? '',
      runtime: map['runtime'] as String? ?? '',
      plot: map['plot'] as String? ?? '',
      genre: map['genre'] as String? ?? '',
      director: map['director'] as String? ?? '',
      writer: map['writer'] as String? ?? '',
      actors: map['actors'] as String? ?? '',
      language: map['language'] as String? ?? '',
      country: map['country'] as String? ?? '',
      awards: map['awards'] as String? ?? '',
      metascore: map['metascore'] as String? ?? '',
      poster: map['poster'] as String? ?? '',
      imdbRating: (map['imdbRating'] as num?)?.toDouble() ?? 0.0,
      imdbVotes: map['imdbVotes'] as String? ?? '',
      images: images,
    );
  }

  /// Converts to a SQLite row map (lowercase keys matching the DB schema).
  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'imdbId': imdbId,
    'title': title,
    'year': year,
    'rated': rated,
    'released': released,
    'runtime': runtime,
    'plot': plot,
    'genre': genre,
    'director': director,
    'writer': writer,
    'actors': actors,
    'language': language,
    'country': country,
    'awards': awards,
    'metascore': metascore,
    'poster': poster,
    'imdbRating': imdbRating,
    'imdbVotes': imdbVotes,
    'images': jsonEncode(images),
  };

  String get imdbRatingText => imdbRating > 0 ? imdbRating.toString() : 'N/A';
  String get imdbVotesText => imdbVotes.isNotEmpty ? imdbVotes : 'N/A';
  String get heroImageUrl => images.isNotEmpty ? images.first : poster;
  String get posterHeroTag => 'poster-${imdbId.isNotEmpty ? imdbId : title}';

  List<String> get genreTags => genre
      .split(',')
      .map((tag) => tag.trim())
      .where((tag) => tag.isNotEmpty)
      .toList();
}
