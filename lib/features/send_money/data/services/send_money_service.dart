
import 'package:injectable/injectable.dart';

import '../../presentation/cubit/send_money_state.dart';
import '../models/send_money_form_data.dart';

@injectable
class SendMoneyFormService {
  ValidationResult validateForm(SendMoneyFormData formData) {
    final errors = <String>[];

    // Validate sender info
    _validatePhone(formData.senderPhone, 'Sender phone', errors);
    _validateName(formData.senderName, 'Sender name', errors);

    // Validate receiver info
    _validatePhone(formData.receiverPhone, 'Receiver phone', errors);
    _validateName(formData.receiverName, 'Receiver name', errors);
    _validateRequired(formData.receiverAddress, 'Receiver address', errors);

    // Validate amount details
    _validateRequired(formData.amount, 'Amount', errors);
    if (formData.amount.isNotEmpty && double.tryParse(formData.amount) == null) {
      errors.add('Please enter a valid amount');
    }
    
    _validateRequired(formData.amountByChar, 'Amount in words', errors);
    
    // Validate selections
    if (formData.fromCurrency == null) {
      errors.add('Please select from currency');
    }
    if (formData.toCurrency == null) {
      errors.add('Please select to currency');
    }
    if (formData.fromBranch == null) {
      errors.add('Please select from branch');
    }
    if (formData.toBranch == null) {
      errors.add('Please select to branch');
    }
    if (formData.commissionType == null) {
      errors.add('Please select commission type');
    }
    if (formData.paymentMethodId == null) {
      errors.add('Please select payment method');
    }

    // Validate denominations
    if (formData.denominations.isEmpty) {
      errors.add('Please select denominations');
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  void _validateRequired(String value, String fieldName, List<String> errors) {
    if (value.isEmpty) {
      errors.add('Please enter $fieldName');
    }
  }

  void _validatePhone(String phone, String fieldName, List<String> errors) {
    if (phone.isEmpty) {
      errors.add('Please enter $fieldName');
    } else if (!_isValidPhone(phone)) {
      errors.add('Please enter a valid $fieldName');
    }
  }

  void _validateName(String name, String fieldName, List<String> errors) {
    if (name.isEmpty) {
      errors.add('Please enter $fieldName');
    } else if (name.length < 2) {
      errors.add('$fieldName must be at least 2 characters');
    }
  }

  bool _isValidPhone(String phone) {
    // Add your phone validation logic here
    return phone.length >= 10;
  }


}