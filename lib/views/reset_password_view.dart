import 'package:fannelance/core/constants.dart';
import 'package:fannelance/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class ResetPasswoedView extends StatelessWidget {
  const ResetPasswoedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SubAppBarWidget(),
      body: Container(
        color: pink,
      ),
    );
  }
}
