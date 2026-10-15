import 'sample_item.dart';

class PaginatedSampleItems {
  const PaginatedSampleItems({
    required this.items,
    required this.page,
    required this.hasMore,
  });

  final List<SampleItem> items;
  final int page;
  final bool hasMore;
}
