// class ApiProvider{
//
//
//   Future<UniversalResponse> addProduct(String  product) async {
//     Uri url = Uri.parse('$baseUrl/products');
//     try {
//       final response = await http.post(
//         url,
//         body: jsonEncode(product.toJson()),
//       );
//       if (response.statusCode == 200) {
//         return UniversalResponse(
//           data: ProductModel.fromJson(jsonDecode(response.body)),
//         );
//       }
//       return UniversalResponse(error: 'Error: Status code not equal to 200');
//     } catch (e) {
//       return UniversalResponse(error: e.toString());
//     }
//   }
//
// }