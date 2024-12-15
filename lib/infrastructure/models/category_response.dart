class GenresResponse {
  List<CategoryMovieDb> genres;

  GenresResponse({required this.genres});

  factory GenresResponse.fromJson(Map<String, dynamic> json) => GenresResponse(
      genres: json['genres']
          .map<CategoryMovieDb>((e) => CategoryMovieDb.fromJson(e))
          .toList());
}

class CategoryMovieDb {
  int id;
  String name;

  CategoryMovieDb({required this.id, required this.name});

  factory CategoryMovieDb.fromJson(Map<String, dynamic> json) =>
      CategoryMovieDb(id: json['id'], name: json['name']);
}
