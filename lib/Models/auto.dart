class Auto{
  int? id;
  final String patente;
  final String marca;
  final int precio;


  Auto({
    this.id,
    required this.patente,
    required this.marca,
    required this.precio,
  });

  ///formato (Map) para utilizar en la base de datos
  Map<String, dynamic> toMap(){
    return { 'id':id, 'patente':patente, 'marca':marca, 'precio':precio };
    //return { 'patente':patente, 'marca':marca, 'precio':precio };
  }

  // Implement toString to make it easier to see information about
  // each auto when using the print statement.
  @override
  String toString() {
    return 'Auto{ patente: $patente, marca: $marca, precio: $precio }';
  }
}