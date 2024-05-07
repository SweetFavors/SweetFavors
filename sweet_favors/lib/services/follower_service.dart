import 'package:dio/dio.dart';
import 'package:sweet_favors/components/follower_model.dart';

class FollowerService {
  final Dio _dio;

  FollowerService(this._dio);

  Future<List<Follower>> fetchFollowersOfCurrentUser(int userId) async {
    final response =
        await _dio.get('http://10.0.2.2:1432/GetFollowersOfCurrentUser/1');

    if (response.statusCode == 200) {
      final parsedJson = response.data as List;
      return parsedJson.map((json) => Follower.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load followers');
    }
  }
}
