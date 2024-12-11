import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  const Loading({super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    final themeStyle = Theme.of(context).textTheme.titleMedium;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? Colors.black
            .withOpacity(0.5) // Fondo oscuro con opacidad en modo oscuro
        : Colors.white
            .withOpacity(0.8); // Fondo claro con opacidad en modo claro
    final textColor = isDarkMode
        ? Colors.white // Texto blanco en modo oscuro
        : Colors.black; // Texto negro en modo claro

    return Stack(
      children: [
        child,
        if (isLoading)
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'loading'.tr(),
                    style: themeStyle?.copyWith(color: textColor),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
