import 'package:alalamia/features/home/data/models/wallet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'wallet_card.dart';

class WalletGridPage extends StatelessWidget {
  const WalletGridPage({
    super.key,
    required this.items,
    required this.isLoading,
  });

  final List<WalletModel> items;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
        crossAxisSpacing: 4.w,
        mainAxisSpacing: 4.h,
        mainAxisExtent: 100.h,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Skeletonizer(
          enabled: isLoading,
          child: WalletCard(currencyModel: items[index]),
        );
      },
    );
  }
}
