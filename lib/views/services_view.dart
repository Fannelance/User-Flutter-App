import 'package:fannelance/models/services_model.dart';
import 'package:fannelance/widgets/app_bar_main_widget.dart';
import 'package:fannelance/widgets/circular_indicator_widget.dart';
import 'package:fannelance/widgets/service_widget.dart';
import 'package:flutter/material.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({Key? key}) : super(key: key);

  @override
  ServicesViewState createState() => ServicesViewState();
}

class ServicesViewState extends State<ServicesView> {
  @override
  void initState() {
    super.initState();
  }

  Future getServicesList() async {
    List<ServicesModel>? loadedServices =
        await ServicesModel.loadAndParseJson();
    return loadedServices;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMainWidget(title: 'Services'),
      body: FutureBuilder(
        future: getServicesList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return  const CircularIndicatorWidget();
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 5, bottom: 15),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ServicesWidget(
                obj: snapshot.data[index],
              );
            },
          );
        },
      ),
    );
  }
}
