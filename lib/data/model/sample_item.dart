class SampleItem {
  const SampleItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    this.imageUrl,
  });

  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String? imageUrl;

  factory SampleItem.fromJson(Map<String, dynamic> json) {
    return SampleItem(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      subtitle: json['subtitle']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? json['image_url']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
