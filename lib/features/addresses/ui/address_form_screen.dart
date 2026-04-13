import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/di/injection.dart';
import '../presentation/cubit/address_form_cubit.dart';
import '../presentation/cubit/maps_search_cubit.dart';
import '../data/models/address_model.dart';
import '../../../../l10n/l10n.dart';

class AddressFormScreen extends StatelessWidget {
  const AddressFormScreen({super.key, this.address});
  final AddressModel? address;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AddressFormCubit>()),
        BlocProvider(create: (context) => getIt<MapsSearchCubit>()),
      ],
      child: AddressFormView(address: address),
    );
  }
}

class AddressFormView extends StatefulWidget {
  const AddressFormView({super.key, this.address});
  final AddressModel? address;

  @override
  State<AddressFormView> createState() => _AddressFormViewState();
}

class _AddressFormViewState extends State<AddressFormView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _streetController;
  late final TextEditingController _cityController;
  late final TextEditingController _zipController;
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.address?.name);
    _streetController = TextEditingController(text: widget.address?.street);
    _cityController = TextEditingController(text: widget.address?.city);
    _zipController = TextEditingController(text: widget.address?.zipCode);
    _latitude = widget.address?.latitude;
    _longitude = widget.address?.longitude;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AddressFormCubit>().saveAddress(
            name: _nameController.text,
            street: _streetController.text,
            city: _cityController.text,
            zipCode: _zipController.text,
            latitude: _latitude,
            longitude: _longitude,
            id: widget.address?.id,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddressFormCubit, AddressFormState>(
          listener: (context, state) {
            if (state is Success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.l10n.profileSavedSnackbar), backgroundColor: Colors.green),
              );
              Navigator.of(context).pop();
            }
          },
        ),
        BlocListener<MapsSearchCubit, MapsSearchState>(
          listener: (context, state) {
            if (state is Selected) {
              setState(() {
                _streetController.text = state.details['street'] ?? '';
                _cityController.text = state.details['city'] ?? '';
                _zipController.text = state.details['zipCode'] ?? '';
                _latitude = double.tryParse(state.details['latitude'] ?? '');
                _longitude = double.tryParse(state.details['longitude'] ?? '');
              });
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            (widget.address == null ? context.l10n.addressesTitle : context.l10n.editLabel).toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.close_rounded, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BlocBuilder<AddressFormCubit, AddressFormState>(
          builder: (context, state) {
            final isLoading = state is Loading;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(context.l10n.nameField.toUpperCase()),
                    _buildTextField(
                      controller: _nameController,
                      hint: '...',
                      enabled: !isLoading,
                      validator: (val) => val?.isEmpty ?? true ? context.l10n.errorUnknown : null,
                    ),
                    const SizedBox(height: 24),
                    _buildFieldLabel(context.l10n.streetField.toUpperCase()),
                    _buildTextField(
                      controller: _streetController,
                      hint: context.l10n.searchAddressesHint,
                      enabled: !isLoading,
                      onChanged: (val) => context.read<MapsSearchCubit>().onInputChanged(val),
                      validator: (val) => val?.isEmpty ?? true ? context.l10n.errorUnknown : null,
                    ),
                    
                    // Suggestions List
                    BlocBuilder<MapsSearchCubit, MapsSearchState>(
                      builder: (context, mapsState) {
                        if (mapsState is LoadingPredictions) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: LinearProgressIndicator(color: Colors.black, minHeight: 1),
                          );
                        }
                        if (mapsState is LoadedPredictions) {
                          return Container(
                            margin: const EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9F9F9),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: mapsState.predictions.length,
                              separatorBuilder: (context, index) => const Divider(height: 1, indent: 20, endIndent: 20),
                              itemBuilder: (context, index) {
                                final p = mapsState.predictions[index];
                                return ListTile(
                                  title: Text(
                                    p.description,
                                    style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
                                  ),
                                  onTap: () => context.read<MapsSearchCubit>().selectPrediction(p),
                                );
                              },
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFieldLabel(context.l10n.cityField.toUpperCase()),
                              _buildTextField(
                                controller: _cityController,
                                hint: '...',
                                enabled: !isLoading,
                                validator: (val) => val?.isEmpty ?? true ? context.l10n.errorUnknown : null,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFieldLabel(context.l10n.zipCodeField.toUpperCase()),
                              _buildTextField(
                                controller: _zipController,
                                hint: '...',
                                enabled: !isLoading,
                                validator: (val) => val?.isEmpty ?? true ? context.l10n.errorUnknown : null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    if (state is Error)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          state.errorKey,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    SizedBox(
                      width: double.infinity,
                      height: 64,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _onSave,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                context.l10n.saveAddressButton.toUpperCase(),
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: Colors.grey.shade400,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required bool enabled,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      validator: validator,
      onChanged: onChanged,
      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade300, fontWeight: FontWeight.w400),
        filled: true,
        fillColor: const Color(0xFFF9F9F9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(20),
      ),
    );
  }
}
