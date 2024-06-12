// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';

class SearchStudentBar extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.clear));
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return GooglePoppinsWidgets(
                  text: 'Edwin', fontsize: 18, fontWeight: FontWeight.w600);
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: 12),
      ),
    );
  }
}
