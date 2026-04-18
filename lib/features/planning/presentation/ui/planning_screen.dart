import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/di/injection.dart';
import '../../../../l10n/l10n.dart';
import '../../../addresses/data/models/address_model.dart';
import '../cubit/planning_cubit.dart';
import '../../../drive/ui/drive_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlanningScreen extends StatelessWidget {
  const PlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PlanningCubit>(),
      child: const PlanningView(),
    );
  }
}

class PlanningView extends StatefulWidget {
  const PlanningView({super.key});

  @override
  State<PlanningView> createState() => _PlanningViewState();
}

class _PlanningViewState extends State<PlanningView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          l10n.planningTitle.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<PlanningCubit, PlanningState>(
        builder: (context, state) {
          if (state is! Loaded) {
            return const Center(child: CircularProgressIndicator(color: Colors.black));
          }

          final addresses = state.allAddresses;
          final selectedIds = state.selectedAddressIds;

          return Stack(
            children: [
              // Background
              Positioned.fill(
                child: Container(
                  color: Colors.grey.shade50,
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    if (addresses.isEmpty)
                      const Expanded(child: _EmptyAddressesView())
                    else
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 150),
                          itemCount: addresses.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = addresses[index];
                            final isSelected = selectedIds.contains(item.id);
                            final selectionIndex = selectedIds.indexOf(item.id);

                            return _SelectionCard(
                              address: item,
                              isSelected: isSelected,
                              selectionIndex: selectionIndex != -1 ? selectionIndex + 1 : null,
                              onTap: () => context.read<PlanningCubit>().toggleSelection(item),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
              
              // Floating Action Button Area
              if (selectedIds.isNotEmpty)
                Positioned(
                  bottom: 32,
                  left: 24,
                  right: 24,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xFFC6FF00),
                          radius: 14,
                          child: Text(
                            '${selectedIds.length}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          l10n.addressesSelected.toUpperCase(),
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () => _showPlanningOptions(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC6FF00),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: Text(
                            l10n.planNow,
                            style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _showPlanningOptions(BuildContext context) {
    final planningCubit = context.read<PlanningCubit>();
    final l10n = context.l10n;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.planningModeTitle,
              style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _OptionTile(
              label: l10n.planningModeSequence,
              icon: Icons.format_list_numbered_rounded,
              onTap: () => _startPlanning(context, planningCubit, PlanningMode.sequence),
            ),
            const SizedBox(height: 12),
            _OptionTile(
              label: l10n.planningModeClosest,
              icon: Icons.near_me_rounded,
              onTap: () => _startPlanning(context, planningCubit, PlanningMode.closest),
            ),
            const SizedBox(height: 12),
            _OptionTile(
              label: l10n.planningModeFarthest,
              icon: Icons.explore_rounded,
              onTap: () => _startPlanning(context, planningCubit, PlanningMode.farthest),
            ),
          ],
        ),
      ),
    );
  }

  void _startPlanning(BuildContext context, PlanningCubit cubit, PlanningMode mode) async {
    Navigator.of(context).pop(); // Close sheet
    
    await cubit.planRoute(mode);
    
    if (context.mounted) {
      final state = cubit.state;
      if (state is Loaded && state.plannedAddresses.isNotEmpty) {
        _navigateToDrive(context, cubit);
      }
    }
  }

  void _navigateToDrive(BuildContext context, PlanningCubit planningCubit) {
    final state = planningCubit.state as Loaded;
    final currentAddress = state.plannedAddresses[state.currentIndex];
    
    if (currentAddress.latitude == null || currentAddress.longitude == null) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: planningCubit,
          child: DriveScreen(
            destination: LatLng(currentAddress.latitude!, currentAddress.longitude!),
            destinationName: currentAddress.name,
            onArrivedNext: () {
              planningCubit.nextDestination();
              final newState = planningCubit.state as Loaded;
              if (newState.currentIndex < newState.plannedAddresses.length) {
                // If the next destination is same as current (re-init), 
                // we might need to handle navigation stack.
                // Best is to pop and push or just replacement.
                Navigator.of(context).pop();
                _navigateToDrive(context, planningCubit);
              } else {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(context.l10n.routeFinished)),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class _SelectionCard extends StatelessWidget {
  const _SelectionCard({
    required this.address,
    required this.isSelected,
    this.selectionIndex,
    required this.onTap,
  });

  final AddressModel address;
  final bool isSelected;
  final int? selectionIndex;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFC6FF00).withValues(alpha: 0.1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFFC6FF00) : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFC6FF00) : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFFC6FF00) : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Text(
                        selectionIndex?.toString() ?? '',
                        style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w900),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  Text(
                    '${address.street}, ${address.city}',
                    style: GoogleFonts.inter(color: Colors.black54, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({required this.label, required this.icon, required this.onTap});
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black87),
            const SizedBox(width: 16),
            Text(
              label,
              style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 15),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right_rounded, color: Colors.black26),
          ],
        ),
      ),
    );
  }
}

class _EmptyAddressesView extends StatelessWidget {
  const _EmptyAddressesView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.map_outlined, size: 60, color: Colors.grey.shade200),
          const SizedBox(height: 20),
          Text(
            context.l10n.noAddressesFound,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
