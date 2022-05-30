import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// For Loading Widget
Widget kLoadingWidget(context) => const Center(
      child: SpinKitFadingCube(
        color: Colors.black,
        size: 30.0,
      ),
    );
Widget kLoadingWaveWidget(context, Color color) => Center(
      child: SpinKitWave(
        color: color,
        size: 50.0,
      ),
    );