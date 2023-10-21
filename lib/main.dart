import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_name_jezt/dio_client.dart';
import 'package:movie_name_jezt/movie_detail_view.dart';

import 'movie_name_list_response.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your applica tion.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Movie List'),
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
  // List<MovieListResponse> movies = [];
  // String searchQuery = '';
  bool _isLoading = false;
  final TextEditingController _search = TextEditingController();
  late Future<MovieListResponse> _futureMovieResponse;
  Future <MovieListResponse> getMovieName() async{
  final dio = Dio();
  DioClient dioClient = DioClient(dio);
  final response =await dioClient.request({}, RequestType.get, "http://www.omdbapi.com/?i=tt3896198&apikey=84e8152b");
  MovieListResponse movieListResponse = MovieListResponse.fromJson(response.data);
  return movieListResponse;


}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:  [Color(0xFFFF0080), Color(0xFFFF4A4A)], // Define your gradient colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        title: Text(widget.title,style: TextStyle(color: Colors.white),),
      ),
      body:FutureBuilder<MovieListResponse>(
        future: getMovieName(), // Call your fetchMovieData function here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available.'));
          } else {// Use a ListView.builder to display the movie data

            return Container(
              decoration: new BoxDecoration(image: DecorationImage(image: AssetImage('asset/images/movie_bg.png'),fit: BoxFit.cover)),
              child: Column(
                children: [

                  SizedBox(
                    height: 500,
                    child: ListView.builder(
                      itemCount:5, // Assuming you want to display one item.
                      itemBuilder: (context, index) {
                        final movieData = snapshot.data; // Get the movie data
                        return Padding(
                          padding: const EdgeInsets.only(left: 25.0,right: 25.0,top: 10.0,bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white,
                                boxShadow: [new BoxShadow(color: Colors.grey,blurRadius: 10.0)]),
                            child: Row(
                              children: [

                                Column(
                                  children: [
                                    ClipRRect(
                                      child: Image.network(movieData?.poster ?? '',height: 150,width: 100,fit: BoxFit.cover,),
                                    ),

                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data?.title ?? '',style: TextStyle(fontSize: 15.0,fontFamily: 'serif',fontWeight: FontWeight.bold,color: Colors.black),),
                                      Text(snapshot.data?.year ?? '')
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
