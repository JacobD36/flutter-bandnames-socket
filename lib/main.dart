import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:band_names/pages/home.dart';
import 'package:band_names/pages/status.dart';
import 'package:band_names/services/socket_service.dart';

void main() {
  runApp(MyApp());
} 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SocketService()
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'status',
        routes: {
          'home': (BuildContext context) => HomePage(),
          'status': (BuildContext context) => StatusPage()
        },
      ),
    );
  }
}