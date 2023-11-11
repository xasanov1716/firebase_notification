class NotificationModel{

  final String ntitle;
  final String nbody;

  NotificationModel({required this.ntitle,required this.nbody});


  factory NotificationModel.fromJson(Map<String, dynamic> json){
    return NotificationModel(ntitle: json['ntitle'], nbody: json['nbody']);
  }
}


class DataModel{
  final String title;
  final String description;
  final  String image;

  DataModel({required  this.title,required  this.description,required this.image});


  factory DataModel.fromJson(Map<String, dynamic> json){
    return DataModel(title: json['title'], description: json['description'], image: json['image']);
  }

}