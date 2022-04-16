import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:movies_app/model/movie.dart';

class ApiService {
  String? _baseUrl;

  static ApiService _instance = ApiService._privateConstructor();
  ApiService._privateConstructor() {
    _baseUrl = "https://moviesapp-f547c-default-rtdb.firebaseio.com/";
  }

  static ApiService getInstance() {
    if (_instance == null) {
      return ApiService._privateConstructor();
    }
    return _instance;
  }

  Future<List<Movie>> getImdbMovie() async {
    final response = await http.get(Uri.parse("$_baseUrl/imdbMovieList.json"));

    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        final movieList = IMBDBLists.fromJsonList(jsonResponse);
        return movieList.movies;
      case HttpStatus.unauthorized:
        debugPrint("Error Unauthoriaze");
        Logger().e(jsonResponse);
        break;
    }
    return Future.error(jsonResponse);
  }

  Future<List<Movie>> getMyLikeMovie() async {
    final response =
        await http.get(Uri.parse("$_baseUrl/likeImdbMovieList.json"));

    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        final movieList = IMBDBLists.fromJsonList(jsonResponse);
        return movieList.movies;
      case HttpStatus.unauthorized:
        debugPrint("Error Unauthoriaze");
        Logger().e(jsonResponse);
        break;
    }
    return Future.error(jsonResponse);
  }

  Future<void> likeImdbMovie(Movie model) async {
    final jsonBody = json.encode(model.toJson());
    final response = await http
        .post(Uri.parse("$_baseUrl/likeImdbMovieList.json"), body: jsonBody);

    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value();
      case HttpStatus.unauthorized:
        debugPrint("Error Unauthoriaze");
        Logger().e(jsonResponse);
        break;
    }
    return Future.error(jsonResponse);
  }

  Future<void> removeLikeImdbMovie(String key) async {
    final response =
        await http.delete(Uri.parse("$_baseUrl/likeImdbMovieList/$key.json"));

    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value();
      case HttpStatus.unauthorized:
        debugPrint("Error Unauthoriaze");
        Logger().e(jsonResponse);
        break;
    }
    return Future.error(jsonResponse);
  }
}
