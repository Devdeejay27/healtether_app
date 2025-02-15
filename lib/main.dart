import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healtether_app/provider/user_provider.dart';
import 'package:healtether_app/views/user_list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const HealTetherApp(),
    ),
  );
}

class HealTetherApp extends StatelessWidget {
  const HealTetherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HealTether App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const UserListScreen(),
    );
  }
}
