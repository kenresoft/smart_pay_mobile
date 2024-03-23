import 'package:country_icons/country_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iso_countries/iso_countries.dart';
import 'package:smart_pay_mobile/utils/constants.dart';

import '../services/prefs.dart';

class CountryInfo {
  final String code;
  final String name;

  const CountryInfo(this.code, this.name);
}

class CountryConstants {
  static Future<List<CountryInfo>> getAllCountries() async {
    final List<CountryInfo> countries = [];
    final isoCountries = await IsoCountries.isoCountries;

    for (var element in isoCountries) {
      countries.add(CountryInfo(element.countryCode, element.name));
    }

    return countries;
  }
}

class CountrySelectionBottomSheet extends StatefulWidget {
  final Function(CountryInfo) onCountrySelected;

  const CountrySelectionBottomSheet({super.key, required this.onCountrySelected});

  @override
  State<CountrySelectionBottomSheet> createState() => _CountrySelectionBottomSheetState();
}

class _CountrySelectionBottomSheetState extends State<CountrySelectionBottomSheet> {
  late Future<List<CountryInfo>> countriesFuture;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    countriesFuture = CountryConstants.getAllCountries();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.038, bottom: height * 0.030),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.684,
                    height: height * 0.067,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF9FAFB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(CupertinoIcons.search, size: 24),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 19,
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.30,
                        ),
                      ),
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 21,
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.30,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.onCountrySelected(const CountryInfo('', ''));
                      country = Constants.empty;
                      countryCode = Constants.empty;
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 19,
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.30,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<CountryInfo>>(
                future: countriesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching countries'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No countries found'));
                  } else {
                    final countries = snapshot.data!;
                    return ListView.builder(
                      itemCount: countries.length,
                      itemBuilder: (context, index) {
                        final country = countries[index];
                        return GestureDetector(
                          onTap: () {
                            widget.onCountrySelected(country);
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 64,
                            margin: const EdgeInsets.all(4),
                            decoration: ShapeDecoration(
                              color: country.code == countryCode ? const Color(0xFFF9FAFB) : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 24,
                                      margin: const EdgeInsets.symmetric(horizontal: 16),
                                      child: CountryIcons.getSvgFlag(country.code),
                                    ),
                                    Text(
                                      country.code,
                                      style: const TextStyle(
                                        color: Color(0xFF6B7280),
                                        fontSize: 16,
                                        fontFamily: 'SFProDisplay',
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.30,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      country.name,
                                      style: const TextStyle(
                                        color: Color(0xFF111827),
                                        fontSize: 16,
                                        fontFamily: 'SFProDisplay',
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.30,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: country.code == countryCode
                                      ? const Icon(
                                          CupertinoIcons.check_mark,
                                          color: Color(0xff2FA2B9),
                                          size: 20,
                                        )
                                      : const SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
