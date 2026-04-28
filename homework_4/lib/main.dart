import 'package:flutter/material.dart';

import 'db/movie_database.dart';
import 'movie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key, MovieRepository? repository})
    : repository = repository ?? SqliteMovieRepository.instance;

  final MovieRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(title: 'Movies', repository: repository),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.repository});

  final String title;
  final MovieRepository repository;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> _movies = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadAndShow();
  }

  void _loadAndShow() async {
    setState(() => _isLoading = true);
    try {
      await widget.repository.initialize();
      final movies = await widget.repository.getAllMovies();
      if (!mounted) {
        return;
      }
      setState(() {
        _movies = movies;
        _errorMessage = null;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _movies = [];
        _errorMessage = 'Failed to load movies: $error';
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
            title: Text(movie.title),
            subtitle: Text(movie.genre),
          );
        },
      ),
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: body,
    );
  }
}
