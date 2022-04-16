class Movie {
  dynamic? posterLink;
  dynamic? seriesTitle;
  dynamic? releasedYear;
  dynamic? certificate;
  dynamic? runtime;
  dynamic? genre;
  dynamic? iMDBRating;
  dynamic? overview;
  dynamic? metaScore;
  dynamic? director;
  dynamic? star1;
  dynamic? star2;
  dynamic? star3;
  dynamic? star4;
  dynamic? noOfVotes;
  dynamic? gross;
  dynamic? key;
  dynamic? useruid;
  dynamic like;
  dynamic list;

  Movie(
      {this.posterLink,
      this.seriesTitle,
      this.releasedYear,
      this.certificate,
      this.runtime,
      this.genre,
      this.iMDBRating,
      this.overview,
      this.metaScore,
      this.director,
      this.star1,
      this.star2,
      this.star3,
      this.star4,
      this.noOfVotes,
      this.gross,
      this.useruid,
      this.like,
      this.list});

  Movie.fromJson(Map<String, dynamic> json) {
    posterLink = json['Poster_Link'];
    seriesTitle = json['Series_Title'];
    releasedYear = json['Released_Year'];
    certificate = json['Certificate'];
    runtime = json['Runtime'];
    genre = json['Genre'];
    iMDBRating = json['IMDB_Rating'];
    overview = json['Overview'];
    metaScore = json['Meta_score'];
    director = json['Director'];
    star1 = json['Star1'];
    star2 = json['Star2'];
    star3 = json['Star3'];
    star4 = json['Star4'];
    noOfVotes = json['No_of_Votes'];
    gross = json['Gross'];
    useruid = json['useruid'];
    like = json['like'];
    list = json['list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Poster_Link'] = posterLink;
    data['Series_Title'] = seriesTitle;
    data['Released_Year'] = releasedYear;
    data['Certificate'] = certificate;
    data['Runtime'] = runtime;
    data['Genre'] = genre;
    data['IMDB_Rating'] = iMDBRating;
    data['Overview'] = overview;
    data['Meta_score'] = metaScore;
    data['Director'] = director;
    data['Star1'] = star1;
    data['Star2'] = star2;
    data['Star3'] = star3;
    data['Star4'] = star4;
    data['No_of_Votes'] = noOfVotes;
    data['Gross'] = gross;
    data['useruid'] = useruid;
    data['like'] = like;
    data['list'] = list;
    return data;
  }
}

// class IMBDBList {
//   List<Movie> movies = [];
//   IMBDBList.fromJsonList(Map value) {
//     value.forEach((key, value) {
//       var movie = Movie.fromJson(value);
//       movie.key = key;
//       movies.add(movie);
//     });
//   }
// }

class IMBDBLists {
  List<Movie> movies = [];
  int i = 0;
  IMBDBLists.fromJsonList(Map<String, dynamic> value) {
    value.forEach((key, value) {
      print(value.length);

      var movie = Movie.fromJson(value);
      movie.key = key;
      print(i);
      movies.add(movie);
    });
  }
}
