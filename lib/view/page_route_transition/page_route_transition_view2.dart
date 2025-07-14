import 'package:flutter/material.dart';

class PageRouteTransitionView2 extends StatelessWidget {
  const PageRouteTransitionView2({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(title: const Text("Second Page")),
      body: const Center(child: Text("Welcome to the Second Page")),
    );
  }
}
