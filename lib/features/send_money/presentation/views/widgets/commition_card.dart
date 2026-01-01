import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';

class CommitionCard extends StatelessWidget {
  const CommitionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithPurpleShadow(
      child: Column(
        children: const [
          Text("commition"),
        ],
      ),
    );
  }
}