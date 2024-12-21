import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_func/ui/viewmodels/change_password_viewmodel.dart';
import 'package:register_func/ui/viewmodels/event_management_viewmodel.dart';
import 'package:register_func/ui/viewmodels/event_participation_viewmodel.dart';
import 'package:register_func/ui/viewmodels/event_search_viewmodel.dart';
import 'package:register_func/ui/viewmodels/event_viewmodel.dart';
import 'package:register_func/ui/viewmodels/filter_viewmodel.dart';
import 'package:register_func/ui/viewmodels/profile_viewmodel.dart';
import 'package:register_func/ui/viewmodels/recommend_viewmodel.dart';
import 'package:register_func/ui/viewmodels/reset_password_viewmodel.dart';
import 'package:register_func/ui/viewmodels/session_detail_viewmodel.dart';
import 'package:register_func/ui/viewmodels/session_viewmodel.dart';
import 'package:register_func/ui/viewmodels/signup_viewmodel.dart';
import 'package:register_func/ui/viewmodels/speaker_viewmodel.dart';
import 'package:register_func/ui/viewmodels/update_event_viewmodel.dart';
import 'package:register_func/ui/viewmodels/update_session_viewmodel.dart';
import 'package:register_func/ui/views/event/update_event_screen.dart';
import '../core/constants/app_routers.dart';
import 'ui/viewmodels/signin_viewmodel.dart';
import 'ui/viewmodels/event_detail_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => SignInViewModel()),
        ChangeNotifierProvider(create: (_) => EventDetailViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => ChangePasswordViewModel()),
        ChangeNotifierProvider(create: (_) => ResetPasswordViewModel()),
        ChangeNotifierProvider(create: (_) => EventViewModel()),
        ChangeNotifierProvider(create: (_) => EventManagementViewModel()),
        ChangeNotifierProvider(create: (_) => SessionViewModel()),
        ChangeNotifierProvider(create: (_) => SessionDetailViewModel()),
        ChangeNotifierProvider(create: (_) => SpeakerViewModel()),
        ChangeNotifierProvider(create: (_) => UpdateSessionViewmodel()),
        ChangeNotifierProvider(create: (_) => UpdateEventViewModel()),
        ChangeNotifierProvider(create: (_) => EventSearchViewModel()),
        ChangeNotifierProvider(create: (_) => FilterViewModel()),
        ChangeNotifierProvider(create: (_) => RecommendViewModel()),
        ChangeNotifierProvider(create: (_) => EventParticipationViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
