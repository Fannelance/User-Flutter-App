import 'package:fannelance/core/constants.dart';
import 'package:fannelance/widgets/service_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:fannelance/models/services_model.dart';
import 'package:searchfield/searchfield.dart';

class SearchWidget extends StatefulWidget {
  final List<ServicesModel> servicesList;

  const SearchWidget({
    Key? key,
    required this.servicesList,
  }) : super(key: key);

  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  final focus = FocusNode();

  // History method
  final List<String> emptyList = [''];

  List<ServicesModel> searchHistoryList = [];

  void _addToSearchHistoryList(ServicesModel e) {
    setState(() {
      if (!searchHistoryList.contains(e)) {
        searchHistoryList.insert(0, e);
      }
    });
  }

  void _removeFromSearchHistoryList(ServicesModel e) {
    setState(() {
      searchHistoryList.remove(e);
    });
  }

  List<SearchFieldListItem<ServicesModel>> _getSearchHistoryList() {
    if (searchHistoryList.isEmpty) {
      return emptyList
          .map((e) => SearchFieldListItem<ServicesModel>(
                '',
                child: const EmptySearchWidget(),
              ),)
          .toList();
    } else {
      return searchHistoryList
          .map((e) => SearchFieldListItem<ServicesModel>(
                '',
                item: e,
                child: Row(
                  children: [
                    Expanded(
                      child: ServiceSearchWidget(
                        obj: e,
                        addToSearchHistoryList: _addToSearchHistoryList,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _removeFromSearchHistoryList(e);
                      },
                      icon: const Icon(
                        Icons.clear,
                      ),
                    ),
                  ],
                ),
              ))
          .toList();
    }
  }

  //search method
  List<ServicesModel> _getServicesList() {
    return widget.servicesList;
  }

  List<SearchFieldListItem<ServicesModel>> _onSearchTextChanged(String query) {
    final filter = _getServicesList()
        .where((element) =>
            element.serviceName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (query.isNotEmpty) {
      return filter
          .map((e) => SearchFieldListItem<ServicesModel>(
                '',
                item: e,
                child: ServiceSearchWidget(
                  obj: e,
                  addToSearchHistoryList: _addToSearchHistoryList,
                ),
              ))
          .toList();
    } else {
      return _getSearchHistoryList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenWidth / 7,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SearchField(
          //suggestions list
          suggestions: _getSearchHistoryList(),
          itemHeight: screenWidth / 5.5,
          maxSuggestionsInViewPort: 4,
          suggestionsDecoration: SuggestionDecoration(
            border: Border.all(color: grey9, width: 0.8),
            borderRadius: border10,
          ),

          //search field
          onSearchTextChanged: _onSearchTextChanged,
          hint: 'Search Services',
          searchStyle: TextStyle(fontSize: screenWidth / 20),
          searchInputDecoration: InputDecoration(
            hintStyle: TextStyle(
              fontSize: screenWidth / 22,
              color: grey9,
            ),
            fillColor: greyE8,
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
