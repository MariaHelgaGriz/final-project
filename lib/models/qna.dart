class Qna {
  final String reviewForm;
  final String review;

  Qna({required this.reviewForm, required this.review});

  factory Qna.fromJson(Map<String, dynamic> json) => Qna(
        reviewForm: json['reviewForm'],
        review: json['review'],
      );
}