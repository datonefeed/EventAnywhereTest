import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class EventRepository {
  final String apiUrl = 'http://10.0.2.2:3000/event/get';

  Future<List<EventModel>> fetchEvents() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final events = (data['events'] as List)
            .map((eventData) => EventModel.fromJson(eventData))
            .toList();
        return events;
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      throw Exception('Error fetching events: $e');
    }
  }
}
