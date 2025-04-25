// Class to hold filter criteria
class FilterCriteria {
  final String? category;

  FilterCriteria({
    this.category,
  });

  FilterCriteria copyWith({
    String? category,
  }) {
    return FilterCriteria(
      category: category ?? this.category,
    );
  }

  bool isEmpty() {
    return category == null;
  }
}
