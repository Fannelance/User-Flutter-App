import 'package:fannelance/widgets/home_service_widget.dart';
import 'package:flutter/material.dart';

class ServicesListHomeWidget extends StatelessWidget {
  final dynamic snapshotData;
  const ServicesListHomeWidget({
    super.key, this.snapshotData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        5,
        (index) {
          return ServiceHomeWidget(
            servicesModel: snapshotData[index],
          );
        },
      ),
    );
  }
}
