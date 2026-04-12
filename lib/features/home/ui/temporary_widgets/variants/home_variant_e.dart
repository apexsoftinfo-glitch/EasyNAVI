import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../app/developer/ui/developer_screen.dart';
import '../../../../../features/profiles/presentation/ui/profile_screen.dart';

class HomeVariantEScreen extends StatelessWidget {
  const HomeVariantEScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.outfitTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3F51B5),
          primary: const Color(0xFF3F51B5),
          secondary: const Color(0xFF03A9F4),
        ),
      ),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Stack(
              children: [
                // Mesh Gradient Background
                const _MeshBackground(),
                
                // Content
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          'EasyNAVI',
                          style: GoogleFonts.outfit(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF1A237E),
                            letterSpacing: -1,
                          ),
                        ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
                        const Spacer(),
                        _GlassButton(
                          label: 'JEDZIEMY',
                          icon: Icons.navigation_rounded,
                          color: const Color(0xFF3F51B5),
                          onTap: () {
                            HapticFeedback.lightImpact();
                            _showStub(context, 'Starting route...');
                          },
                        ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2, curve: Curves.easeOutCubic),
                        const SizedBox(height: 20),
                        _GlassButton(
                          label: 'ADRESY',
                          icon: Icons.map_rounded,
                          color: const Color(0xFF43A047),
                          onTap: () {
                            HapticFeedback.lightImpact();
                            _showStub(context, 'Address base');
                          },
                        ).animate().fadeIn(delay: 350.ms).slideX(begin: -0.2, curve: Curves.easeOutCubic),
                        const SizedBox(height: 20),
                        _GlassButton(
                          label: 'USTAWIENIA',
                          icon: Icons.settings_rounded,
                          color: const Color(0xFF455A64),
                          onTap: () {
                            HapticFeedback.lightImpact();
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const ProfileScreen()),
                            );
                          },
                        ).animate().fadeIn(delay: 500.ms).slideX(begin: -0.2, curve: Curves.easeOutCubic),
                        const Spacer(),
                        _ProfileAvatar().animate().fadeIn(delay: 700.ms).scale(),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const DeveloperScreen()),
                          ),
                          child: Text(
                            'Developer Portal',
                            style: TextStyle(color: Colors.blueGrey.shade300, fontSize: 13),
                          ),
                        ).animate().fadeIn(delay: 800.ms),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showStub(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
        backgroundColor: const Color(0xFF3F51B5).withValues(alpha: 0.9),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class _MeshBackground extends StatelessWidget {
  const _MeshBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: const Color(0xFFF5F7FF)),
        Positioned(
          top: -100,
          right: -100,
          child: _BlurCircle(color: Colors.blue.withValues(alpha: 0.2), size: 300),
        ),
        Positioned(
          bottom: -50,
          left: -50,
          child: _BlurCircle(color: Colors.indigo.withValues(alpha: 0.15), size: 250),
        ),
        Positioned(
          top: 200,
          left: -100,
          child: _BlurCircle(color: Colors.lightBlue.withValues(alpha: 0.1), size: 200),
        ),
      ],
    );
  }
}

class _BlurCircle extends StatelessWidget {
  const _BlurCircle({required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(color: Colors.transparent),
      ),
    );
  }
}

class _GlassButton extends StatefulWidget {
  const _GlassButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  State<_GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<_GlassButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
whenever: this,
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.96,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.reverse(),
      onTapUp: (_) {
        _controller.forward();
        widget.onTap();
      },
      onTapCancel: () => _controller.forward(),
      child: ScaleTransition(
        scale: _controller,
        child: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: 0.12),
                offset: const Offset(0, 12),
                blurRadius: 24,
                spreadRadius: -4,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: widget.color.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(widget.icon, color: widget.color, size: 28),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      widget.label,
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: widget.color.withValues(alpha: 0.8),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded, size: 16, color: widget.color.withValues(alpha: 0.3)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const CircleAvatar(
        radius: 30,
        backgroundColor: Color(0xFFE3F2FD),
        child: Icon(Icons.person_rounded, size: 30, color: Color(0xFF3F51B5)),
      ),
    );
  }
}
