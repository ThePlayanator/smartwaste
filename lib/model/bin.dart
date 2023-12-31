class Bin{
  String bin_id;
  String alias;

  Bin({
    this.bin_id= '',
    required this.alias,
  });

  Map<String, dynamic> toJson()=>{
    'id' : bin_id,
    'alias' : alias,
  };
}