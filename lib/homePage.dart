import 'package:flutter/material.dart';
import 'package:movies/dataService.dart';
import 'movieCard.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String imageUrl = 'https://image.tmdb.org/t/p/w500/';
  String genreUrl =
      'https://api.themoviedb.org/3/genre/movie/list?api_key=8561ac90901236d3888023b8e21667fc&language=en-US';
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider<DataService>(
      create: (context) => DataService(),
      child: SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Consumer<DataService>(
                  builder: (context, dataService, child) {
                    return TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      onChanged: (val) async {
                        dataService.getChangedData(val);
                      },
                    );
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  height: height * 0.8,
                  child: Consumer<DataService>(
                      builder: (context, dataService, child) {
                    return ListView.builder(
                      itemCount: dataService.movies.length == 0
                          ? dataService.topRatedMovies.length
                          : dataService.movies.length,
                      itemBuilder: (context, index) {
                        dataService.genres = [];
                        var genreID = dataService.movies.length == 0
                            ? dataService.topRatedMovies[index]['genre_ids']
                            : dataService.movies[index]['genre_ids'];
                        for (var i = 0; i < genreID.length; i++)
                          for (var j = 0; j < dataService.genresData.length; j++) {
                            if (genreID[i] == dataService.genresData[j]['id']) {
                              dataService.genres.add(dataService.genresData[j]['name']);
                            }
                          }
                        return dataService.movies.length != 0 
                            ? MovieCard(
                                imageUrl: imageUrl,
                                moviePicture: dataService.movies[index]
                                    ['poster_path'],
                                movieTitle: dataService.movies[index]['title'],
                                genre: dataService.genres,
                                rating: dataService.movies[index]['vote_average']
                                    .toDouble(),
                              )
                            : MovieCard(
                                imageUrl: imageUrl,
                                moviePicture: dataService.topRatedMovies[index]
                                    ['poster_path'],
                                movieTitle: dataService.topRatedMovies[index]['title'],
                                genre: dataService.genres,
                                rating: dataService.topRatedMovies[index]['vote_average']
                                    .toDouble(),
                              );
                      },
                    );
                  }),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
