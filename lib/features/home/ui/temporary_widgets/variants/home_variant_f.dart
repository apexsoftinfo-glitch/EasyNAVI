import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../app/developer/ui/developer_screen.dart';
import '../../../../../features/profiles/presentation/ui/profile_screen.dart';

class HomeVariantFScreen extends StatelessWidget {
  const HomeVariantFScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.libreFranklinTextTheme(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Easy',
                      style: GoogleFonts.montserrat(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        height: 0.9,
                        color: Colors.black,
                      ),
                    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),
                    Text(
                      'NAVI'.toUpperCase(),
                      style: GoogleFonts.montserrat(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        height: 0.9,
                        color: const Color(0xFFE63946),
                      ),
                    ).animate().fadeIn(delay: 150.ms, duration: 400.ms).slideX(begin: -0.1),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    _EditorialButton(
                      label: 'JEDZIEMY',
                      isPrimary: true,
                      onTap: () {
                        HapticFeedback.selectionClick();
                        _showStub(context, 'DRIVE MODE');
                      },
                    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),
                    const SizedBox(height: 16),
                    _EditorialButton(
                      label: 'ADRESY',
                      onTap: () {
                        HapticFeedback.selectionClick();
                        _showStub(context, 'DATABASE');
                      },
                    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
                    const SizedBox(height: 16),
                    _EditorialButton(
                      label: 'USTAWIENIA',
                      onTap: () {
                        HapticFeedback.selectionClick();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ProfileScreen()),
                        );
                      },
                    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),
                  ],
                ),
              ),
              const Spacer(),
              _BottomMenu().animate().fadeIn(delay: 700.ms),
            ],
          ),
        ),
      ),
    );
  }

  void _showStub(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2),
        ),
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }
}

class _EditorialButton extends StatefulWidget {
  const _EditorialButton({
    required this.label,
    this.isPrimary = false,
    required this.onTap,
  });

  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  @override
  State<_EditorialButton> createState() => _EditorialButtonState();
}

class _EditorialButtonState extends State<_EditorialButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isPrimary
        ? (_isPressed ? Colors.black : const Color(0xFFE63946))
        : (_isPressed ? Colors.black : Colors.white);
    final textColor = widget.isPrimary
        ? Colors.white
        : (_isPressed ? Colors.white : Colors.black);
    final borderColor = Colors.black;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 50),
        width: double.infinity,
        height: 72,
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderColor, width: 3),
        ),
        child: Center(
          child: Text(
            widget.label,
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: textColor,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black, width: 3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'VERSION 1.0.0',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 10),
          ),
          InkWell(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const DeveloperScreen()),
            ),
            child: const Text(
              'DEV TOOLS',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 10,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
