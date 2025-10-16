import 'package:flutter/material.dart';

import 'wallet_card.dart';

class WalletsList extends StatelessWidget {
  const WalletsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: 100,
      ),
      itemBuilder: (context, index) => WalletCard(),
      itemCount: 6,
    );
  }
}
