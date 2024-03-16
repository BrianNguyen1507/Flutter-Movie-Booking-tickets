import 'package:flutter/material.dart';
import 'package:movie_booking/Views/movies_detail/movieDetail_screen.dart';
import 'package:movie_booking/model/film/film.dart';
import 'package:movie_booking/services/converter.dart';
import 'package:movie_booking/services/fetchingData.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

final TextEditingController _searchController = TextEditingController();
late Future<List<Film>> filmsShowing;
late Future<List<Film>> filmsFuture;
late Future<List<Film>> search;
List<Film> _filteredFilms = [];

Future<List<Film>> _searchFilms(String searchText) async {
  List<Film> allFilms = [];
  allFilms.addAll(await filmsShowing);
  allFilms.addAll(await filmsFuture);

  List<Film> filteredFilms = [];
  for (Film film in allFilms) {
    if (film.title.toLowerCase().contains(searchText.toLowerCase())) {
      filteredFilms.add(film);
    }
  }
  return filteredFilms;
}

bool isFutureRelease = false;

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    filmsShowing = ListFeatured.fetchData("1-11-2023", "1-1-2024");
    filmsFuture = ListFeatured.fetchData("1-1-2024", "1-12-2025");
  }

  void _onSearchTextChanged(String text) {
    _searchFilms(text).then(
      (filteredFilms) {
        setState(
          () {
            _filteredFilms = filteredFilms;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchTextChanged,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: Container(
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 15.0,
                          ),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _filteredFilms.clear();
                            });
                          },
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _searchController.clear();
                    _filteredFilms.clear();
                  });
                },
                child: const Text(
                  'Back',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Divider(
              color: Colors.grey[400],
              thickness: 1,
              height: 20,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredFilms.length,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.grey[300],
                  child: GestureDetector(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Image.memory(
                            toUint(_filteredFilms[index].posters),
                            width: 130,
                            height: 150,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _filteredFilms[index].title,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                              Text(
                                _filteredFilms[index].dateRelease,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black45),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailPage(
                            film: _filteredFilms[index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
