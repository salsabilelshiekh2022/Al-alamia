import 'package:alalamia/core/enums/debets_enum.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/debts/data/models/get_debts_by_currency_request_params.dart';
import 'package:alalamia/features/debts/presentation/cubit/debt_state.dart';
import 'package:alalamia/features/debts/presentation/cubit/debts_cubit.dart';
import 'package:alalamia/features/debts/presentation/views/widgets/debts_list_widget.dart';
import 'package:alalamia/features/transactions/presentation/views/widgets/transactions_details/card_with_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../core/components/widgets/custom_currency_dropdown.dart';
import '../../../../core/components/widgets/main_button.dart';
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
  CurrencyModel? selectedCurrency;
  bool showTableofPayment = false;

  @override
  void initState() {
    super.initState();
    selectedCurrency = context.read<HomeCubit>().state.currenciesList.first;
    context.read<DebtsCubit>().getDebtsByCurrency(
      id: selectedCurrency!.id!,
      params: GetDebtsByCurrencyRequestParams(debtsType: widget.debetType),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundImage(),
          Column(
            children: [
              CustomAppBar(
                title: widget.debetType.translate(context),
                isBack: true,
              ).onlyPadding(bottomPadding: 0),
              BlocBuilder<DebtsCubit, DebtsState>(
                builder: (context, state) {
                  return Text(
                    "\$${state.debtsAmountByCurrency ?? "0.0"}",
                    style: context.textStyles.font24BoldSecondaryColor.copyWith(
                      color: context.colors.whiteColor,
                    ),
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
                      onTap: () => context.pushNamed(
                        Routes.requestDeptView,
                        arguments: widget.debetType,
                      ),
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
                      onTap: () => context.pushNamed(
                        Routes.paymentDeptView,
                        arguments: widget.debetType,
                      ),
                      color: Colors.white.withValues(alpha: 0.08),
                      borderColor: context.colors.whiteColor.withValues(
                        alpha: 0.36,
                      ),
                      icon: AppAssets.svgsCash,
                    ),
                  ),
                ],
              ).horizontalPadding(16),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(24),
                  width: double.infinity,
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
                      widget.debetType == DebetsTypeEnum.debt_inside
                          ? Row(
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          showTableofPayment = false;
                                        });
                                      },
                                      child: Text(
                                        context.transactions,
                                        style: context
                                            .textStyles
                                            .font16SemiBoldSecondaryColor
                                            .copyWith(
                                              color: showTableofPayment
                                                  ? context.colors.grayColor
                                                  : context.colors.primaryColor,
                                              fontSize: showTableofPayment
                                                  ? 14
                                                  : 16,
                                            ),
                                      ),
                                    ),
                                    12.verticalSizedBox,
                                    Container(
                                      width: context.width /2 -30,
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: showTableofPayment
                                            ? Color(0xffECECEC)
                                            : context.colors.primaryColor,
                                        borderRadius: BorderRadius.circular(1000),
                                      ),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          showTableofPayment = true;
                                        });
                                      },
                                      child: Text(
                                        "جدول السداد",
                                        style: context
                                            .textStyles
                                            .font16SemiBoldSecondaryColor
                                            .copyWith(
                                              color: showTableofPayment
                                                  ? context.colors.primaryColor
                                                  : context.colors.grayColor,
                                              fontSize: showTableofPayment
                                                  ? 16
                                                  : 14,
                                            ),
                                      ),
                                    ),
                                    12.verticalSizedBox,
                                    Container(
                                      width: context.width /2-30,
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: showTableofPayment
                                            ? context.colors.primaryColor
                                            : Color(0xffECECEC),
                                        borderRadius: BorderRadius.circular(1000),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          : Text(
                              context.transactions,
                              style: context
                                  .textStyles
                                  .font15SemiBoldSecondaryColor
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                      18.verticalSizedBox,
                      showTableofPayment
                          ? TableOfPaymentWidget()
                          : Expanded(
                              child: DebtsListWidget(
                                debetType: widget.debetType,
                                type:
                                    widget.debetType ==
                                        DebetsTypeEnum.debt_inside
                                    ? "inside"
                                    : "outside",
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
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

class TableOfPaymentWidget extends StatelessWidget {
  const TableOfPaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithShadow(
      borderRadius: 20,
      padding: 20,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xffFAF9FB),
              borderRadius: BorderRadius.circular(1000),
            ),
            child: Text(
              "# 78247 ",
              style: context.textStyles.font14SemiBoldPrimaryColor,
            ),
          ),
          24.verticalSizedBox,
          _buildHeader(context),
          12.verticalSizedBox,
          _buildItem(context),
          12.verticalSizedBox,
          _buildItem(context),
          12.verticalSizedBox,
          _buildItem(context),
          12.verticalSizedBox,
          _buildItem(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 43, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xffFAF9FB),
        borderRadius: BorderRadius.circular(48),
        border: Border.all(
          color: context.colors.primaryColor.withValues(alpha: 0.06),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            " التاريخ",
            style: context.textStyles.font14SemiBoldSecondaryColor,
          ),
          Container(
            width: 1,
            height: 20,
            color: context.colors.grayColor.withValues(alpha: 0.36),
          ).horizontalPadding(12),
          Text(
            "المبلغ",
            style: context.textStyles.font14SemiBoldSecondaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 43, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(48),
        border: Border.all(
          color: context.colors.primaryColor.withValues(alpha: 0.06),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(" 3 مايو 2026", style: context.textStyles.font14MediumGrayColor),
          Container(
            width: 1,
            height: 20,
            color: context.colors.grayColor.withValues(alpha: 0.36),
          ).horizontalPadding(12),
          Text("500 LD", style: context.textStyles.font14MediumGrayColor),
        ],
      ),
    );
  }
}
