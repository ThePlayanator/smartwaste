class Bin{
  String bin_id;
  String alias;
  String user_id;

  Bin({
    this.bin_id= '',
    required this.alias,
    required this.user_id,
  });

  Map<String, dynamic> toJson()=>{
    'id' : bin_id,
    'alias' : alias,
    'user_id' : user_id,
  };
}