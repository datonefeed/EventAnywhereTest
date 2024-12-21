import 'dart:convert';
import '../models/event_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EventDetailRepository {
  final String baseUrl = "http://10.0.2.2:3000/show/event";
  Future<EventDetail> getEventById(String eventId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      if (accessToken == null) {
        throw Exception("Access token is missing");
      }
      final response = await http.get(
        Uri.parse('$baseUrl/$eventId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);
        return EventDetail.fromJson(jsonData);
      } else {
        throw Exception('Failed to load event');
      }
    } catch (error) {
      throw Exception('Failed to load event: $error');
    }
  }
}
