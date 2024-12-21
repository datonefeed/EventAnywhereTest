import 'package:flutter/material.dart';
import 'package:register_func/models/speaker_model.dart';
import 'package:register_func/core/theme/my_theme.dart';

class EventSpeakerTab extends StatelessWidget {
  final List<Speaker> speakers;

  EventSpeakerTab({required this.speakers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: speakers.length,
      itemBuilder: (context, index) {
        final speaker = speakers[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(speaker.profileImageUrl),
          ),
          title: Text(speaker.name, style: AppTextStyles.subheading),
          subtitle: Text(speaker.position, style: AppTextStyles.body),
        );
      },
    );
  }
}
