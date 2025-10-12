class AppRegExp {
  static RegExp _baseRegExp(String regExp) => RegExp(regExp);
  static RegExp get email => _baseRegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static RegExp get pwd => _baseRegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );
}
