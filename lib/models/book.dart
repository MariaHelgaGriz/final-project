class Book {
  final int id;
  final String title;
  final String author;
  final String genre;
  final String description;
  final double rating;
  final String url;

  Book({
    required this.id,
    required this.title,
    required this.url,
    required this.description,
    required this.genre,
    required this.author,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'author': author,
      'genre': genre,
      'description': description,
      'rating': rating.toDouble(),
      'url': url,
    };
  }

  factory Book.fromJson(Map<String, dynamic> json, int id) {
    return Book(
      id: id,
      title: json['title'],
      author: json['author'],
      genre: json['genre'],
      description: json['description'],
      rating: json['rating'].toDouble(),
      url: json['url'],
    );
  }
}
