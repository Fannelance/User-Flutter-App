import 'dart:async';
import 'package:fannelance/core/constants.dart';
import 'package:flutter/material.dart';

class NotificationAcceptedWidget {
  void showNotification(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 35,
        left: 10,
        right: 10,
        child: Material(
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: kBlack.withOpacity(0.8),
            ),
            child: const Text(
              'Your request had been accepted !\nMission started ⏳\nThe worker is on the way..',
              style: TextStyle(color: kWhite, fontSize: 18),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Timer(
      const Duration(seconds: 20),
      () {
        overlayEntry.remove();
      },
    );
  }
}
