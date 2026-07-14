import 'package:dev_mate_ai/features/history/presentation/pages/history_screen.dart';
import 'package:flutter/material.dart';
import '../chat_screen/presentation/pages/chat_screen.dart';
import '../home/presentation/pages/home_screen.dart';
import '../profile/presentation/pages/profile_screen.dart';

class NavigationPages {
  static const pages = <Widget>[
    HomeScreen(),
    ChatScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];
}
