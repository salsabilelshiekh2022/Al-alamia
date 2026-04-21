import 'package:alalamia/core/components/widgets/custom_text_field_with_label.dart';
import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../core/utils/global_ui_utils.dart';
import '../../../../../generated/app_assets.dart';

class FilterBox extends StatefulWidget {
  const FilterBox({super.key});

  @override
  State<FilterBox> createState() => _FilterBoxState();
}

class _FilterBoxState extends State<FilterBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        GlobalUiUtils.showBottomSheet(context, child: Column(
          children: [
            Text("تصنيف حسب", style: context.textStyles.font16SemiBoldSecondaryColor),
            25.verticalSizedBox,
            Align(
              alignment: Alignment.centerRight,
              child: Text("حسب التاريخ * ", style: context.textStyles.font14BoldSecondaryColor, textAlign: TextAlign.start,)),
              16.verticalSizedBox,
            Row(children: [
              Expanded(child: CustomTextFieldWithLabel(label: "من", hintText: "dd/mm/yy",enabled:false ,)),
              12.horizontalSpace,
              Expanded(child: CustomTextFieldWithLabel(label: "إلى", hintText: "dd/mm/yy",enabled:false ,)),

            ],),
            48.verticalSizedBox,
            Align(
              alignment: Alignment.centerRight,
              child: Text("حسب حالة الطلب * ", style: context.textStyles.font16SemiBoldSecondaryColor)),
            16.verticalSizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CheckItem(title: "الكل",),
                CheckItem(title: "في انتظار القبول"),
              ],
            ).onlyPadding(
              leftPadding: 50
            ),
            12.verticalSizedBox,
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CheckItem(title: "قيد التنفيذ",),
                CheckItem(title: "تم التسليم "),
              ],
            ).onlyPadding(
              leftPadding: 82
            ),
            12.verticalSizedBox, Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CheckItem(title: "معلق",),
                CheckItem(title: "ملغي "),
              ],
            ).onlyPadding(
              leftPadding: 114
            ),
            44.verticalSizedBox,
            MainButton(title: "تم", onTap: (){
              context.pop();
            })


          ],
        ));
      },
      child: Container(
        padding: 12.allPadding,
        decoration: BoxDecoration(
          color: context.colors.whiteColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: context.colors.whiteColor.withValues(alpha: 0.22), width: 1),
          
        ),
        child: CustomSvgBuilder(path: AppAssets.svgsFilterIcon, width: 24, height: 24, fit: BoxFit.scaleDown),
      ),
    );
  }
}

class CheckItem extends StatefulWidget {
  const CheckItem({
    super.key, required this.title,
  });
  final String title;

  @override
  State<CheckItem> createState() => _CheckItemState();
}
class _CheckItemState extends State<CheckItem> {
bool isChecked=false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: (){
            setState(() {
              isChecked=!isChecked;
            });
          },
          child: Image.asset( isChecked?AppAssets.imagesCheckBoxMarked:AppAssets.imagesEmptyCheckBox, width: 24, height: 24),),
          6.horizontalSizedBox,
          Text(widget.title, style: context.textStyles.font14SemiBoldSecondaryColor),
      ],
    );
  }
}