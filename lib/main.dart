import 'package:flutter/material.dart';
import 'package:my_app/pages/add_event_page.dart';
import 'package:my_app/pages/event_page.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main () async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  setCurrentIndex(int index){
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white, // Couleur du texte
        ),
      ),
      // home: const EventPage(),
      home: Scaffold(
        appBar: AppBar(
          title: [
            Text("Accueil"),
            Text("Liste de Conference"),
            Text("Formulaire"),

          ][_currentIndex],
        ),
        body:[
          HomePage(),
          EventPage(),
          AddEventPage()

        ] [_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
            onTap: (index)=> setCurrentIndex(index),
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
            // backgroundColor: Colors.amber,
            elevation: 1,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Accueil"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: "Planing"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: "Ajout"
              )
            ]
        ),
      ),
      // home: const HomePage(),
    );
  }
}






