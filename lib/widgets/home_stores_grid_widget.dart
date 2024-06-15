import 'package:fannelance/core/constants.dart';
import 'package:fannelance/models/store_model.dart';
import 'package:fannelance/widgets/home_all_stores_widget.dart';
import 'package:flutter/material.dart';

class StoresGridHomeWidget extends StatelessWidget {
  const StoresGridHomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: kWhite,
        borderRadius: kBorder10,
        boxShadow: [
          BoxShadow(
            color: kGrey8,
            blurRadius: 0.02,
          ),
        ],
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 20,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return AllStoresHomeWidget(
            storeModel: storesList[index],
          );
        },
        itemCount: storesList.length,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
      ),
    );
  }
}
