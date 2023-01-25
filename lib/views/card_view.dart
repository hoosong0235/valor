import 'package:flutter/material.dart';
import 'package:valor/models/constant_model.dart';

class CardView extends StatelessWidget {
  const CardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Card(
        child: Padding(
          padding: mediumEdgeInsets,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Most Change',
                style: mediumTextStyle.copyWith(
                  color: Colors.green,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.apple,
                    size: 32,
                  ),
                  mediumSizedBox,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AAPL',
                        style: smallTextStyle,
                      ),
                      Text(
                        'APPLE',
                        style: mediumTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                '+\$0.00(+0.0%)',
                style: smallTextStyle.copyWith(
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
