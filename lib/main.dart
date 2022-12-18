import 'package:aceplus_codetest/sreens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helpers/db_helper.dart';
import 'provider/user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Aceplus Coding test',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          brightness: Brightness.dark
        ),
        home: FutureBuilder(
          future: DBHelper.openDB(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            
            return const Home();
          },
        ),
      ),
    );
  }
}
