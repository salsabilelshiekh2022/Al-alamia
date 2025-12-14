import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/di/dependency_injection.dart';
import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/general/cubit/general_cubit.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/utils/global_ui_utils.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'package:alalamia/features/transfer_money/data/models/transfer_money_request_params.dart';
import 'package:alalamia/features/transfer_money/presentation/cubit/transfer_money_cubit.dart';
import 'package:alalamia/features/transfer_money/presentation/cubit/transfer_money_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/general/data/models/fee_details_request_params.dart';
import '../../../../core/routes/routes.dart';
import '../../../home/presentation/views/widgets/calculator/currency_calculator.dart';
import '../../../send_money/presentation/views/widgets/fee_details_card.dart';
import 'widgets/all_denominations_bottom_sheet.dart';
import 'widgets/amount_section.dart';
import 'widgets/client_info_section.dart';
import 'widgets/notes_section.dart';
import 'widgets/total_section.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../home/presentation/cubit/home_state.dart';

class TransferMoneyView extends StatefulWidget {
  const TransferMoneyView({super.key});

  @override
  State<TransferMoneyView> createState() => _TransferMoneyViewState();
}

class _TransferMoneyViewState extends State<TransferMoneyView> {
  late TextEditingController _amountController;
  late TextEditingController _resultController;
  late TextEditingController _amountByCharController;
  late TextEditingController _notesController;
  
  CurrencyModel? _fromCurrency;
  CurrencyModel? _toCurrency;
  String _clientPhone = '';
  String _clientName = '';
  List<Map<String, dynamic>> _selectedDenominations = [];
  
  final GlobalKey<ClientInfoSectionState> _clientInfoKey = GlobalKey();
  final GlobalKey<NotesSectionState> _notesKey = GlobalKey();
  final GlobalKey<AmountSectionState> _amountKey = GlobalKey();

  /// Cubit instance - created once and managed by this widget.
  late TransferCurrencyCubit _transferCubit;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _resultController = TextEditingController();
    _amountByCharController = TextEditingController();
    _notesController = TextEditingController();
    _transferCubit = getIt<TransferCurrencyCubit>();
    
