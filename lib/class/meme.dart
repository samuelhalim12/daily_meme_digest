class Meme {
  int? id;
  String? pic_url;
  String? teks_atas;
  String? teks_bawah;
  int? author_id;
  int? like_count;
  String? firstname;
  String? lastname;
  String? prof_pic_url;
  String? comment_date;
  String? content;
  int? privacy;

  Meme(
      {this.id,
      this.pic_url,
      this.teks_atas,
      this.teks_bawah,
      this.author_id,
      this.like_count,
      this.firstname,
      this.lastname,
      this.prof_pic_url,
      this.comment_date,
      this.content,
      this.privacy});
  factory Meme.fromJson(Map<String, dynamic> json) {
    return Meme(
        id: json['id'] as int,
        pic_url: json['pic_url'] as String,
        teks_atas: json['teks_atas'] as String,
        teks_bawah: json['teks_bawah'] as String,
        author_id: json['author_id'] as int,
        like_count: json['like_count'] as int,
        firstname: json['firstname'],
        lastname: json['lastname'],
        prof_pic_url: json['prof_pic_url'],
        comment_date: json['comment_date'],
        content: json['content'],
        privacy: json['privacy']);
  }
}
