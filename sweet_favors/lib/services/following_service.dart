import 'package:dio/dio.dart';
import 'package:sweet_favors/components/following_model.dart';

class FollowingService {
  final Dio _dio;

  FollowingService(this._dio);

  Future<List<Following>> fetchFollowingOfCurrentUser(
      String token, int userId) async {
    final response = await _dio.get(
      'http://10.0.2.2:1432/GetFollowingOfCurrentUser',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Adjust content type as needed
        },
      ),
    );

    if (response.statusCode == 200) {
      final parsedJson = response.data as List;
      return parsedJson.map((json) => Following.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load following');
    }
  }
}
