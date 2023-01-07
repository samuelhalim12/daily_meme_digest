
class Meme {
  int id;
  String pic_url;
  String teks_atas;
  String teks_bawah;
  String author_id;
  int like_count;

  Meme({required this.id, required this.pic_url,required this.teks_atas, required this.teks_bawah,required this.author_id, required this.like_count});
  factory Meme.fromJson(Map<String, dynamic> json) {
    return Meme(
      id: json['id'] as int,
      pic_url: json['pic_url'] as String,
      teks_atas: json['teks_atas'] as String,
      teks_bawah: json['teks_bawah'] as String,
      author_id: json['author_id'] as String,
      like_count: json['like_count'] as int
    );
  }
}

