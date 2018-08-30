import 'dart:convert';

class Model {
  final String name;
  final String height;
  final String mass;
  final String hair_color;
  final String skin_color;
  final String eye_color;
  final String birth_year;
  final String gender;

  Model(this.name, this.height, this.mass, this.hair_color, this.birth_year, this.eye_color,this.gender, this.skin_color);

  Model.fromJson(Map<String, dynamic> json)
      :name = json['name'],
       birth_year = json['birth_year'],
       height = json['height'],
       mass = json['mass'],
       hair_color = json['hair_color'],
       skin_color = json['skin_color'],
       eye_color = json['eye_color'],
       gender = json['gender'];

  Map<String, dynamic> toJson() =>
  {
    'name' : name,
    'height' : height,
    'mass' : mass,
    'hair_color' : hair_color,
    'skin_color' : skin_color,
    'eye_color' : eye_color,
    'birth_year' : birth_year,
    'gender' : gender,
  };

}