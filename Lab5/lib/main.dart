import 'package:flutter/material.dart';

void main() {
  runApp(const MovieApp());
}

class Movie {
  final String id;
  final String title;
  final String posterUrl;
  final String overview;
  final List<String> genres;
  final double rating;
  final List<String> trailers;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.overview,
    required this.genres,
    required this.rating,
    required this.trailers,
  });
}

final List<Movie> sampleMovies = [
  Movie(
    id: '1',
    title: 'Inception',
    posterUrl: 'https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg',
    overview: 'Cobb, a skilled thief who commits corporate espionage by infiltrating the subconscious of his targets is offered a chance to regain his old life as payment for a task considered to be impossible: "inception", the implantation of another person\'s idea into a target\'s subconscious.',
    genres: ['Action', 'Science Fiction', 'Adventure'],
    rating: 8.8,
    trailers: ['Trailer 1', 'Teaser Trailer'],
  ),
  Movie(
    id: '2',
    title: 'Interstellar',
    posterUrl: 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
    overview: 'The adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage.',
    genres: ['Adventure', 'Drama', 'Science Fiction'],
    rating: 8.6,
    trailers: ['Official Trailer 1', 'Official Trailer 2'],
  ),
  Movie(
    id: '3',
    title: 'The Dark Knight',
    posterUrl: 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
    overview: 'Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets.',
    genres: ['Drama', 'Action', 'Crime', 'Thriller'],
    rating: 9.0,
    trailers: ['Trailer 1'],
  ),
];

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Detail App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: ListView.builder(
        itemCount: sampleMovies.length,
        itemBuilder: (context, index) {
          final movie = sampleMovies[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: Image.network(
                movie.posterUrl,
                width: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.movie),
              ),
              title: Text(movie.title),
              subtitle: Text('Rating: ${movie.rating}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailScreen(movie: movie),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(movie.title, style: const TextStyle(shadows: [Shadow(color: Colors.black, blurRadius: 4)])),
              background: Hero(
                tag: 'poster-${movie.id}',
                child: Image.network(
                  movie.posterUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.movie, size: 50)),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    children: movie.genres.map((g) => Chip(label: Text(g))).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text('Overview', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(movie.overview, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.star_border)),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Trailers', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  leading: const Icon(Icons.play_circle_fill),
                  title: Text(movie.trailers[index]),
                  onTap: () {},
                );
              },
              childCount: movie.trailers.length,
            ),
          ),
        ],
      ),
    );
  }
}
