import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/components/widgets/message_type_selection_bottom_sheet.dart';
import 'package:alalamia/core/enums/message_type_enum.dart';
import 'package:alalamia/core/general/cubit/general_cubit.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/widgets/app_snack_bar.dart';
import '../../../../core/general/data/models/fee_details_request_params.dart';
import '../../../../core/routes/routes.dart';
import '../../../home/presentation/views/widgets/calculator/currency_calculator.dart';
import '../../../send_money/presentation/views/widgets/fee_details_card.dart';
import '../../data/models/transfer_money_data_params.dart';
import 'widgets/amount_section.dart';
import 'widgets/client_info_section.dart';
import 'widgets/notes_section.dart';
import 'widgets/total_section.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../home/presentation/cubit/home_state.dart';

class TransferMoneyView extends StatefulWidget {
  const TransferMoneyView({super.key, this.initialData});

  /// Initial data to prefill the form when copying a transaction
  final TransferMoneyDataParams? initialData;

  @override
  State<TransferMoneyView> createState() => _TransferMoneyViewState();
}

class _TransferMoneyViewState extends State<TransferMoneyView> {
  // Currency calculator controllers
  late TextEditingController _amountController;
  late TextEditingController _resultController;

  // Client info controllers
  late TextEditingController _phoneController;
  late TextEditingController _nameController;
  late TextEditingController _whatsAppNumberController;

  // Amount by char controller
  late TextEditingController _amountByCharController;

  // Notes controller
  late TextEditingController _notesController;

  CurrencyModel? _fromCurrency;
  CurrencyModel? _toCurrency;

  @override
  void initState() {
    _amountController = TextEditingController();
    _resultController = TextEditingController();
    _phoneController = TextEditingController();
    _whatsAppNumberController = TextEditingController();
    _nameController = TextEditingController();
    _amountByCharController = TextEditingController();
    _notesController = TextEditingController();

    // Prefill form if initial data is provided
    if (widget.initialData != null) {
      _phoneController.text = widget.initialData!.clientPhone;
      _nameController.text = widget.initialData!.clientName;
      _whatsAppNumberController.text = widget.initialData!.whatsappNumber;
      _amountController.text = widget.initialData!.amount;
      _resultController.text = widget.initialData!.totalPrice;
      _amountByCharController.text = widget.initialData!.amountByChar;
      if (widget.initialData!.note != null) {
        _notesController.text = widget.initialData!.note!;
      }
    }

    context.read<HomeCubit>().getCurrencies();
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _resultController.dispose();
    _phoneController.dispose();
    _whatsAppNumberController.dispose();
    _nameController.dispose();
    _amountByCharController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _getFeeDetails() {
    if (_fromCurrency != null && _toCurrency != null) {
      context.read<GeneralCubit>().getFeeDetails(
        params: FeeDetailsRequestParams(
          amount: _amountController.text,
          fromCurrencyId: _fromCurrency!.id!,
          toCurrencyId: _toCurrency!.id!,
        ),
      );
    }
  }

  /// Validate all required fields and show message type selection
  void _handleConfirm() async {
    !_formKey.currentState!.validate();
    // Validate required fields
    if (_phoneController.text.trim().isEmpty) {
      _showError('يرجى إدخال رقم الهاتف');
      return;
    }
    if (_whatsAppNumberController.text.trim().isEmpty) {
      _showError('يرجى إدخال رقم الواتساب');
      return;
    }
    if (_nameController.text.trim().isEmpty) {
      _showError('يرجى إدخال اسم العميل');
      return;
    }
    if (_amountController.text.trim().isEmpty) {
      _showError('يرجى إدخال المبلغ');
      return;
    }
    if (_amountByCharController.text.trim().isEmpty) {
      _showError('يرجى إدخال المبلغ بالحروف');
      return;
    }
    if (_fromCurrency == null || _toCurrency == null) {
      _showError('يرجى اختيار العملات');
      return;
    }
    if (_fromCurrency?.id == _toCurrency?.id) {
      _showError('يرجى اختيار عملتين مختلفتين');
      return;
    }

    // Show message type selection bottom sheet
    final selectedMessageType = await showModalBottomSheet<MessageTypeEnum>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const MessageTypeSelectionBottomSheet(),
    );

    // Check if widget is still mounted after async operation
    if (!mounted) return;

    // If user cancelled, do not proceed
    if (selectedMessageType == null) {
      return;
    }

    // Create transfer data params with selected message type
    final transferData = TransferMoneyDataParams(
      clientPhone: _phoneController.text.trim(),
      clientName: _nameController.text.trim(),
      whatsappNumber: _whatsAppNumberController.text.trim(),
      fromCurrencyId: _fromCurrency!.id!,
      toCurrencyId: _toCurrency!.id!,
      amount: _amountController.text.trim(),
      totalPrice: _resultController.text.trim(),
      amountByChar: _amountByCharController.text.trim(),
      note: _notesController.text.trim().isNotEmpty
          ? _notesController.text.trim()
          : null,
      sendingMessageType: selectedMessageType.apiValue,
      transactionId: widget.initialData?.transactionId,
    );

    // Navigate to denomination view with data
    context.pushNamed(
      Routes.addAmountByDenominationView,
      arguments: transferData,
    );
  }

