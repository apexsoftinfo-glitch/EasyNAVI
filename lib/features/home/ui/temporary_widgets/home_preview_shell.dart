import 'package:flutter/material.dart';

import 'variants/home_variant_a.dart';
import 'variants/home_variant_d.dart';
import 'variants/home_variant_e.dart';
import 'variants/home_variant_f.dart';
import 'variants/home_variant_g.dart';
import 'home_variant_switcher.dart';

const _homeVariantLabels = ['A', 'D', 'E', 'F', 'G'];

class HomePreviewShell extends StatefulWidget {
  const HomePreviewShell({super.key});

  @override
  State<HomePreviewShell> createState() => _HomePreviewShellState();
}

class _HomePreviewShellState extends State<HomePreviewShell> {
  int _selectedVariant = 0;

  @override
  Widget build(BuildContext context) {
    final variants = [
      const HomeVariantAScreen(),
      const HomeVariantDScreen(),
      const HomeVariantEScreen(),
      const HomeVariantFScreen(),
      const HomeVariantGScreen(),
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
