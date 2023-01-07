
class Meme {
  int id;
  String pic_url;
  String teks_atas;
  String teks_bawah;
  int author_id;
  int like_count;
  String? firstname;
  String? lastname;
  String? comment_date;
  String? content;

  Meme({required this.id, required this.pic_url,required this.teks_atas, required this.teks_bawah,required this.author_id, required this.like_count,
  this.firstname, this.lastname, this.comment_date, this.content
  });
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
      comment_date: json['comment_date'],
      content: json['content'],
    );
  }
}

