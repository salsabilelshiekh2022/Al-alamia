import 'package:alalamia/core/enums/debets_enum.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/debts/data/models/debt_model.dart';
import 'package:alalamia/features/debts/data/models/get_debts_by_currency_request_params.dart';
import 'package:alalamia/features/debts/presentation/cubit/debt_state.dart';
import 'package:alalamia/features/debts/presentation/cubit/debts_cubit.dart';
import 'package:alalamia/features/debts/presentation/views/widgets/debt_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../core/components/widgets/custom_currency_dropdown.dart';
import '../../../../core/components/widgets/empty_widget.dart';
import '../../../../core/components/widgets/main_button.dart';
import '../../../../core/enums/request_status.dart';
import '../../../../core/helper/app_extention.dart';
import '../../../../core/helper/number_extentions.dart';
import '../../../../core/helper/widget_extentions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../generated/app_assets.dart';
import '../../../home/data/models/currency_model.dart';
import '../../../home/presentation/cubit/home_cubit.dart';

class DebtsView extends StatefulWidget {
  const DebtsView({super.key, required this.debetType});
  final DebetsTypeEnum debetType;

  @override
  State<DebtsView> createState() => _DebtsViewState();
}

class _DebtsViewState extends State<DebtsView> {
  CurrencyModel? selectedCurrency ;


  @override
  void initState() {
    super.initState();
    selectedCurrency = context.read<HomeCubit>().state.currenciesList.first;
    context.read<DebtsCubit>().getDebtsTransactions(type: widget.debetType == DebetsTypeEnum.debt_inside ? "inside" : "outside");
    context.read<DebtsCubit>().getDebtsByCurrency(id:selectedCurrency!.id! , params: GetDebtsByCurrencyRequestParams(debtsType: widget.debetType));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundImage(),
          SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(
                  title: widget.debetType.translate(context),

                  isBack: true,
                ).onlyPadding(bottomPadding: 0),
               BlocBuilder<DebtsCubit, DebtsState>(
                  builder: (context, state) {
                    return Text(
                      "\$${state.debtsAmountByCurrency ?? "0.0"}",
                      style: context.textStyles.font24BoldSecondaryColor
                          .copyWith(color: context.colors.whiteColor),
                    );
                  },
                ),
                8.verticalSizedBox,
                SizedBox(
                  width: 150.w,
                  child: CustomCurrencyDropdown(
                    items: context.read<HomeCubit>().state.currenciesList,
                    selectedItem: selectedCurrency,
                    onChanged: (val) {
                      setState(() {
                        selectedCurrency = val;
                        context.read<DebtsCubit>().getDebtsByCurrency(
                          id: val!.id!,
                          params: GetDebtsByCurrencyRequestParams(
                            debtsType: widget.debetType,
                          ),
                        );
                      });
                    },
                    color: Colors.white,
                    displayImageCurrency: false,
                  ),
                ),
                12.verticalSizedBox,
                Row(
                  children: [
                    Expanded(
                      child: MainButton(
                        title: context.requestDebt,
                        onTap: () => context.pushNamed(Routes.requestDeptView, arguments: widget.debetType),
                        color: Colors.white.withValues(alpha: 0.08),
                        borderColor: context.colors.whiteColor.withValues(
                          alpha: 0.36,
                        ),
                        icon: AppAssets.svgsCash,
                      ),
                    ),
                    12.horizontalSizedBox,
                    Expanded(
                      child: MainButton(
                        title: context.paymentDebt,
                        onTap: () => context.pushNamed(Routes.paymentDeptView, arguments: widget.debetType),
                        color: Colors.white.withValues(alpha: 0.08),
                        borderColor: context.colors.whiteColor.withValues(
                          alpha: 0.36,
                        ),
                        icon: AppAssets.svgsCash,
                      ),
                    ),
                  ],
                ).horizontalPadding(16),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(24),
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 130.h,
                  ),

                  decoration: BoxDecoration(
                    color: context.colors.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.transactions,
                        style: context.textStyles.font15SemiBoldSecondaryColor
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      18.verticalSizedBox,
                      BlocBuilder<DebtsCubit, DebtsState>(
                        builder: (context, state) {
                          bool isLoading = state.debtsStatus.isLoading && state.debtsTransactions == null;
                          bool isEmpty = !isLoading && (state.debtsTransactions == null || state.debtsTransactions!.isEmpty);
                          return Skeletonizer(
                            enabled: isLoading,
                            child: isEmpty ?Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              65.verticalSizedBox,
              EmptyWidget(imagePath: AppAssets.imagesEmptyTransaction, title: context.notFoundTransactions, description: context.notFoundTransactionsDescription).center(),
            ],
          ) : ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  12.verticalSizedBox,
                              itemCount: isLoading
                                  ? 3
                                  : state.debtsTransactions?.length ?? 0,
                              itemBuilder: (context, index) => DebtItem(
                                debetsTypeEnum: widget.debetType,
                                debtModel: isLoading
                                    ? dummyDebtModel
                                    : state.debtsTransactions![index],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Image _buildBackgroundImage() {
    return Image.asset(
      AppAssets.imagesBackground,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
