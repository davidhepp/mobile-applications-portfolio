import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'db/movie_database.dart';
import 'movie.dart';
import 'movie_detail_screen.dart';

void main() {
  if (Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.repository});

  final MovieRepository? repository;

  @override
  Widget build(BuildContext context) {
    final baseScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFE50914),
      brightness: Brightness.light,
    );
    final colorScheme = baseScheme.copyWith(
      primary: const Color(0xFF1F1B2E),
      secondary: const Color(0xFFE50914),
      surface: const Color(0xFFFFFBF7),
    );

    return MaterialApp(
      title: 'Movies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.surface,
        textTheme: GoogleFonts.dmSansTextTheme().apply(
          bodyColor: const Color(0xFF1F1B2E),
          displayColor: const Color(0xFF1F1B2E),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: const Color(0xFF1F1B2E),
          titleTextStyle: GoogleFonts.bebasNeue(
            fontSize: 26,
            letterSpacing: 1.2,
            color: const Color(0xFF1F1B2E),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white.withOpacity(0.85),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
      home: MyHomePage(title: 'Movies', repository: repository),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    this.repository,
  });

  final String title;
  final MovieRepository? repository;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> _movies = [];
  bool _isLoading = false;
  String? _errorMessage;

  final TextEditingController _searchController = TextEditingController();
  late final MovieRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository = widget.repository ?? SqliteMovieRepository.instance;
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
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF7F2EC), Color(0xFFECE2D6)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: -120,
            right: -80,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE50914).withOpacity(0.12),
              ),
            ),
          ),
          Positioned(
            bottom: -140,
            left: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1F1B2E).withOpacity(0.08),
              ),
            ),
          ),
          SafeArea(
            child: _buildContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return _buildMessageState(
        context,
        message: _errorMessage!,
        actionLabel: 'Try again',
        onAction: _loadAllMovies,
      );
    }

    if (_movies.isEmpty) {
      return _buildMessageState(
        context,
        message: 'No movies found.',
      );
    }

    final isSearching = _searchController.text.trim().isNotEmpty;
    final featuredMovie = _movies.first;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _buildHeader(context)),
        SliverToBoxAdapter(child: _buildSearchBar(context)),
        if (!isSearching)
          SliverToBoxAdapter(child: _buildFeatured(context, featuredMovie)),
        if (!isSearching)
          SliverToBoxAdapter(
            child: _buildSectionTitle(context, 'Popular Picks'),
          ),
        if (!isSearching)
          SliverToBoxAdapter(child: _buildCarousel(context, _movies)),
        SliverToBoxAdapter(
          child: _buildSectionTitle(
            context,
            isSearching ? 'Results' : 'All Movies',
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildMovieRow(context, _movies[index]),
              ),
              childCount: _movies.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.bebasNeue(
                    fontSize: 36,
                    letterSpacing: 1.4,
                    color: theme.colorScheme.primary,
                  ),
                ),
                Text(
                  'Curated picks, timeless classics, and new obsessions.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(Icons.local_movies_outlined),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
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
        ),
        onChanged: _searchMovies,
      ),
    );
  }

  Widget _buildFeatured(BuildContext context, Movie movie) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: InkWell(
        onTap: () => _openMovie(movie),
        borderRadius: BorderRadius.circular(24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: _networkImage(movie.heroImageUrl),
              ),
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0x99000000),
                        Color(0x33000000),
                        Color(0xCC000000),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Featured Tonight',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: Colors.white.withOpacity(0.85),
                        letterSpacing: 0.6,
                      ),
                    ),
                    Text(
                      movie.title,
                      style: GoogleFonts.bebasNeue(
                        fontSize: 32,
                        letterSpacing: 1.1,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          movie.imdbRatingText,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          movie.year,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: movie.genreTags
                          .take(3)
                          .map((tag) => _buildTag(tag))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: Text(
        title,
        style: GoogleFonts.bebasNeue(
          fontSize: 22,
          letterSpacing: 1.1,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, List<Movie> movies) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return _buildPosterCard(context, movie);
        },
      ),
    );
  }

  Widget _buildPosterCard(BuildContext context, Movie movie) {
    return InkWell(
      onTap: () => _openMovie(movie),
      borderRadius: BorderRadius.circular(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: _networkImage(
              movie.poster,
              width: 120,
              height: 170,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 120,
            child: Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieRow(BuildContext context, Movie movie) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => _openMovie(movie),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: movie.posterHeroTag,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: _networkImage(
                  movie.poster,
                  width: 76,
                  height: 112,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    movie.genre,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        movie.imdbRatingText,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        movie.year,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.plot,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildMessageState(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 16),
              FilledButton(
                onPressed: onAction,
                child: Text(actionLabel),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _networkImage(
    String url, {
    double? width,
    double? height,
  }) {
    if (url.isEmpty) {
      return const Icon(Icons.movie, size: 40);
    }

    return Image.network(
      url,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.black12,
          child: const Icon(Icons.movie, size: 40),
        );
      },
    );
  }

  void _openMovie(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailScreen(movie: movie),
      ),
    );
  }
}