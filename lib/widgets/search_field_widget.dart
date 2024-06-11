import 'package:fannelance/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class SearchFieldWidget extends StatelessWidget {
  final List<SearchFieldListItem<dynamic>> getSearchHistoryList;
  final List<SearchFieldListItem<dynamic>>? Function(String)?
      onSearchTextChanged;
  const SearchFieldWidget({
    super.key,
    required this.getSearchHistoryList,
    required this.onSearchTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final focus = FocusNode();

    return SizedBox(
      height: screenWidth / 7,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SearchField(
          //suggestions list
          suggestions: getSearchHistoryList,
          itemHeight: screenWidth / 5.5,
          maxSuggestionsInViewPort: 4,
          suggestionsDecoration: SuggestionDecoration(
            border: Border.all(color: kGrey9, width: 0.8),
            borderRadius: kBorder10,
          ),

          //search field
          onSearchTextChanged: onSearchTextChanged,
          hint: 'Search Services',
          searchStyle: TextStyle(fontSize: screenWidth / 24),
          searchInputDecoration: InputDecoration(
            hintStyle: TextStyle(
              fontSize: screenWidth / 24,
              color: kGrey9,
            ),
            fillColor: kGreyE8,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            prefixIcon: const Icon(Icons.search),
            focusedBorder: searchFieldBorder,
            enabledBorder: searchFieldBorder,
          ),

          focusNode: focus,
          onTapOutside: (pointer) {
            focus.unfocus();
          },
        ),
      ),
    );
  }
}
