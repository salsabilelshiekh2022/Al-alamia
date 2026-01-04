import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/features/transactions/presentation/cubit/transactions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../core/enums/status_enum.dart';
import '../../../../generated/app_assets.dart';
import '../cubit/transactions_state.dart';
import 'widgets/transactions_details/beneficiary_info_card.dart';
import 'widgets/transactions_details/sender_info_card.dart';
import 'widgets/transactions_details/status_box.dart';
import 'widgets/transactions_details/transaction_info.dart';
import 'widgets/transactions_details/transefered_info_widget.dart';

class TransactionsDetailsView extends StatefulWidget {
  const TransactionsDetailsView(this.id, {super.key});
  final int id;

  @override
  State<TransactionsDetailsView> createState() =>
      _TransactionsDetailsViewState();
}

class _TransactionsDetailsViewState extends State<TransactionsDetailsView> {
  @override
  void initState() {
    context.read<TransactionsCubit>().showTransactionDetails(
      transactionId: widget.id.toString(),
    );
    super.initState();
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppAssets.imagesBackground,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: BlocBuilder<TransactionsCubit, TransactionsState>(
              builder: (context, state) {
                return Column(
                  children: [
                    CustomAppBar(
                      title: context.transactions,
                      hasActions: false,
                      isBack: true,
                    ).onlyPadding(bottomPadding: 24),

                    Skeletonizer(
                      enabled:
                          state.transactionDetailsStatus ==
                          RequestStatus.loading,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 35,
                            ),
                            width: double.infinity,
                            constraints: BoxConstraints(
                              minHeight:
                                  MediaQuery.of(context).size.height - 130.h,
                            ),
                            decoration: BoxDecoration(
                              color: context.colors.whiteColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            child: Column(
                              children: [
                                25.verticalSizedBox,
                                TransferredAmountInfoWidget(),
                                20.verticalSizedBox,
                                SenderInfoCard(),
                                20.verticalSizedBox,
                                BeneficiaryInfoCard(),
                                20.verticalSizedBox,
                                TransactionInfoCard(),
                                32.verticalSizedBox,
                                MainButton(
                                  title: context.printReceipt,
                                  onTap: () => _launchUrl(
                                    state.transactionDetails?.pdfUrl ?? '',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PositionedDirectional(
                            top: -10,
                            start: 16,
                            end: 16,
                            child: StatusBox(
                              status:
                                  state.transactionDetails?.details.status ??
                                  StatusEnum.pending,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
