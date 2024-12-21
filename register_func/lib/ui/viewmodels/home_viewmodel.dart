import 'package:flutter/material.dart';
import 'package:register_func/models/event_model.dart';
import 'package:register_func/repositories/event_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final EventRepository _eventRepository = EventRepository();
  List<EventModel> eventList = [];
  bool isLoading = false;
  String errorMessage = '';

  HomeViewModel() {
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      eventList = await _eventRepository.fetchEvents();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
