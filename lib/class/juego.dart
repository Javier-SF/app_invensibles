class CardModel {
  final String icon;
  bool isFaceUp;
  bool isMatched;

  CardModel({
    required this.icon,
    this.isFaceUp = false,
    this.isMatched = false,
  });
}
