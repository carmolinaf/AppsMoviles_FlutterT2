import 'package:http/http.dart' as http;

class UsuariosServices{
static const link= "https://0732-190-95-124-31.ngrok.io";
Future<String?> validarUsuario( String login, String password) async{
    final url = Uri.parse(link +"/api/Usuarios?login=$login&password=$password");
    var result = await http.get(url);

    if (result.statusCode==200){
      return result.body;
    }else{
      return null;
    }
  }

}