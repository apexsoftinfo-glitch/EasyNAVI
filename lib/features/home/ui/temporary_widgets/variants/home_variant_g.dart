import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../app/developer/ui/developer_screen.dart';
import '../../../../../features/profiles/presentation/ui/profile_screen.dart';

class HomeVariantGScreen extends StatelessWidget {
  const HomeVariantGScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        textTheme: GoogleFonts.interTextTheme(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _HeaderLabel().animate().fadeIn().slideY(begin: -0.2),
                const SizedBox(height: 32),
                
                // Bento Grid
                Expanded(
                  child: Column(
                    children: [
                      // Large Top Card (Action)
                      _BentoTile(
                        label: 'JEDZIEMY',
                        icon: Icons.navigation_rounded,
                        color: Colors.black,
                        iconColor: const Color(0xFFC6FF00), // Electric Lime
                        isLarge: true,
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          _showStub(context, 'Wybierz cel...');
                        },
                      ).animate().fadeIn(delay: 100.ms).scale(begin: const Offset(0.95, 0.95)),
                      
                      const SizedBox(height: 16),
                      
                      // Bottom Row
                      Expanded(
                        child: Row(
                          children: [
                            _BentoTile(
                              label: 'ADRESY',
                              icon: Icons.map_outlined,
                              color: Colors.white,
                              onTap: () {
                                HapticFeedback.selectionClick();
                                _showStub(context, 'Twoje adresy');
                              },
                            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
                            const SizedBox(width: 16),
                            _BentoTile(
                              label: 'USTAWIENIA',
                              icon: Icons.settings_outlined,
                              color: Colors.white,
                              onTap: () {
                                HapticFeedback.selectionClick();
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                                );
                              },
                            ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                const _Footer().animate().fadeIn(delay: 500.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showStub(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

class _HeaderLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EASY',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            letterSpacing: 4,
            color: Colors.grey.shade400,
          ),
        ),
        Text(
          'NAVI',
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class _BentoTile extends StatefulWidget {
  const _BentoTile({
    required this.label,
    required this.icon,
    required this.color,
    this.iconColor,
    this.isLarge = false,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final Color? iconColor;
  final bool isLarge;
  final VoidCallback onTap;

  @override
  State<_BentoTile> createState() => _BentoTileState();
}

class _BentoTileState extends State<_BentoTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.color.computeLuminance() < 0.5;
    final textColor = isDark ? Colors.white : Colors.black;

    return Expanded(
      flex: widget.isLarge ? 0 : 1,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: double.infinity,
          height: widget.isLarge ? 180 : double.infinity,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.grey.shade200,
              width: 0.5,
            ),
            boxShadow: [
              if (!_isPressed)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
            ],
          ),
          child: Column(
            mainAxisAlignment: widget.isLarge ? MainAxisAlignment.center : MainAxisAlignment.start,
            crossAxisAlignment: widget.isLarge ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              if (!widget.isLarge) const SizedBox(height: 24),
              if (!widget.isLarge) const SizedBox(width: 24),
              Padding(
                padding: EdgeInsets.all(widget.isLarge ? 0 : 24.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (widget.iconColor ?? textColor).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        widget.icon,
                        size: widget.isLarge ? 40 : 28,
                        color: widget.iconColor ?? textColor,
                      ),
                    ),
                    if (widget.isLarge) const SizedBox(width: 20),
                    if (widget.isLarge)
                      Text(
                        widget.label,
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: textColor,
                          letterSpacing: 2,
                        ),
                      ),
                  ],
                ),
              ),
              if (!widget.isLarge) const Spacer(),
              if (!widget.isLarge)
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    widget.label,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: textColor.withValues(alpha: 0.7),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const DeveloperScreen()),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const Icon(Icons.developer_mode, size: 16, color: Colors.grey),
          ),
        ),
        Text(
          'EASYNAVI TOOLS V1.0',
          style: GoogleFonts.inter(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade400,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
