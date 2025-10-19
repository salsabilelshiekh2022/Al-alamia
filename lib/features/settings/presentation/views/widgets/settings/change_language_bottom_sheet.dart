import 'package:alalamia/core/components/widgets/custom_svg_builder.dart';
import 'package:alalamia/core/enums/language_enum.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/components/widgets/main_button.dart';

class ChangeLanguageBottomSheet extends StatefulWidget {
  const ChangeLanguageBottomSheet({super.key});

  @override
  State<ChangeLanguageBottomSheet> createState() =>
      _ChangeLanguageBottomSheetState();
}

class _ChangeLanguageBottomSheetState extends State<ChangeLanguageBottomSheet> {
  late LanguageEnum selectedLanguage;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      // Initialize with current app language
      selectedLanguage = context.locale.languageCode == 'ar'
          ? LanguageEnum.arabic
          : LanguageEnum.english;
      _isInitialized = true;
    }
  }

  void _onLanguageSelected(LanguageEnum language) {
    setState(() {
      selectedLanguage = language;
    });
  }

  Future<void> _saveLanguage() async {
    // Change app locale based on selected language
    final locale = selectedLanguage == LanguageEnum.arabic
        ? const Locale('ar')
        : const Locale('en');

    await context.setLocale(locale);

    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.language,
          style: context.textStyles.font16SemiBoldSecondaryColor,
        ),
        8.verticalSizedBox,
        Text(
          context.chooseLanguage,
          style: context.textStyles.font15RegularGrayColor,
        ),
        32.verticalSizedBox,
        Row(
          children: [
            Expanded(
              child: _LanguageCard(
                flagPath: AppAssets.svgsArabicFlag,
                language: LanguageEnum.arabic,
                isSelected: selectedLanguage == LanguageEnum.arabic,
                onTap: () => _onLanguageSelected(LanguageEnum.arabic),
              ),
            ),
            16.horizontalSizedBox,
            Expanded(
              child: _LanguageCard(
                flagPath: AppAssets.svgsEnglishFlag,
                language: LanguageEnum.english,
                isSelected: selectedLanguage == LanguageEnum.english,
                onTap: () => _onLanguageSelected(LanguageEnum.english),
              ),
            ),
          ],
        ),
        40.verticalSizedBox,
        MainButton(title: context.save, onTap: _saveLanguage),
        32.verticalSizedBox,
      ],
    );
  }
}

class _LanguageCard extends StatelessWidget {
  final String flagPath;
  final LanguageEnum language;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.flagPath,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isSelected
                ? BorderSide(color: context.colors.primaryColor)
                : BorderSide.none,
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 48,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            CustomSvgBuilder(path: flagPath, width: 40, height: 32),
            16.verticalSizedBox,
            Text(
              language.translate(context),
              style: context.textStyles.font16SemiBoldSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
