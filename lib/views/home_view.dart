import 'package:fannelance/core/constants.dart';
import 'package:fannelance/models/services_model.dart';
import 'package:fannelance/widgets/app_bar_main_widget.dart';
import 'package:fannelance/widgets/circular_indicator_widget.dart';
import 'package:fannelance/widgets/home_stores_grid_widget.dart';
import 'package:fannelance/widgets/home_stores_list_widget.dart';
import 'package:fannelance/widgets/search_widget.dart';
import 'package:fannelance/widgets/home_services_list_widget.dart';
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
      appBar: const AppBarMainWidget(
        title: 'Fannelance',
      ),
      body: FutureBuilder(
        future: getServicesList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularIndicatorWidget();
          } else {
            var snapshotData = snapshot.data;
            var subTitleStyle = TextStyle(
              fontSize: screenWidth / 20,
            );
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    box_10,
                    // Search Frame
                    SearchWidget(
                      servicesList: snapshot.data,
                    ),
                    box_20,

                    // Suggestions Frame
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Suggestions',
                          style: subTitleStyle,
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.onLinkPressed(1);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 4,
                              right: 12,
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
                    box_10,
                    ServicesListHomeWidget(
                      snapshotData: snapshotData,
                    ),
                    box_30,

                    // Popular Stores Frame
                    Text(
                      'Popular stores',
                      style: subTitleStyle,
                    ),
                    box_10,

                    SizedBox(
                      height: screenWidth / 3.5,
                      child: const StoresListHomeWidget(),
                    ),
                    box_30,

                    // All Stores Frame
                    Text(
                      'All stores',
                      style: subTitleStyle,
                    ),
                    box_10,
                    const StoresGridHomeWidget(),
                    box_30,
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
