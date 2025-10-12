class ImageConstants {
  ///base file location of images folder
  static const String _basePath = "assets/images/";

  ///image files extension
  static const String _imgExtension = ".png";

  ///private static method for generating image path
  static String _imagePath(String fileName) =>
      _basePath + fileName + _imgExtension;

  static String loginCover = _imagePath("login_cover");
}
