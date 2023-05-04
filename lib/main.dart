import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graph/firebase_options.dart';
import 'package:flutter_graph/page/top/top_page.dart';

Future<void> main() async {
  // Firebase初期化
  await Firebase.initializeApp(
    name: "flutter-graph",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Graph',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TopPage(title: 'Googleアンケート回答表'),
    );
  }
}


