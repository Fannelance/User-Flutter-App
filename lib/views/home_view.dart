import 'package:fannelance/core/constants.dart';
import 'package:fannelance/models/services_model.dart';
import 'package:fannelance/widgets/app_bar_widget.dart';
import 'package:fannelance/widgets/home_widget.dart';
import 'package:fannelance/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  final Function(int) onLinkPressed;

  const HomeView({
    Key? key,
    required this.onLinkPressed,
  }) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  List<ServicesModel> servicesList = [];

  @override
  void initState() {
    super.initState();
    getServicesList();
  }

  Future getServicesList() async {
    List<ServicesModel>? loadedServices =
        await ServicesModel.loadAndParseJson();
    return loadedServices;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const AppbarWidget(title: 'Fannelance'),
      body: FutureBuilder(
        future: getServicesList(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: black,
              ),
            );
          } else {
            return Column(
              children: [
                box_10,
                //search frame
                SearchWidget(
                  servicesList: snapshot.data,
                ),
                box_20,
                //suggestions frame
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //suggestions
                      Text(
                        'Suggestions',
                        style: TextStyle(
                          fontSize: screenWidth / 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.onLinkPressed(1);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 4,
                          ),
                          child: Text(
                            'See All',
                            style: underlineStyle.copyWith(
                              fontSize: screenWidth / 32,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                box_10,
                //services frame
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        snapshot.data.length >= 5 ? 5 : snapshot.data.length,
                        (index) {
                          return SizedBox(
                            width: screenWidth / 5.5,
                            child: HomeWidget(obj: snapshot.data[index]),
                          );
                        },
                      ),
                    ),
                  ),
                )),
              ],
            );
          }
        },
      ),
    );
  }
}
