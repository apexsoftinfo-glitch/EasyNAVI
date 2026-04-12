import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../app/developer/ui/developer_screen.dart';
import '../../../../../features/profiles/presentation/ui/profile_screen.dart';

class HomeVariantDScreen extends StatelessWidget {
  const HomeVariantDScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2C3E50), // Slate
          primary: const Color(0xFF2C3E50),
          secondary: const Color(0xFFFF8C00), // Orange
        ),
      ),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: const Color(0xFF1A1A1A),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'EasyNAVI'.toUpperCase(),
                style: GoogleFonts.oswald(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 4,
                ),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.5,
                  colors: [
                    const Color(0xFF2C3E50).withValues(alpha: 0.3),
                    const Color(0xFF1A1A1A),
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(),
                  _IndustrialButton(
                    label: 'JEDZIEMY',
                    icon: Icons.navigation_rounded,
                    isPrimary: true,
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      _showStub(context, 'Uruchamiam nawigację');
                    },
                  ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.3, curve: Curves.easeOutBack),
                  const SizedBox(height: 24),
                  _IndustrialButton(
                    label: 'ADRESY',
                    icon: Icons.map_rounded,
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      _showStub(context, 'Baza adresów');
                    },
                  ).animate().fadeIn(delay: 100.ms, duration: 400.ms).slideY(begin: 0.3, curve: Curves.easeOutBack),
                  const SizedBox(height: 24),
                  _IndustrialButton(
                    label: 'USTAWIENIA',
                    icon: Icons.settings_rounded,
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ProfileScreen()),
                      );
                    },
                  ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideY(begin: 0.3, curve: Curves.easeOutBack),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const DeveloperScreen()),
                    ),
                    icon: const Icon(Icons.developer_mode, color: Colors.grey, size: 16),
                    label: const Text('DEV TOOLS', style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 2)),
                  ).animate().fadeIn(delay: 500.ms),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showStub(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF2C3E50),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _IndustrialButton extends StatefulWidget {
  const _IndustrialButton({
    required this.label,
    required this.icon,
    this.isPrimary = false,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  @override
  State<_IndustrialButton> createState() => _IndustrialButtonState();
}

class _IndustrialButtonState extends State<_IndustrialButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 60),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.isPrimary ? const Color(0xFFFF8C00) : Colors.white;
    final bgColor = widget.isPrimary ? const Color(0xFF2C3E50) : const Color(0xFF333333);

    return GestureDetector(
      onTapDown: (_) {
        _controller.forward();
        HapticFeedback.selectionClick();
      },
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final isPressed = _controller.value > 0;
          return Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: color.withValues(alpha: 0.3),
                width: 1,
              ),
              boxShadow: isPressed
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        offset: const Offset(0, 6),
                        blurRadius: 0,
                      ),
                      BoxShadow(
                        color: color.withValues(alpha: 0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
            ),
            child: Transform.translate(
              offset: isPressed ? const Offset(0, 4) : Offset.zero,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.05),
                      Colors.black.withValues(alpha: 0.05),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 24),
                    Icon(widget.icon, size: 32, color: color),
                    const SizedBox(width: 20),
                    Text(
                      widget.label,
                      style: GoogleFonts.oswald(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: color,
                        letterSpacing: 2,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.chevron_right, color: color.withValues(alpha: 0.3)),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
