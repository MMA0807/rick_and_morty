String prefixToUpperCase(String? value) {
  if (value != null && value.isNotEmpty) {
    return "${value[0].toUpperCase()}${value.substring(1)}";
  } else {
    return '';
  }
}
