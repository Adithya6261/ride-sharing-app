class Validators {
  static String? requiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? amount(String? value) {
    if (value == null || value.isEmpty) return 'Enter amount';
    final parsed = double.tryParse(value);
    if (parsed == null || parsed <= 0) {
      return 'Invalid amount';
    }
    return null;
  }
}
