import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/di/injection.dart';
import '../presentation/cubit/addresses_cubit.dart';
import 'address_form_screen.dart';
import '../data/models/address_model.dart';
import '../../drive/ui/drive_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddressesCubit>(),
      child: const AddressesView(),
    );
  }
}

class AddressesView extends StatefulWidget {
  const AddressesView({super.key});

  @override
  State<AddressesView> createState() => _AddressesViewState();
}

class _AddressesViewState extends State<AddressesView> {
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();

  void _onMapCreated(GoogleMapController controller, List<AddressModel> addresses) {
    _mapController = controller;
    _fitBounds(addresses);
  }

  void _fitBounds(List<AddressModel> addresses) {
    if (_mapController == null || addresses.isEmpty) return;

    final validAddresses = addresses.where((a) => a.latitude != null && a.longitude != null).toList();
    if (validAddresses.isEmpty) return;

    double? minLat, maxLat, minLon, maxLon;

    for (final adr in validAddresses) {
      if (minLat == null || adr.latitude! < minLat) minLat = adr.latitude;
      if (maxLat == null || adr.latitude! > maxLat) maxLat = adr.latitude;
      if (minLon == null || adr.longitude! < minLon) minLon = adr.longitude;
      if (maxLon == null || adr.longitude! > maxLon) maxLon = adr.longitude;
    }

    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat!, minLon!),
          northeast: LatLng(maxLat!, maxLon!),
        ),
        100,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Adresy'.toUpperCase(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddressForm(context),
        backgroundColor: Colors.black,
        child: const Icon(Icons.add_rounded, color: Color(0xFFC6FF00)),
      ),
      body: BlocBuilder<AddressesCubit, AddressesState>(
        builder: (context, state) {
          if (state is! Loaded) {
            return const Center(child: CircularProgressIndicator(color: Colors.black));
          }

          final addresses = state.addresses;
          final filtered = addresses.where((a) {
            final q = state.searchQuery.toLowerCase();
            return a.name.toLowerCase().contains(q) || a.street.toLowerCase().contains(q) || a.city.toLowerCase().contains(q);
          }).toList();

          return Stack(
            children: [
              // 1. Map Background
              Positioned.fill(
                child: GoogleMap(
                  onMapCreated: (c) => _onMapCreated(c, addresses),
                  initialCameraPosition: const CameraPosition(target: LatLng(52.2297, 21.0122), zoom: 6),
                  markers: addresses
                      .where((a) => a.latitude != null && a.longitude != null)
                      .map((a) => Marker(
                            markerId: MarkerId(a.id),
                            position: LatLng(a.latitude!, a.longitude!),
                            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                          ))
                      .toSet(),
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                ),
              ),
              // 2. Dark/Blur Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0.8),
                        Colors.white.withValues(alpha: 0.95),
                      ],
                    ),
                  ),
                ),
              ),
              // 3. Content
              SafeArea(
                child: Column(
                  children: [
                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 4)),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (val) => context.read<AddressesCubit>().setSearchQuery(val),
                          decoration: InputDecoration(
                            hintText: 'Szukaj adresu...',
                            hintStyle: GoogleFonts.inter(fontSize: 14, color: Colors.grey.shade400),
                            prefixIcon: const Icon(Icons.search_rounded, color: Colors.black54),
                            suffixIcon: state.searchQuery.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.close_rounded, size: 18),
                                    onPressed: () {
                                      _searchController.clear();
                                      context.read<AddressesCubit>().setSearchQuery('');
                                    },
                                  )
                                : null,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: filtered.isEmpty
                          ? const _EmptyView()
                          : ListView.separated(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
                              itemCount: filtered.length,
                              separatorBuilder: (_, context) => const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                final item = filtered[index];
                                return Dismissible(
                                  key: Key(item.id),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade100,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Icon(Icons.delete_outline_rounded, color: Colors.red),
                                  ),
                                  onDismissed: (_) {
                                    context.read<AddressesCubit>().deleteAddress(item.id);
                                  },
                                  child: _AddressCard(
                                    address: item,
                                    onTap: () => _openDriveView(context, item),
                                    onEdit: () => _openAddressForm(context, address: item),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _openAddressForm(BuildContext context, {AddressModel? address}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddressFormScreen(address: address),
      ),
    );
  }

  Future<void> _openDriveView(BuildContext context, AddressModel address) async {
    AddressModel? resolved = address;

    if (address.latitude == null || address.longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pobieranie lokalizacji adresu...'), duration: Duration(seconds: 1)),
      );

      resolved = await context.read<AddressesCubit>().resolveCoordinates(address);
    }

    final finalAddress = resolved;
    if (finalAddress == null || finalAddress.latitude == null || finalAddress.longitude == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nie udało się znaleźć lokalizacji dla tego adresu. Edytuj go ręcznie.')),
        );
      }
      return;
    }

    if (context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => DriveScreen(
            destination: LatLng(finalAddress.latitude!, finalAddress.longitude!),
            destinationName: finalAddress.name,
          ),
        ),
      );
    }
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({required this.address, required this.onTap, required this.onEdit});
  final AddressModel address;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onEdit, // Edit on long press for cleaner UI
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade100),
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
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFC6FF00).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.location_on_rounded, color: Colors.black, size: 16),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${address.street}, ${address.city}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.edit_outlined, size: 18, color: Colors.grey.shade400),
              onPressed: onEdit,
              visualDensity: VisualDensity.compact,
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.map_outlined, size: 60, color: Colors.grey.shade200),
          const SizedBox(height: 20),
          Text(
            'Brak szukanych adresów',
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
