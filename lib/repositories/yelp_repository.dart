import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurantour/models/restaurant.dart';

const _apiKey =
    'p24Kjxk9g1uiYntnFO-Zbu9KrcnNM0cNmo-cduKm-M2RD0R1_n6E2mNdZRlMnoWi7G-NjVmjB5a1Ns8qKgBi7e8PCtDHjVtLZtBclZP8lcb5ZAp_lFrOr6C8nkxbZnYx';

class YelpRepository {
  late Dio dio;

  YelpRepository({
    @visibleForTesting Dio? dio,
  }) : dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://api.yelp.com',
                headers: {
                  'Authorization': 'Bearer $_apiKey',
                  'Content-Type': 'application/graphql',
                },
              ),
            );

  /// Returns a response in this shape
  /// {
  /// "data": {
  ///   "search": {
  ///     "total": 5056,
  ///     "business": [
  ///       {
  ///         "id": "faPVqws-x-5k2CQKDNtHxw",
  ///         "name": "Yardbird Southern Table & Bar",
  ///         "price": "$$",
  ///         "rating": 4.5,
  ///         "photos": [
  ///           "https:///s3-media4.fl.yelpcdn.com/bphoto/_zXRdYX4r1OBfF86xKMbDw/o.jpg"
  ///         ],
  ///         "reviews": [
  ///           {
  ///             "id": "sjZoO8wcK1NeGJFDk5i82Q",
  ///             "rating": 5,
  ///             "user": {
  ///               "id": "BuBCkWFNT_O2dbSnBZvpoQ",
  ///               "image_url": "https:///s3-media2.fl.yelpcdn.com/photo/v8tbTjYaFvkzh1d7iE-pcQ/o.jpg",
  ///               "name": "Gina T."
  ///             }
  ///           },
  ///           {
  ///             "id": "okpO9hfpxQXssbTZTKq9hA",
  ///             "rating": 5,
  ///             "user": {
  ///               "id": "0x9xu_b0Ct_6hG6jaxpztw",
  ///               "image_url": "https:///s3-media3.fl.yelpcdn.com/photo/gjz8X6tqE3e4praK4HfCiA/o.jpg",
  ///               "name": "Crystal L."
  ///             }
  ///           },
  ///        ...
  ///     ]
  ///   }
  /// }
  ///
  Future<RestaurantQueryResult?> getRestaurants({int offset = 0}) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '/v3/graphql',
        data: _getQuery(offset),
      );
      return RestaurantQueryResult.fromJson(response.data!['data']['search']);
    } catch (e) {
      return null;
    }
  }

  String _getQuery(int offset) {
    return '''
query getRestaurants {
  search(location: "Las Vegas", limit: 20, offset: $offset) {
    total    
    business {
      id
      name
      price
      rating
      photos
      reviews {
        id
        rating
        user {
          id
          image_url
          name
        }
      }
      categories {
        title
        alias
      }
      hours {
        is_open_now
      }
      location {
        formatted_address
      }
    }
  }
}
''';
  }

  Future<RestaurantQueryResult> readJsonFile(String filePath) async {
    try {
      // Read the file
      final file = File(filePath);
      String contents = await file.readAsString();

      // Decode the JSON contents into a Map
      final jsonMap = json.decode(contents);

      // Convert the Map to a RestaurantQueryResult object
      return RestaurantQueryResult.fromJson(jsonMap);
    } catch (e) {
      print('Error reading JSON file: $e');
      rethrow;
    }
  }
}
