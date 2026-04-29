import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'db/movie_database.dart';
import 'movie.dart';

void main() {
  if (Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Movies'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> _movies = [];
  bool _isLoading = false;
  String? _errorMessage;
  final TextEditingController _searchController = TextEditingController();
  final MovieRepository _repository = SqliteMovieRepository.instance;

  @override
  void initState() {
    super.initState();
    _loadAllMovies();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadAllMovies() async {
    setState(() => _isLoading = true);
    try {
      await _repository.initialize();
      final movies = await _repository.getAllMovies();
      if (!mounted) return;
      setState(() {
        _movies = movies;
        _errorMessage = null;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _movies = [];
        _errorMessage = 'Failed to load movies: $error';
        _isLoading = false;
      });
    }
  }

  Future<void> _searchMovies(String query) async {
    if (query.isEmpty) {
      await _loadAllMovies();
      return;
    }

    setState(() => _isLoading = true);
    try {
      final results = await _repository.searchMoviesByTitle(query);
      if (!mounted) return;
      setState(() {
        _movies = results;
        _errorMessage = null;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _movies = [];
        _errorMessage = 'Search failed: $error';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final body = switch ((_isLoading, _errorMessage, _movies.isEmpty)) {
      (true, _, _) => const Center(child: CircularProgressIndicator()),
      (false, final String message?, _) => Center(child: Text(message)),
      (false, null, true) => const Center(child: Text('No movies found.')),
      _ => ListView.builder(
          itemCount: _movies.length,
          itemBuilder: (context, index) {
            final movie = _movies[index];
            return ListTile(
              leading: movie.poster.isNotEmpty
                  ? Image.network(
                      movie.poster,
                      width: 50,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.movie, size: 40),
                    )
                  : const Icon(Icons.movie, size: 40),
              title: Text(movie.title),
              subtitle: Text(movie.genre),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  Text(' ${movie.imdbRating}'),
                ],
              ),
            );
          },
        ),
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by movie title...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _searchMovies('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: _searchMovies,
            ),
          ),
        ),
      ),
      body: body,
    );
  }
}
