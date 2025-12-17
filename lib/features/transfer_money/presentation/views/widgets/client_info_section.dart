import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/general/cubit/general_cubit.dart';
import 'package:alalamia/core/general/cubit/general_state.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../generated/app_assets.dart';

class ClientInfoSection extends StatefulWidget {
  const ClientInfoSection({super.key});

  @override
  State<ClientInfoSection> createState() => _ClientInfoSectionState();
}

class _ClientInfoSectionState extends State<ClientInfoSection> {
  late TextEditingController phoneController;
  late TextEditingController nameController;

  @override
  void initState() {
    phoneController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralCubit, GeneralState>(
      listener: (context, state) {
        if (state.getUserByPhoneStatus.isSuccess) {
          nameController.text = state.userByPhone?.name ?? '';
        } else if (state.getUserByPhoneStatus.isError) {
          nameController.text = '';
        }
      },
      builder: (context, state) {
        return CardWithPurpleShadow(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.clientInfo,
                style: context.textStyles.font18SemiBoldSecondaryColor,
              ),
              12.verticalSizedBox,
              CustomTextFieldWithLabel(
                controller: phoneController,
                label: context.phone,
                hintText: context.phoneHint,
                isRequired: true,
                prefixWidget: AppAssets.svgsPhone,
                keyboardType: TextInputType.phone,
                onChanged: (val) {
                  context.read<GeneralCubit>().getUserByPhone(
                    phone: val.trim(),
                  );
                },
                validator: (val) => Validator.validatePhone(val, context),
              ),
              16.verticalSizedBox,
              CustomTextFieldWithLabel(
                controller: nameController,
                label: context.clientName,
                hintText: context.clientNameHint,
                isRequired: true,
                prefixWidget: AppAssets.svgsUser,
                keyboardType: TextInputType.phone,
                validator: (val) => Validator.validateName(val, context),
              ),
            ],
          ),
        );
      },
    );
  }
}