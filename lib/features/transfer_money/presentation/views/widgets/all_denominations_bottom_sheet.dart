import 'package:alalamia/core/components/widgets/custom_text_field.dart';
import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/general/cubit/general_cubit.dart';
import 'package:alalamia/core/general/cubit/general_state.dart';
import 'package:alalamia/core/general/data/models/denomination_model.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllDenominationsBottomSheet extends StatefulWidget {
  const AllDenominationsBottomSheet({super.key});

  @override
  State<AllDenominationsBottomSheet> createState() =>
      _AllDenominationsBottomSheetState();
}

class _AllDenominationsBottomSheetState
    extends State<AllDenominationsBottomSheet> {
  @override
  void initState() {
    context.read<GeneralCubit>().getAllDenominations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.enterAmountByDenominations,
          style: context.textStyles.font17SemiBoldSecondaryColor,
        ),
        27.verticalSizedBox,
        CustomTextField(
          hintText: context.amountHint,
          enabled: false,
          initialValue: "1,250.00",
          textStyle: context.textStyles.font16MediumSecondaryColor,
        ),

        BlocBuilder<GeneralCubit, GeneralState>(
          builder: (context, state) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                mainAxisExtent: 50,
              ),

              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.denominations?.length ?? 6,
              itemBuilder: (context, index) {
                return Skeletonizer(
                  enabled: state.getAllDenominationsStatus.isLoading,
                  child: DenominationItem(
                    denominationModel:
                        state.denominations?[index] ?? DenominationModel(),
                  ),
                );
              },
            ).onlyPadding(topPadding: 28);
          },
        ),
        MainButton(title: context.confirm, onTap: () {}),
        32.verticalSizedBox,
      ],
    );
  }
}

class DenominationItem extends StatefulWidget {
  const DenominationItem({super.key, required this.denominationModel});
  final DenominationModel denominationModel;

  @override
  State<DenominationItem> createState() => _DenominationItemState();
}

class _DenominationItemState extends State<DenominationItem> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.backgroundFieldColor,
        borderRadius: 12.allBorderRadius,
        border: Border.all(color: context.colors.strokeColor, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: double.infinity,
              padding: 12.allPadding,
              decoration: BoxDecoration(
                color: context.colors.strokeColor,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(12.r),
                  bottomStart: Radius.circular(12.r),
                ),
              ),
              child: FittedBox(
                child: Text(
                  widget.denominationModel.name ?? 'text',
                  style: context.textStyles.font18SemiBoldSecondaryColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: 12.allPadding,
              height: double.infinity,
              decoration: BoxDecoration(
                color: context.colors.backgroundFieldColor,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(12.r),
                  bottomEnd: Radius.circular(12.r),
                ),
              ),
              child: Row(
                children: [
                  _countButton(
                    context: context,
                    icon: Icons.add_rounded,
                    onTap: () {
                      setState(() {
                        count++;
                      });
                    },
                  ),

                  10.horizontalSizedBox,

                  Text(
                    count.toString(),
                    style: context.textStyles.font17SemiBoldSecondaryColor
                        .copyWith(fontWeight: FontWeight.w500),
                  ),

                  10.horizontalSizedBox,

                  _countButton(
                    context: context,
                    icon: Icons.remove_rounded,
                    onTap: () {
                      setState(() {
                        if (count > 0) {
                          count--;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InkWell _countButton({
    required BuildContext context,
    void Function()? onTap,
    required IconData icon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: 13.allBorderRadius,
          color: Color(0xff9b9b9b).withValues(alpha: 0.09),
        ),
        child: Icon(
          icon,
          color: context.colors.secondaryColor,
          size: 16.sp,
        ).center(),
      ),
    );
  }
}