    // Fetch currencies on init
    context.read<HomeCubit>().getCurrencies();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _resultController.dispose();
    _amountByCharController.dispose();
    _notesController.dispose();
    _transferCubit.close();
    super.dispose();
  }

  void _getFeeDetails() {
    if (_fromCurrency != null && _toCurrency != null && _amountController.text.isNotEmpty) {
      context.read<GeneralCubit>().getFeeDetails(
        params: FeeDetailsRequestParams(
          amount: _amountController.text,
          fromCurrencyId: _fromCurrency!.id!,
          toCurrencyId: _toCurrency!.id!,
        ),
      );
    }
  }

  void _updateClientInfo(String phone, String name) {
    _clientPhone = phone;
    _clientName = name;
  }

  void _updateNotes(String notes) {
    _notesController.text = notes;
  }

  void _updateAmountByChar(String amountByChar) {
    _amountByCharController.text = amountByChar;
  }

  bool _validateForm() {
    if (_clientPhone.isEmpty) {
      _showValidationError('Please enter client phone number');
      return false;
    }
    if (_clientName.isEmpty) {
      _showValidationError('Please enter client name');
      return false;
    }
    if (_amountController.text.isEmpty) {
      _showValidationError('Please enter amount');
      return false;
    }
    if (_amountByCharController.text.isEmpty) {
      _showValidationError('Please enter amount in words');
      return false;
    }
    if (_fromCurrency == null || _toCurrency == null) {
      _showValidationError('Please select currencies');
      return false;
    }
    if (_selectedDenominations.isEmpty) {
      _showValidationError('Please select denominations');
      return false;
    }
    return true;
  }

  void _showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _performTransfer() {
    if (!_validateForm()) return;

    final denominations = _selectedDenominations
        .map(
          (denom) => DenominationsRequestParams(
            id: denom['id'] as int,
            quantity: denom['quantity'] as int,
          ),
        )
        .toList();

    final params = TransferMoneyRequestParams(
      clientPhone: _clientPhone,
      clientName: _clientName,
      fromCurrencyId: _fromCurrency!.id!,
      toCurrencyId: _toCurrency!.id!,
      amount: _amountController.text,
      totalPrice: _resultController.text,
      amountByChar: _amountByCharController.text,
      denominations: denominations,
      note: _notesController.text.isNotEmpty ? _notesController.text : null,
    );

    _transferCubit.transferMoney(
      transferMoneyRequestParams: params,
    );
  }

  void _showDenominationsBottomSheet(BuildContext blocContext) {
    GlobalUiUtils.showBottomSheet(
      context,
      child: BlocProvider.value(
        value: context.read<GeneralCubit>(),
        child: AllDenominationsBottomSheet(
          onDenominationsSelected: (denominations) {
            _selectedDenominations = denominations;
            _performTransfer();
          },
        ),
      ),
    );
  }

  void _handleTransferStateChange(BuildContext context, TransferMoneyState state) {
    if (state.transferMoneyState.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message ?? 'Transfer completed successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pushReplacementNamed(Routes.transactionReciptView);
    } else if (state.transferMoneyState.isError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message ?? 'Transfer failed'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _transferCubit,
      child: MultiBlocListener(
        listeners: [
          BlocListener<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state.currenciesList.isNotEmpty &&
                  _fromCurrency == null &&
                  _toCurrency == null) {
                setState(() {
                  _fromCurrency = state.currenciesList[0];
                  _toCurrency = state.currenciesList.length > 1
                      ? state.currenciesList[1]
                      : state.currenciesList[0];
                });
                _getFeeDetails();
              }
            },
          ),
          BlocListener<TransferCurrencyCubit, TransferMoneyState>(
            listener: _handleTransferStateChange,
          ),
        ],
        child: CustomPage(
          title: context.currencyTransfer,
          isBack: true,
          hasActions: false,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClientInfoSection(
                key: _clientInfoKey,
                onClientInfoChanged: _updateClientInfo,
              ),
              20.verticalSizedBox,
              CurrencyCalculator(
                title: context.conversionData,
                amountController: _amountController,
                resultController: _resultController,
                onAmountChanged: (val) => _getFeeDetails(),
                onFromCurrencyChanged: (c) {
                  setState(() => _fromCurrency = c);
                  _getFeeDetails();
                },
                onToCurrencyChanged: (c) {
                  setState(() => _toCurrency = c);
                  _getFeeDetails();
                },
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x336E0084),
                    blurRadius: 20,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ],
              ),
              20.verticalSizedBox,
              _buildTotalSection(),
              20.verticalSizedBox,
              AmountSection(
                key: _amountKey,
                controller: _amountByCharController,
                onAmountByCharChanged: _updateAmountByChar,
              ),
              20.verticalSizedBox,
              NotesSection(
                key: _notesKey,
                controller: _notesController,
                onNotesChanged: _updateNotes,
              ),
              20.verticalSizedBox,
              const FeeDetailsCard(),
              24.verticalSizedBox,
              _buildTransferButton(),
              40.verticalSizedBox,
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the total section with null safety for currencies.
  Widget _buildTotalSection() {
    if (_fromCurrency == null || _toCurrency == null) {
      // Return placeholder while currencies are loading
      return const SizedBox.shrink();
    }

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _resultController,
      builder: (_, value, __) => TotalSection(
        fromCurrency: _fromCurrency!,
        toCurrency: _toCurrency!,
        total: value.text,
        exchangePrice: 0.0,
      ),
    );
  }

  /// Builds the transfer button with loading state.
  Widget _buildTransferButton() {
    return BlocBuilder<TransferCurrencyCubit, TransferMoneyState>(
      builder: (context, transferState) {
        final isLoading = transferState.transferMoneyState.isLoading;
        
        return MainButton(
          title: isLoading ? 'Processing...' : context.confirm,
          onTap: isLoading ? () {} : () => _showDenominationsBottomSheet(context),
        );
      },
    );
  }
}
