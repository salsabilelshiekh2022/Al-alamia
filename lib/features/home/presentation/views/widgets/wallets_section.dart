import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'wallet_list.dart';

class WalletsSections extends StatelessWidget {
  const WalletsSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.wallets,
          style: context.textStyles.font16SemiBoldSecondaryColor,
        ),
        20.verticalSpace,
        WalletsList(),
      ],
    );
  }
}
