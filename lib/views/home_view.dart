import 'package:fannelance/extras/extras.dart';
import 'package:fannelance/models/custom_icons_icons.dart';
import 'package:fannelance/models/services_model.dart';
import 'package:fannelance/widgets/home_widget.dart';
import 'package:fannelance/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  final Function(int) onLinkPressed;

  const HomeView({Key? key, required this.onLinkPressed}) : super(key: key);

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

  void getServicesList() async {
    List<ServicesModel>? loadedServices =
        await ServicesModel.loadAndParseJson();
    setState(() {
      servicesList = loadedServices;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Fannelance',
          style: TextStyle(fontFamily: 'Gilroy-Bold', fontSize: screenWidth/9.7),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          //search frame
          SizedBox(
            height: screenWidth/7,
           child:  SearchWidget(servicesList: servicesList),
           
          
          ),

          const SizedBox(height: 50),
          //suggestions frame
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Suggestions',
                  style: TextStyle(
                    fontSize: screenWidth/15,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.onLinkPressed(1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        shadows: const [Shadow(offset: Offset(0, -2))],
                        color: Colors.transparent,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1.5,
                        fontSize: screenWidth/23,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          //services frame
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemExtent: (MediaQuery.of(context).size.width - 20) / 4,
                scrollDirection: Axis.horizontal,
                itemCount: servicesList.length >= 4 ? 4 : servicesList.length,
                itemBuilder: (context, index) {
                  return HomeWidget(obj: servicesList[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
