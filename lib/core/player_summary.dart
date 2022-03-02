class PlayerSummary{
  String summaryCategory;
  String categoryValue;

  PlayerSummary(this.summaryCategory, this.categoryValue);

  @override
  String toString() {
    return "{ " + summaryCategory + ", " + categoryValue + " }";
  }
}