import 'package:cinemapedia_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatelessWidget {
  static const name = 'layout-screen';

  final Widget screen;
  const LayoutScreen({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen,
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
