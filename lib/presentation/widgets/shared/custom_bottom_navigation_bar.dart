import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int index;
  const CustomBottomNavigationBar({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (int index) {
          switch (index) {
            case 0:
              context.push('/home/0');
              break;
            case 1:
              context.push('/home/1');
              break;
            case 2:
              context.push('/home/2');
              break;
          }
        },
        currentIndex: index,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home_max), label: 'home'.tr()),
          BottomNavigationBarItem(
              icon: const Icon(Icons.label_outline), label: 'categories'.tr()),
          BottomNavigationBarItem(
              icon: const Icon(Icons.favorite_outline), label: 'favorites'.tr())
        ]);
  }
}
