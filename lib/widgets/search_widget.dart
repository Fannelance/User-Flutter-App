import 'package:fannelance/views/workers_view.dart';
import 'package:flutter/material.dart';
import 'package:fannelance/extras/extras.dart';
import 'package:fannelance/models/services_model.dart';
import 'package:searchfield/searchfield.dart';

class SearchWidget extends StatefulWidget {
  final List<ServicesModel> servicesList;

  const SearchWidget({Key? key, required this.servicesList}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    List<ServicesModel> services() {
      return widget.servicesList;
    }

    Widget getContainer(e) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: AppColors.greyE8,
                shadowColor: AppColors.black9,
                elevation: 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Image.asset(
                    e.serviceIcon,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              e.serviceName,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      );
    }

   

    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: SearchField(
        suggestionDirection: SuggestionDirection.flex,
        onSearchTextChanged: (query) {
          final filter = services()
              .where((element) => element.serviceName
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
          return filter
              .map((e) => SearchFieldListItem<ServicesModel>(e.serviceName,
                  child: getContainer(e)))
              .toList();
        },
        key: const Key('searchfield'),
        hint: 'Search Services...',
        itemHeight: 60,
        suggestionItemDecoration: const BoxDecoration(
          color: Colors.white24, ),
        scrollbarDecoration: ScrollbarDecoration(),
        onTapOutside: (x) {
          focus.unfocus();
        },
        suggestionStyle: const TextStyle(
            fontSize: 20, color: Colors.black, fontFamily: 'Gilroy-Meduim'),
        searchStyle: const TextStyle(
            fontSize: 18, color: Colors.black, fontFamily: 'Gilroy-Meduim'),
        searchInputDecoration: InputDecoration(
          hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.black,
              style: BorderStyle.solid,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.black,
              style: BorderStyle.solid,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8) ,
          prefixIcon: const Icon(Icons.search),
        ),
        suggestionsDecoration: SuggestionDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
        ),
         suggestions: services().map((e) {
           return SearchFieldListItem<ServicesModel>(
             e.serviceName,
              child:getContainer(e)
            
          );
        }).toList(),
        
        focusNode: focus,
        suggestionState: Suggestion.expand,
        onSuggestionTap: (SearchFieldListItem<ServicesModel> x) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const WorkersView();
          }));
          focus.unfocus();
        },
      ),
    );
  }
}
