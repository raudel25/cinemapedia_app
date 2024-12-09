import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(elevation: 0, items: [
      BottomNavigationBarItem(
          icon: const Icon(Icons.home_max), label: 'home'.tr()),
      BottomNavigationBarItem(
          icon: const Icon(Icons.label_outline), label: 'categories'.tr()),
      BottomNavigationBarItem(
          icon: const Icon(Icons.favorite_outline), label: 'favorites'.tr())
    ]);
  }
}
