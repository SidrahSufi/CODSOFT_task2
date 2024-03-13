import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';
import 'favourite.dart';
import 'favourite_provider.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(

        create:(context) => FavoritesProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,

        home: TodaysQuotes(),
      ),
    );
  }
}


