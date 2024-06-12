class BlocFormItem {
  final String hintText;
  final String labelText;
  final String value;
  final String? error;
  const BlocFormItem(
      {this.hintText = "", this.labelText = "", this.value = "", this.error});

  BlocFormItem copyWith(
      {String? hintText, String? labelText, String? value, String? error}) {
    return BlocFormItem(
      hintText: hintText ?? this.hintText,
      labelText: labelText ?? this.labelText,
      value: value ?? this.value,
      error: error ?? this.error,
    );
  }
}
