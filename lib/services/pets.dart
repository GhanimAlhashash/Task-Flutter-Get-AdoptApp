import 'package:adopt_app/models/pet.dart';
import "package:dio/dio.dart";

class DioClient {
  final Dio _dio = Dio();
  final _baseUrl = "https://coded-pets-api-crud.eapi.joincoded.com/";

  Future<List<Pet>> getPets() async {
    List<Pet> pets = [];
    try {
      Response response =
          await _dio.get("https://coded-pets-api-crud.eapi.joincoded.com/pets");
      pets = (response.data as List).map((pet) => Pet.fromJson(pet)).toList();
    } on DioError catch (error) {
      print(error);
    }
    return pets;
  }

//petservice
  Future<Pet> createPet({required Pet pet}) async {
    late Pet retrievedPet;
    try {
      FormData data = FormData.fromMap({
        "Name": pet.name,
        "Age": pet.age,
        "Gender": pet.gender,
        "image":
            "" /*await MultipartFile.fromFile(
          pet.image,
        )*/
        ,
      });
      Response response = await _dio.post(_baseUrl + '/pets', data: data);
      // response.data
      print(response.data['name']);
      retrievedPet = Pet.fromJson(response.data);
    } on DioError catch (error) {
      print(error);
    }
    return retrievedPet;
  }

  Future<Pet> updatePet({required Pet pet}) async {
    late Pet retrievedPet;
    try {
      FormData data = FormData.fromMap({
        "Name": pet.name,
        "Age": pet.age,
        "Gender": pet.gender,
        "image": await MultipartFile.fromFile(
          pet.image,
        ),
      });
      Response response =
          await _dio.put(_baseUrl + '/pets/${pet.id}', data: data);
      retrievedPet = Pet.fromJson(response.data);
    } on DioException catch (error) {
      print(error);
    }
    return retrievedPet;
  }
}
