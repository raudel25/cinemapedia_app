import 'package:cinemapedia_app/presentation/screens/screens.dart';
import 'package:cinemapedia_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatefulWidget {
  static const name = 'layout-screen';

  final int page;

  const LayoutScreen({super.key, required this.page});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        setLoading: (value) => setState(() {
          isLoading = value;
        }),
      ),
      const CategoriesScreen(),
      const FavoritesScreen()
    ];

    return Loader(
        isLoading: isLoading,
        child: Scaffold(
          body: IndexedStack(
            index: widget.page,
            children: screens,
          ),
          bottomNavigationBar: CustomBottomNavigationBar(
            index: widget.page,
          ),
        ));
  }
}
