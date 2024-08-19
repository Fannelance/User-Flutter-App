import 'package:fannelance/widgets/search_empty_widget.dart';
import 'package:fannelance/widgets/search_field_widget.dart';
import 'package:fannelance/widgets/search_service_widget.dart';
import 'package:flutter/material.dart';
import 'package:fannelance/models/services_model.dart';
import 'package:searchfield/searchfield.dart';

class SearchWidget extends StatefulWidget {
  final Function(int) onNavigate;

  final List<ServicesModel> servicesList;

  const SearchWidget({
    Key? key,
    required this.servicesList,
    required this.onNavigate,
  }) : super(key: key);

  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  // History method
  final List<String> emptyList = [''];

  List<ServicesModel> searchHistoryList = [];

  void addToSearchHistoryList(ServicesModel e) {
    setState(() {
      if (!searchHistoryList.contains(e)) {
        searchHistoryList.insert(0, e);
      }
    });
  }

  void removeFromSearchHistoryList(ServicesModel e) {
    setState(() {
      searchHistoryList.remove(e);
    });
  }

  List<SearchFieldListItem<ServicesModel>> getSearchHistoryList() {
    if (searchHistoryList.isEmpty) {
      return emptyList
          .map(
            (e) => SearchFieldListItem<ServicesModel>(
              '',
              child: const EmptySearchWidget(),
            ),
          )
          .toList();
    } else {
      return searchHistoryList
          .map(
            (e) => SearchFieldListItem<ServicesModel>(
              '',
              item: e,
              child: Row(
                children: [
                  Expanded(
                    child: ServiceSearchWidget(
                      obj: e,
                      addToSearchHistoryList: addToSearchHistoryList,
                      onNavigate: widget.onNavigate,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      removeFromSearchHistoryList(e);
                    },
                    icon: const Icon(
                      Icons.clear,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList();
    }
  }

  //search method
  List<ServicesModel> getServicesList() {
    return widget.servicesList;
  }

  List<SearchFieldListItem<ServicesModel>> onSearchTextChanged(String query) {
    final filter = getServicesList()
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
                  addToSearchHistoryList: addToSearchHistoryList,
                  onNavigate: widget.onNavigate,
                ),
              ))
          .toList();
    } else {
      return getSearchHistoryList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SearchFieldWidget(
      getSearchHistoryList: getSearchHistoryList(),
      onSearchTextChanged: (String query) {
        return onSearchTextChanged(query);
      },
    );
  }
}
