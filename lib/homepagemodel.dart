class Homepagemodel {
  final List<BannerModel> bannerOne;
  final List<Category> category;
  final List<Product> products;

  Homepagemodel({
    required this.bannerOne,
    required this.category,
    required this.products,
  });

  factory Homepagemodel.fromJson(Map<String, dynamic> json) {
    return Homepagemodel(
      bannerOne: (json['banner_one'] as List<dynamic>?)
          ?.map((item) => BannerModel.fromJson(item as Map<String, dynamic>))
          .toList() ??
          [],
      category: (json['category'] as List<dynamic>?)
          ?.map((item) => Category.fromJson(item as Map<String, dynamic>))
          .toList() ??
          [],
      products: (json['products'] as List<dynamic>?)
          ?.map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}

class BannerModel {
  final String banner;

  BannerModel({required this.banner});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      banner: json['banner'] ?? '', // Provide default value if null
    );
  }
}

class Category {
  final String label;
  final String icon;

  Category({required this.label, required this.icon});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      label: json['label'] ?? '', // Provide default value if null
      icon: json['icon'] ?? '', // Provide default value if null
    );
  }
}

class Product {
  final String icon;
  final String offer;
  final String label;
  final String? subLabel;

  Product({
    required this.icon,
    required this.offer,
    required this.label,
    this.subLabel,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      icon: json['icon'] ?? '', // Provide default value if null
      offer: json['offer'] ?? '', // Provide default value if null
      label: json['label'] ?? '', // Provide default value if null
      subLabel: json['SubLabel'] ?? json['Sublabel'], // Handle both possible key names
    );
  }
}
