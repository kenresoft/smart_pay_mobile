import 'package:flutter/material.dart';

class CountrySelectionBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 617,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Select a Country',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Country 1'),
                  onTap: () {
                    // Handle country selection
                    Navigator.pop(context, 'Country 1');
                  },
                ),
                ListTile(
                  title: const Text('Country 2'),
                  onTap: () {
                    // Handle country selection
                    Navigator.pop(context, 'Country 2');
                  },
                ),
                // Add more countries as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}