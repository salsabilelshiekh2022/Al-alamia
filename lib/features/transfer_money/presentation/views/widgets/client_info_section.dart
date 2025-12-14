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

/// Callback type for when client info changes.
typedef OnClientInfoChanged = void Function(String phone, String name);

class ClientInfoSection extends StatefulWidget {
  const ClientInfoSection({super.key, required this.onClientInfoChanged});

  /// Callback that fires when phone or name changes.
  final OnClientInfoChanged onClientInfoChanged;

  @override
  State<ClientInfoSection> createState() => ClientInfoSectionState();
}

class ClientInfoSectionState extends State<ClientInfoSection> {
  late TextEditingController phoneController;
  late TextEditingController nameController;

  /// Returns the current phone value.
  String get phone => phoneController.text;

  /// Returns the current name value.
  String get name => nameController.text;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    nameController = TextEditingController();

    // Listen to changes and notify parent
    phoneController.addListener(_notifyParent);
    nameController.addListener(_notifyParent);
  }

  @override
  void dispose() {
    phoneController.removeListener(_notifyParent);
    nameController.removeListener(_notifyParent);
    phoneController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void _notifyParent() {
    widget.onClientInfoChanged(
      phoneController.text.trim(),
      nameController.text.trim(),
    );
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
        final isLoadingUser = state.getUserByPhoneStatus.isLoading;

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
              Stack(
                children: [
                  CustomTextFieldWithLabel(
                    controller: nameController,
                    label: context.clientName,
                    hintText: context.clientNameHint,
                    isRequired: true,
                    prefixWidget: AppAssets.svgsUser,
                    keyboardType: TextInputType.name,
                    validator: (val) => Validator.validateName(val, context),
                  ),
                  if (isLoadingUser)
                    Positioned(
                      right: 16,
                      top: 40,
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: context.colors.primaryColor,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
