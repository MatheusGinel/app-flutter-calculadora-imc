class IMC {
  // ignore: prefer_final_fields
  double _peso = 0.0;
  // ignore: prefer_final_fields
  double _altura = 0.0;

  IMC(this._peso, this._altura);

  double get peso => _peso;

  set peso(peso) {
    _peso = peso;
  }

  double get altura => _altura;

  set altura(altura) {
    _altura = altura;
  }

  double calcularIMC() {
    return peso / (altura * altura);
  }
}
