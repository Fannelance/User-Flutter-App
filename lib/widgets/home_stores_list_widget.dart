import 'package:fannelance/models/store_model.dart';
import 'package:fannelance/widgets/home_popular_stores_widget.dart';
import 'package:flutter/material.dart';

class StoresListHomeWidget extends StatelessWidget {
  const StoresListHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        2,
        (index) {
          return PopularStoreHomeWidget(
            storeModel: storesList[index],
          );
        },
      ),
    );
  }
}
