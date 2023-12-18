import 'package:flutter/material.dart';
import 'package:bear_radio/station_list.dart';
import 'package:provider/provider.dart';

import 'station_manager.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => StationManager.shared,
    child: MaterialApp(
      title: 'Bear Radio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const StationListPage(),
    ),
  ));
}
