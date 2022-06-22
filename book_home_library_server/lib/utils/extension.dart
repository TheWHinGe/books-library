extension CustomInt on int {
  bool toBool() {
    // ignore: avoid_bool_literals_in_conditional_expressions
    return this == 0 ? false : true;
  }
}
