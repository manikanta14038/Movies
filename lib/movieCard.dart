import 'package:flutter/material.dart';
class MovieCard extends StatelessWidget {
  const MovieCard({
    Key key,
    @required this.imageUrl,
    @required this.moviePicture,
    @required this.movieTitle,
    @required this.genre,
    @required this.rating,
  }) : super(key: key);

  final String imageUrl;
  final String moviePicture;
  final String movieTitle;
  final List<dynamic> genre;
  final double rating;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.25,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            top: height * 0.02,
            left: width * 0.08,
            height: height * 0.2,
            width: width * 0.8,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Card(
                elevation: 8.0,
              ),
            ),
          ),
          Positioned(
            left: width * 0.08,
            bottom: height * 0.04,
            child: Container(
              height: height * 0.2,
              width: width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage('$imageUrl$moviePicture'),
                ),
              ),
              // child: Image.network('$imageUrl$moviePicture'),
            ),
          ),
          Positioned(
            top: height * 0.04,
            left: width * 0.4,
            child: Container(
              width: width * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    movieTitle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: <Widget>[
                      for (var i = 0; i < genre.length; i++)
                        Text(
                          ' ${genre[i]}, ',
                          style: TextStyle(fontSize: 12.0),
                        ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$rating',
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(5, (index) {
                          return Icon(
                            index < rating.toInt() / 2
                                ? Icons.star
                                : Icons.star_border,
                            size: 16.0,
                            color: Colors.orange,
                          );
                        }),
                      ),
                    ],
                  ),
                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
