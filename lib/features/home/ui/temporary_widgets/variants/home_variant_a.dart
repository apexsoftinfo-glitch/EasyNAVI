import 'package:flutter/material.dart';

import '../../../../../app/developer/ui/developer_screen.dart';
import '../../../../../features/profiles/presentation/ui/profile_screen.dart';

class HomeVariantAScreen extends StatelessWidget {
  const HomeVariantAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('EasyNAVI', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Spacer(),
            _MenuButton(
              label: 'JEDZIEMY',
              icon: Icons.navigation_rounded,
              color: Colors.blue[700]!,
              onTap: () => _showAddressSelection(context),
            ),
            const SizedBox(height: 20),
            _MenuButton(
              label: 'ADRESY',
              icon: Icons.map_rounded,
              color: Colors.green[600]!,
              onTap: () => _showAddressManagement(context),
            ),
            const SizedBox(height: 20),
            _MenuButton(
              label: 'USTAWIENIA',
              icon: Icons.settings_rounded,
              color: Colors.grey[700]!,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              ),
            ),
            const Spacer(),
            // Small dev link for convenience
            TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DeveloperScreen()),
              ),
              child: const Text('Narzędzia deweloperskie', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddressSelection(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Wybierz cel podróży',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.separated(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 5,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final labels = ['Dom', 'Biuro', 'Klient: Kowalski', 'Magazyn', 'Serwis'];
                  return ListTile(
                    leading: const Icon(Icons.location_on, color: Colors.blue),
                    title: Text(labels[index]),
                    subtitle: Text('ul. Przykładowa ${index + 1}, Warszawa'),
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Uruchamiam nawigację do: ${labels[index]}')),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddressManagement(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Baza Adresów')),
          body: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final labels = ['Dom', 'Biuro', 'Klient: Kowalski', 'Magazyn', 'Serwis'];
              return Card(
                child: ListTile(
                  title: Text(labels[index]),
                  subtitle: const Text('ul. Przykładowa 123'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () {}),
                      IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () {}),
                    ],
                  ),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({
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
  Widget build(BuildContext context) {
    return _SquishEffect(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: color.withValues(alpha: 0.1), width: 2),
        ),
        child: Row(
          children: [
            const SizedBox(width: 24),
            Icon(icon, size: 40, color: color),
            const SizedBox(width: 24),
            Text(
              label,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: color,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SquishEffect extends StatefulWidget {
  const _SquishEffect({required this.child, required this.onTap});
  final Widget child;
  final VoidCallback onTap;

  @override
  State<_SquishEffect> createState() => _SquishEffectState();
}

class _SquishEffectState extends State<_SquishEffect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.94,
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
        child: widget.child,
      ),
    );
  }
}
