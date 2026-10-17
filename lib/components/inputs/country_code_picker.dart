import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../../core/resources/app_colors.dart';
import '../../core/resources/app_spacing.dart';
import '../../l10n/app_localizations.dart';
import '../app_text.dart';
import 'app_text_field.dart';

/// Custom searchable calling-code selector. Defaults to Saudi Arabia (+966).
class CountryCodePicker extends StatefulWidget {
  const CountryCodePicker({
    super.key,
    this.initialCountryCode = 'SA',
    required this.onChanged,
    this.width,
  });

  final String initialCountryCode;
  final ValueChanged<Country> onChanged;
  final double? width;

  @override
  State<CountryCodePicker> createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  late Country _selectedCountry = _findInitialCountry();

  @override
  void didUpdateWidget(covariant CountryCodePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialCountryCode != widget.initialCountryCode) {
      _selectedCountry = _findInitialCountry();
    }
  }

  Country _findInitialCountry() {
    return countryCallingCodes.firstWhere(
      (country) =>
          country.countryCode.toUpperCase() ==
          widget.initialCountryCode.toUpperCase(),
      orElse: () => countryCallingCodes.firstWhere(
        (country) => country.countryCode == 'SA',
      ),
    );
  }

  Future<void> _showCountryPicker() async {
    final selected = await showModalBottomSheet<Country>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.appColors.surface.bg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _CountryPickerSheet(
        selectedCountry: _selectedCountry,
      ),
    );

    if (selected == null || !mounted) return;
    setState(() => _selectedCountry = selected);
    widget.onChanged(selected);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final selectedCountryName =
        _selectedCountry.getTranslatedName(context) ?? _selectedCountry.name;
    return Semantics(
      button: true,
      label: '$selectedCountryName, +${_selectedCountry.phoneCode}',
      child: Material(
        color: colors.surface.primary,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: _showCountryPicker,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: widget.width,
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.tokenS),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colors.border.actionOutline),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _selectedCountry.flagEmoji,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(width: AppSpacing.tokenXs),
                Flexible(
                  child: AppText(
                    '+${_selectedCountry.phoneCode}',
                    variant: AppTextVariant.bodySmall,
                    style: TextStyle(color: colors.text.heading),
                    textDirection: TextDirection.ltr,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
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

class _CountryPickerSheet extends StatefulWidget {
  const _CountryPickerSheet({required this.selectedCountry});

  final Country selectedCountry;

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final normalizedQuery = _toAsciiDigits(
      _query.trim().toLowerCase().replaceAll('+', ''),
    );
    final results = countryCallingCodes.where((country) {
      final localizedName = country.getTranslatedName(context) ?? country.name;
      return country.name.toLowerCase().contains(normalizedQuery) ||
          localizedName.toLowerCase().contains(normalizedQuery) ||
          country.countryCode.toLowerCase().contains(normalizedQuery) ||
          country.phoneCode.contains(normalizedQuery);
    }).toList(growable: false);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.buyerMobileHorizontalPadding,
          right: AppSpacing.buyerMobileHorizontalPadding,
          top: AppSpacing.tokenL,
          bottom: MediaQuery.viewInsetsOf(context).bottom + AppSpacing.tokenM,
        ),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.72,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppText.localized(
                (l10n) => l10n.countryPickerTitle,
                variant: AppTextVariant.titleMedium,
                style: TextStyle(color: colors.text.heading),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: AppSpacing.tokenM),
              AppTextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value),
                textInputAction: TextInputAction.search,
                hintText: AppLocalizations.of(context)?.countryPickerSearchHint,
                prefixIcon: Icon(Icons.search, color: colors.icon.secondary),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: AppSpacing.tokenS),
              Expanded(
                child: results.isEmpty
                    ? Center(
                        child: AppText.localized(
                          (l10n) => l10n.countryPickerEmpty,
                          variant: AppTextVariant.bodyMedium,
                          style: TextStyle(color: colors.text.caption),
                        ),
                      )
                    : ListView.separated(
                        itemCount: results.length,
                        separatorBuilder: (_, __) => Divider(
                          height: 1,
                          color: colors.border.actionOutline,
                        ),
                        itemBuilder: (context, index) {
                          final country = results[index];
                          final countryName =
                              country.getTranslatedName(context) ??
                                  country.name;
                          final isSelected = country.countryCode ==
                              widget.selectedCountry.countryCode;
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Text(
                              country.flagEmoji,
                              style: const TextStyle(fontSize: 22),
                            ),
                            title: AppText(
                              countryName,
                              variant: AppTextVariant.bodyMedium,
                              style: TextStyle(color: colors.text.heading),
                              textAlign: TextAlign.start,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppText(
                                  '+${country.phoneCode}',
                                  variant: AppTextVariant.bodyMedium,
                                  style: TextStyle(
                                    color: isSelected
                                        ? colors.text.action
                                        : colors.text.caption,
                                  ),
                                  textDirection: TextDirection.ltr,
                                ),
                                if (isSelected) ...[
                                  const SizedBox(width: AppSpacing.tokenXs),
                                  Icon(
                                    Icons.check_circle,
                                    color: colors.text.action,
                                    size: 19,
                                  ),
                                ],
                              ],
                            ),
                            onTap: () => Navigator.of(context).pop(country),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _toAsciiDigits(String value) {
    return String.fromCharCodes(
      value.runes.map((rune) {
        if (rune >= 0x0660 && rune <= 0x0669) return rune - 0x0660 + 0x30;
        if (rune >= 0x06F0 && rune <= 0x06F9) return rune - 0x06F0 + 0x30;
        return rune;
      }),
    );
  }
}

/// Package-backed country/territory metadata, deduplicated by ISO code while
/// retaining shared calling codes as separate country choices.
final List<Country> countryCallingCodes = _loadCountryCallingCodes();

List<Country> _loadCountryCallingCodes() {
  final byIsoCode = <String, Country>{};
  for (final country in CountryService().getAll()) {
    if (country.geographic) {
      byIsoCode.putIfAbsent(country.countryCode, () => country);
    }
  }
  final countries = byIsoCode.values.toList()
    ..sort((first, second) => first.name.compareTo(second.name));
  return List<Country>.unmodifiable(countries);
}
