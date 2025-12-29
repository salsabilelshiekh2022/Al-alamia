import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/components/widgets/custom_text_field.dart';
import '../../../../../core/helper/app_extention.dart';
import '../../../../../core/helper/number_extentions.dart';
import '../../../../../core/helper/translation_extensions.dart';


class ChatSupportBottomSheet extends StatefulWidget {
  const ChatSupportBottomSheet({super.key});

  @override
  State<ChatSupportBottomSheet> createState() =>
      _ChatSupportBottomSheetState();
}

class _ChatSupportBottomSheetState extends State<ChatSupportBottomSheet> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
      color: Colors.white,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomTextField(
              controller: controller,
              hintText: context.type,
              minLines: 1,  
              maxLines: 5,
            ),
          ),
          12.horizontalSizedBox,
          InkWell(  
            onTap: () {
              if (controller.text.isNotEmpty) {
                controller.clear();
              } else {}
            },
            child: Container(
              width: 48.w,
              height: 48.h,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: context.colors.primaryColor,
                borderRadius: 12.allBorderRadius,
              ),
              child: SvgPicture.asset(
                AppAssets.svgsSend,
                width: 25.w,
                height: 25.h,
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                  context.colors.whiteColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}