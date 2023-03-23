class ShopLoginModel
{
  bool? status;
  String? message;
  Userdata? data;

  ShopLoginModel.formJasn(Map<String , dynamic>jason)
  {
    status = jason['status'];
    message = jason['message'];
    data = jason['data'] != null ? Userdata.formJasn(jason['data']): null;
  }
}
class Userdata
{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

//   Userdata({
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//     this.image,
//     this.points,
//     this.credit,
//     this.token,
// });

  Userdata.formJasn(Map<String , dynamic>jason)
  {
      id = jason['id'];
      name = jason['name'];
      email = jason['email'];
      phone = jason['phone'];
      image = jason['image'];
      points = jason['points'];
      credit = jason['credit'];
      token = jason['token'];
  }
}
