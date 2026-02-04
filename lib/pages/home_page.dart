import 'package:flutter/material.dart';

import 'event_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Image.asset(
    "assets/images/minia.png",
    width: 150,
    height: 150,
    ),
    const SizedBox(height: 20),
    const Text(
    "Asynconf 2026",
    style: TextStyle(
    fontSize: 42,
    fontFamily: 'Poppins'
    ),
    ),
    const Text(
    "Salon virtuel de l'informatique du 27 au 29 Novembre 2026",
    style: TextStyle(fontSize: 24),
    textAlign: TextAlign.center,
    ),
    const SizedBox(height: 20),
    ],
    ),
    );
  }
}