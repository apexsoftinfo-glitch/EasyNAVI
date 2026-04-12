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

class AddressesView extends StatelessWidget {
  const AddressesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        title: Text(
          'Twoje Adresy'.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 14,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddressForm(context),
        backgroundColor: Colors.black,
        icon: const Icon(Icons.add_rounded, color: Color(0xFFC6FF00)),
        label: Text(
          'DODAJ ADRES',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<AddressesCubit, AddressesState>(
        builder: (context, state) {
          return switch (state) {
            Initial() || Loading() => const Center(
                child: CircularProgressIndicator(color: Colors.black),
              ),
            Error(errorKey: final key) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(key),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<AddressesCubit>().retry(),
                      child: const Text('Ponów'),
                    ),
                  ],
                ),
              ),
            Loaded(addresses: final addresses) => addresses.isEmpty
                ? const _EmptyView()
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                    itemCount: addresses.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = addresses[index];
                      return Dismissible(
                        key: Key(item.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(20),
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
          };
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
      // Show loading indicator
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
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFC6FF00).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.location_on_rounded, color: Colors.black, size: 20),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${address.street}, ${address.city}',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit_outlined, size: 20, color: Colors.grey.shade400),
              onPressed: onEdit,
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey.shade300),
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
            'Brak zapisanych adresów',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Dodaj swój pierwszy stały punkt',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