  void _showError(String message) {
    AppSnackBar.showSnackBar(
      context: context,
      message: message,
      state: SnackBarStates.error,
    );
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.currenciesList.isNotEmpty &&
            _fromCurrency == null &&
            _toCurrency == null) {
          setState(() {
            // If initial data is provided, try to match currencies
            if (widget.initialData != null) {
              _fromCurrency = state.currenciesList.firstWhere(
                (c) => c.id == widget.initialData!.fromCurrencyId,
                orElse: () => state.currenciesList[0],
              );
              _toCurrency = state.currenciesList.firstWhere(
                (c) => c.id == widget.initialData!.toCurrencyId,
                orElse: () => state.currenciesList.length > 1
                    ? state.currenciesList[1]
                    : state.currenciesList[0],
              );
            } else {
              // Default behavior
              _fromCurrency = state.currenciesList[0];
              _toCurrency = state.currenciesList.length > 1
                  ? state.currenciesList[1]
                  : state.currenciesList[0];
            }
          });
          _getFeeDetails();
        }
      },
      child: CustomPage(
        title: context.currencyTransfer,
        isBack: true,
        hasActions: false,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClientInfoSection(
                phoneController: _phoneController,
                nameController: _nameController,
                whatsAppNumberController: _whatsAppNumberController,
              ),
              20.verticalSizedBox,
              CurrencyCalculator(
                title: context.conversionData,
                amountController: _amountController,
                resultController: _resultController,
                onAmountChanged: (val) {
                  _getFeeDetails();
                },
                onFromCurrencyChanged: (c) {
                  setState(() => _fromCurrency = c);
                  _getFeeDetails();
                },
                onToCurrencyChanged: (c) {
                  setState(() => _toCurrency = c);
                  _getFeeDetails();
                },
                boxShadow: [
                  BoxShadow(
                    color: Color(0x336E0084),
                    blurRadius: 20,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ],
              ),
              20.verticalSizedBox,
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: _resultController,
                builder: (_, value, __) => TotalSection(
                  fromCurrency: _fromCurrency!,
                  toCurrency: _toCurrency!,
                  total: value.text,
                  exchangePrice: 0.0,
                ),
              ),
              20.verticalSizedBox,
              AmountSection(amountByCharController: _amountByCharController),
              20.verticalSizedBox,
              NotesSection(notesController: _notesController),
              20.verticalSizedBox,
              FeeDetailsCard(),
              24.verticalSizedBox,
              MainButton(title: context.confirm, onTap: _handleConfirm),
              40.verticalSizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
