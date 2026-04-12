import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../app/developer/ui/developer_screen.dart';
import '../../../../../features/profiles/presentation/ui/profile_screen.dart';
import '../../../../../l10n/l10n.dart';

class HomeVariantAScreen extends StatelessWidget {
  const HomeVariantAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recentPoints = [
      _AddressPoint(name: 'Dom', address: 'ul. Sezamkowa 1, Warszawa', icon: Icons.home),
      _AddressPoint(name: 'Biuro', address: 'ul. Domaniewska 44, Warszawa', icon: Icons.work),
    ];

    final allPoints = [
      _AddressPoint(name: 'Serwis Klimatyzacji', address: 'ul. Poznańska 12, Warszawa', icon: Icons.build),
      _AddressPoint(name: 'Klient: Jan Kowalski', address: 'ul. Wiejska 3, Konstancin', icon: Icons.person),
      _AddressPoint(name: 'Magazyn Centralny', address: 'ul. Przemysłowa 8, Piaseczno', icon: Icons.warehouse),
      _AddressPoint(name: 'Paczkomat WAW12', address: 'ul. Puławska 100, Warszawa', icon: Icons.local_post_office),
      _AddressPoint(name: 'Serwis Techniczny', address: 'ul. Postępu 1, Warszawa', icon: Icons.settings),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('EasyNAVI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Dodawanie adresu (Placeholder)')),
          );
        },
        child: const Icon(Icons.add_location_alt_outlined),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          const _SectionHeader(title: 'Ostatnio odwiedzane'),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: recentPoints.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) => _RecentCard(point: recentPoints[index]),
            ),
          ),
          const SizedBox(height: 24),
          const _SectionHeader(title: 'Twoje punkty'),
          const SizedBox(height: 12),
          ...allPoints.map((point) => _AddressTile(point: point)),
          if (kDebugMode) ...[
            const SizedBox(height: 32),
            Center(
              child: TextButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const DeveloperScreen()),
                ),
                icon: const Icon(Icons.developer_mode, size: 16),
                label: Text(context.l10n.developerToolsTitle),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

class _RecentCard extends StatelessWidget {
  const _RecentCard({required this.point});
  final _AddressPoint point;

  @override
  Widget build(BuildContext context) {
    return _SquishButton(
      onTap: () {},
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.shade100),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(point.icon, color: Colors.blue, size: 20),
            const SizedBox(height: 8),
            Text(
              point.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              point.address,
              style: TextStyle(fontSize: 11, color: Colors.blue.shade900),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressTile extends StatelessWidget {
  const _AddressTile({required this.point});
  final _AddressPoint point;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(point.name),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usunięto: ${point.name}')),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: CircleAvatar(
            backgroundColor: Colors.grey.shade100,
            child: Icon(point.icon, color: Colors.grey.shade700),
          ),
          title: Text(point.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(point.address),
          trailing: _SquishButton(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Uruchamiam nawigację do: ${point.name}'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'JEDŹ',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SquishButton extends StatefulWidget {
  const _SquishButton({required this.child, required this.onTap});
  final Widget child;
  final VoidCallback onTap;

  @override
  State<_SquishButton> createState() => _SquishButtonState();
}

class _SquishButtonState extends State<_SquishButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.92,
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

class _AddressPoint {
  _AddressPoint({required this.name, required this.address, required this.icon});
  final String name;
  final String address;
  final IconData icon;
}
