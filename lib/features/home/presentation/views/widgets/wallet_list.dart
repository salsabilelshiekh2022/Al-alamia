import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'package:alalamia/features/home/presentation/cubit/home_cubit.dart';
import 'package:alalamia/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'wallet_card.dart';

class WalletsList extends StatelessWidget {
  const WalletsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        bool isLoading =
            state.homeStatus.isLoading && state.currenciesList.isEmpty;
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
          itemBuilder: (context, index) => Skeletonizer(
            enabled: isLoading,
            child: WalletCard(
              currencyModel: isLoading
                  ? dummyCurrenyModel
                  : state.currenciesList[index],
            ),
          ),
          itemCount: isLoading ? 6 : 6,
        );
      },
    );
  }
}
