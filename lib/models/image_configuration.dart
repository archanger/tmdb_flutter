class ImageConfiguration {
  // @BuiltValueField(wireName: 'secure_base_url')
  final String baseUrl;

  // @BuiltValueField(wireName: 'backdrop_sizes')
  final List<String> backdropSizes;

  // @BuiltValueField(wireName: 'logo_sizes')
  final List<String> logoSizes;

  // @BuiltValueField(wireName: 'poster_sizes')
  final List<String> posterSizes;

  // @BuiltValueField(wireName: 'profile_sizes')
  final List<String> profileSizes;

  // @BuiltValueField(wireName: 'still_sizes')
  final List<String> stillSizes;

  ImageConfiguration(
    this.baseUrl,
    this.backdropSizes,
    this.logoSizes,
    this.posterSizes,
    this.profileSizes,
    this.stillSizes,
  );
}

extension ImageConfigurationAdditions on ImageConfiguration {
  static ImageConfiguration empty() {
    return ImageConfiguration(
      "",
      [],
      [],
      [],
      [],
      [],
    );
  }
}
