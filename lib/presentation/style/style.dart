import 'package:flutter/material.dart';
import 'package:lilac_salmankv/presentation/const/colors.dart';

class Style {
  elevatedButtonDecration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      gradient: LinearGradient(
        colors: [ConstColors.basicColor, Colors.green],
      ),
    );
  }

  elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, shadowColor: Colors.transparent);
  }

  elevatedButtonTextStyle() {
    return const TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
  }
}
