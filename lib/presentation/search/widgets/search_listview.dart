import 'package:doctor_plus/presentation/search/widgets/search_listview_tile.dart';
import 'package:flutter/material.dart';

class SearchListview extends StatelessWidget {
  const SearchListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: ListView(
          children: const [
            SearchListviewTile(),
            SearchListviewTile(),
            SearchListviewTile(),
            SearchListviewTile(),
            SearchListviewTile(),
          ],
        ),
      ),
    );
  }
}
