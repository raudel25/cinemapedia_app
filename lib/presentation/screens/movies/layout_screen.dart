import 'package:cinemapedia_app/presentation/screens/screens.dart';
import 'package:cinemapedia_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatefulWidget {
  static const name = 'layout-screen';

  final int page;
  final Object? param;

  const LayoutScreen({super.key, required this.page, required this.param});

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
      CategoriesScreen(
        categoryName: widget.param as String?,
        setLoading: (value) => setState(() {
          isLoading = value;
        }),
      ),
      FavoritesScreen(
        setLoading: (value) => setState(() {
          isLoading = value;
        }),
      )
    ];

    return Loader(
        isLoading: isLoading,
        child: Scaffold(
          body: screens[widget.page],
          bottomNavigationBar: CustomBottomNavigationBar(
            index: widget.page,
          ),
        ));
  }
}
