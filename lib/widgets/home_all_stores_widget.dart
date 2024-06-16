import 'package:fannelance/core/constants.dart';
import 'package:fannelance/models/store_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AllStoresHomeWidget extends StatelessWidget {
  final StoreModel storeModel;

  const AllStoresHomeWidget({
    super.key,
    required this.storeModel,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    launchStoreURL() async {
      final Uri url = Uri.parse(storeModel.url);
      if (await launchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return GestureDetector(
      onTap: launchStoreURL,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: kGrey9,
                  width: 0.4,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        storeModel.logo,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              storeModel.name,
              style: TextStyle(
                fontSize: screenWidth / 36,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
