import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tabs_pages.dart';
import 'package:newsapp/src/services/news_services.dart';
import 'package:newsapp/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: theme,
        home: const TabsPage()
      ),
    );
  }
}