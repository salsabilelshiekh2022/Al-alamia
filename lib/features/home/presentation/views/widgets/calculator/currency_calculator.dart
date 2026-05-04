import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/features/home/presentation/cubit/home_cubit.dart';
import 'package:alalamia/features/home/presentation/views/widgets/calculator/currency_input_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/components/widgets/app_snack_bar.dart';
import '../../../../data/models/currency_model.dart';
import '../../../../data/models/transfer_currency_request_params.dart';
import '../../../cubit/home_state.dart';
import 'divider_with_swap_button.dart';

class CurrencyCalculator extends StatefulWidget {
  const CurrencyCalculator({
    super.key,
    required this.amountController,
    required this.resultController,
    this.boxShadow,
    this.title,
    this.onFromCurrencyChanged,
    this.onToCurrencyChanged,
    this.onAmountChanged,
    this.isFromCurrencyLocked = false,
    this.initialFromCurrency,
    required this.fromCurrencies,
    required this.toCurrencies,
  });

  final TextEditingController amountController;
  final TextEditingController resultController;
  final List<BoxShadow>? boxShadow;
  final String? title;
  final ValueChanged<CurrencyModel?>? onFromCurrencyChanged;
  final ValueChanged<CurrencyModel?>? onToCurrencyChanged;
  final void Function(String)? onAmountChanged;
  final bool isFromCurrencyLocked;
  final CurrencyModel? initialFromCurrency;
  final List<CurrencyModel> fromCurrencies ;
  final List<CurrencyModel> toCurrencies ;

  @override
  State<CurrencyCalculator> createState() => _CurrencyCalculatorState();
}

class _CurrencyCalculatorState extends State<CurrencyCalculator> {
  CurrencyModel? _fromCurrency;
  CurrencyModel? _toCurrency;
  bool _currenciesInitialized = false;
  bool _missingCurrencyMessageShown = false;
 

  void _swapCurrencies() {
    if (widget.isFromCurrencyLocked) return;
    if (_fromCurrency == null || _toCurrency == null) return;

    setState(() {
      final temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;

      widget.onFromCurrencyChanged?.call(_fromCurrency);
      widget.onToCurrencyChanged?.call(_toCurrency);

      _calculateExchangeRate();
    });
  }

  void _onAmountChanged(String value) {
    if (value.isEmpty) {
      _missingCurrencyMessageShown = false;
      widget.resultController.text = '';
      widget.onAmountChanged?.call(value);
      return;
    }

    if (_fromCurrency == null || _toCurrency == null) {
      if (!_missingCurrencyMessageShown) {
        AppSnackBar.showSnackBar(
          context: context,
          message: context.currenyHint,
          state: SnackBarStates.error,
        );
        _missingCurrencyMessageShown = true;
      }
      widget.onAmountChanged?.call(value);
      return;
    }

    final homeState = context.read<HomeCubit>().state;
    final double amount = double.tryParse(value) ?? 0;
    final num exchangeRate =homeState.transferCurrencyStatus.isSuccess ? homeState.transferCurrency?.exchangePriceUsed ?? 0 : 0;
    final result = (amount * exchangeRate).toStringAsFixed(2);
    widget.resultController.text = result;
    widget.onAmountChanged?.call(value);
  }

  void _onFromCurrencyChanged(CurrencyModel? currency) {
    setState(() {
      _fromCurrency = currency;
      _missingCurrencyMessageShown = false;
      if (_fromCurrency != null && _toCurrency != null) {
        _calculateExchangeRate();
      }
    });
    widget.onFromCurrencyChanged?.call(currency);
  }

  void _onToCurrencyChanged(CurrencyModel? currency) {
    setState(() {
      _toCurrency = currency;
      _missingCurrencyMessageShown = false;
      if (_fromCurrency != null && _toCurrency != null) {
        _calculateExchangeRate();
      }
    });
    widget.onToCurrencyChanged?.call(currency);
  }

  void _calculateExchangeRate() {
    if (_fromCurrency == null || _toCurrency == null) return;

    final cubit = context.read<HomeCubit>();
    cubit.transferCurrency(
      transferCurrencyRequestParams: TransferCurrencyRequestParams(
        fromCurrencyId: _fromCurrency!.id!,
        toCurrencyId: _toCurrency!.id!,
      ),
    );
  }

  void _initializeCurrencies(HomeState state) {
    if (_currenciesInitialized || state.currenciesList.isEmpty) {
      return;
    }

    if (widget.initialFromCurrency == null) {
      _currenciesInitialized = true;
      return;
    }

    if (_fromCurrency != null) {
      _currenciesInitialized = true;
      return;
    }

    if (!_currenciesInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _fromCurrency = widget.initialFromCurrency;
            _currenciesInitialized = true;
            widget.onFromCurrencyChanged?.call(_fromCurrency);
          });
        }
      });
    }
  }

  void _updateResultFromExchangeRate(HomeState state) {
    if (state.transferCurrencyStatus.isSuccess) {
      final double amount = double.tryParse(widget.amountController.text) ?? 0;
      final num exchangeRate = state.transferCurrency?.exchangePriceUsed ?? 0;
      final result = (amount * exchangeRate).toStringAsFixed(2);

      widget.resultController.text = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if(state.transferCurrencyStatus.isError){
         
          AppSnackBar.showSnackBar(
            context: context,
            message:"لا يوجد سعر صرف بين العملتين",
            state: SnackBarStates.error,
          );
           widget.resultController.text = '';
        }
        
        _initializeCurrencies(state);
        _updateResultFromExchangeRate(state);
      },
      builder: (context, state) {
        final List<CurrencyModel> fromCurrencies =
            widget.fromCurrencies.isNotEmpty
                ? widget.fromCurrencies
                : state.currenciesList;
        final List<CurrencyModel> toCurrencies =
            widget.toCurrencies.isNotEmpty
                ? widget.toCurrencies
                : state.currenciesList;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _initializeCurrencies(state);
          }
        });
        return Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            // boxShadow:
            //     widget.boxShadow ??
            //     [
            //       BoxShadow(
            //         color: const Color(0x11000000),
            //         blurRadius: 44,
            //         offset: const Offset(0, 0),
            //         spreadRadius: 0,
            //       ),
            //     ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.title != null
                  ? Text(
                      widget.title!,
                      style: context.textStyles.font18SemiBoldSecondaryColor,
                    ).onlyPadding(bottomPadding: 12)
                  : SizedBox(),
              Text(
                context.amount,
                style: context.textStyles.font15MediumGrayColor,
              ),
              16.verticalSizedBox,
              CurrencyInputRow(
                enabled: true,
                currencies: fromCurrencies,
                selectedCurrency: _fromCurrency,
                onCurrencyChanged: _onFromCurrencyChanged,
                controller: widget.amountController,
                onAmountChanged: _onAmountChanged,
                isDropdownEnabled: !widget.isFromCurrencyLocked,
              ),
              35.verticalSizedBox,
              DividerWithSwapButton(
                onSwapPressed:
                    widget.isFromCurrencyLocked ? null : _swapCurrencies,
              ),
              16.verticalSizedBox,
              Text(
                context.transeferedAmount,
                style: context.textStyles.font15MediumGrayColor,
              ),
              16.verticalSizedBox,
              CurrencyInputRow(
                enabled: false,
                currencies: toCurrencies,
                selectedCurrency: _toCurrency,
                onCurrencyChanged: _onToCurrencyChanged,
                controller: widget.resultController,
              ),
            ],
          ),
        );
      },
    );
  }
}
