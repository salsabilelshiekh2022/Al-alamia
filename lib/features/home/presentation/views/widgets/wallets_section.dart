import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/home_state.dart';
import 'wallet_list.dart';

class WalletsSections extends StatelessWidget {
  const WalletsSections({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
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
      },
    );
  }
}
