import 'package:flutter/material.dart';

import 'variants/home_variant_a.dart';
import 'home_variant_switcher.dart';

const _homeVariantLabels = ['A', 'B', 'C', 'D', 'E', 'F'];

class HomePreviewShell extends StatefulWidget {
  const HomePreviewShell({super.key});

  @override
  State<HomePreviewShell> createState() => _HomePreviewShellState();
}

class _HomePreviewShellState extends State<HomePreviewShell> {
  int _selectedVariant = 0;

  @override
  Widget build(BuildContext context) {
    const variants = [
      HomeVariantAScreen(),
      HomeVariantAScreen(),
      HomeVariantAScreen(),
      HomeVariantAScreen(),
      HomeVariantAScreen(),
      HomeVariantAScreen(),
    ];

    return Column(
      children: [
        Expanded(child: variants[_selectedVariant]),
        HomeVariantSwitcher(
          labels: _homeVariantLabels,
          selectedVariant: _selectedVariant,
          onVariantSelected: (variant) {
            setState(() {
              _selectedVariant = variant;
            });
          },
        ),
      ],
    );
  }
}
