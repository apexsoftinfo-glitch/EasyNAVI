import 'dart:ui';
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
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            // Bright Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/home_bg.png',
                fit: BoxFit.cover,
              ),
            ),
            
            // Light Overlay to make it less gloomy and ensure text readability
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withValues(alpha: 0.1),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.2),
                    ],
                  ),
                ),
              ),
            ),
            
            // Subtle blur for focus
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(color: Colors.transparent),
              ),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _HeaderLabel().animate().fadeIn().slideY(begin: -0.2),
                    const Spacer(),
                    
                    // Bento Grid - Adjusted for Right Hand Ergonomics
                    SizedBox(
                      height: 380,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Left Side: Column with Address and Settings (Equal Sizes)
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Expanded(
                                  child: _BentoTile(
                                    label: 'ADRESY',
                                    icon: Icons.map_outlined,
                                    color: Colors.white.withValues(alpha: 0.15),
                                    onTap: () {
                                      HapticFeedback.selectionClick();
                                      _showStub(context, 'Baza adresów');
                                    },
                                  ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
                                ),
                                const SizedBox(height: 16),
                                Expanded(
                                  child: _BentoTile(
                                    label: 'USTAWIENIA',
                                    icon: Icons.settings_outlined,
                                    color: Colors.white.withValues(alpha: 0.15),
                                    onTap: () {
                                      HapticFeedback.selectionClick();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (_) => const ProfileScreen()),
                                      );
                                    },
                                  ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.2),
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(width: 16),
                          
                          // Right Side: Large JEDZIEMY Button
                          Expanded(
                            flex: 1,
                            child: _BentoTile(
                              label: 'JEDZIEMY',
                              icon: Icons.navigation_rounded,
                              color: const Color(0xFFC6FF00).withValues(alpha: 0.65),
                              iconColor: Colors.black,
                              isLarge: true,
                              onTap: () {
                                HapticFeedback.heavyImpact();
                                _showStub(context, 'Gdzie jedziemy?');
                              },
                            ).animate().fadeIn(delay: 100.ms).scale(begin: const Offset(0.9, 0.9)),
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
          ],
        ),
      ),
    );
  }

  void _showStub(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: Colors.black,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

class _HeaderLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: AssetImage('assets/images/icon/icon.png'),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'EASY',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),
            Text(
              'NAVI',
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: -2,
                color: Colors.black,
              ),
            ),
          ],
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

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.4),
            width: 1.5,
          ),
          boxShadow: [
            if (!_isPressed)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Column(
              mainAxisAlignment: widget.isLarge ? MainAxisAlignment.center : MainAxisAlignment.start,
              crossAxisAlignment: widget.isLarge ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                if (!widget.isLarge) const SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.all(widget.isLarge ? 0 : 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(widget.isLarge ? 20 : 12),
                        decoration: BoxDecoration(
                          color: (widget.iconColor ?? textColor).withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.icon,
                          size: widget.isLarge ? 56 : 28,
                          color: widget.iconColor ?? textColor,
                        ),
                      ),
                      if (widget.isLarge) const SizedBox(height: 24),
                      Text(
                        widget.label,
                        style: GoogleFonts.inter(
                          fontSize: widget.isLarge ? 20 : 13,
                          fontWeight: FontWeight.w900,
                          color: textColor,
                          letterSpacing: widget.isLarge ? 2 : 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.05),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
            ),
            child: const Icon(Icons.developer_mode, size: 16, color: Colors.black26),
          ),
        ),
      ],
    );
  }
}
