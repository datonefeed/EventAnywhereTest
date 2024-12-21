import 'package:flutter/material.dart';
import 'package:register_func/models/event_detail_model.dart';
import 'package:register_func/repositories/event_detail_repository.dart';

class EventDetailViewModel extends ChangeNotifier {
  final EventDetailRepository _eventRepository = EventDetailRepository();
  EventDetail? event;
  bool isLoading = true;

  Future<void> fetchEvent(String eventId) async {
    isLoading = true;
    notifyListeners();

    try {
      event = await _eventRepository.getEventById(eventId);
    } catch (e) {
      print('Error fetching event details: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
