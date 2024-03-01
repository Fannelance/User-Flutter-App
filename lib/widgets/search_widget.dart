import 'package:fannelance/views/workers_view.dart';
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

  final List<String> emptyList = [''];
  
  List<String> _getEmptyList() {
    return emptyList;
  }

  List<ServicesModel> _getServicesList() {
    return widget.servicesList;
  }

  //search method
  List<SearchFieldListItem<ServicesModel>> _onSearchTextChanged(String query) {
    final filter = _getServicesList()
        .where((element) =>
            element.serviceName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return filter
        .map((e) => SearchFieldListItem<ServicesModel>(
              e.serviceName,
              child: ServiceSearchWidget(obj: e),
            ))
        .toList();
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
          suggestions: _getEmptyList()
              .map((e) => SearchFieldListItem<ServicesModel>(''))
              .toList(),
          onSuggestionTap: (SearchFieldListItem<ServicesModel> item) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WorkersView()),
            );
          },
          itemHeight: screenWidth / 6.5,
          maxSuggestionsInViewPort: 4,
          suggestionsDecoration: SuggestionDecoration(
            border: Border.all(color: const Color(0xff999999), width: 0.5),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),

          //search field
          onSearchTextChanged: _onSearchTextChanged,
          hint: 'Search Services',
          searchStyle: TextStyle(fontSize: screenWidth / 20),
          searchInputDecoration: InputDecoration(
            hintStyle: TextStyle(
              fontSize: screenWidth / 22,
              color: const Color(0xff999999),
            ),
            fillColor: const Color(0xffE8E8E8),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            prefixIcon: const Icon(Icons.search),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xff999999),
                width: 0.2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xff999999),
                width: 0.2,
              ),
            ),
          ),

          focusNode: focus,
          onTapOutside: (pointer) {
            focus.unfocus();
          },
          // key: const Key('searchfield'),
        ),
      ),
    );
  }
}
