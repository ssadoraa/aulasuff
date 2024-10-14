class Animal {
  String? cor;

  Animal(this.cor);

  void correr() {
    print("Correr");
  }
}

class Gato extends Animal {
  String? corFocinho;

  // Gato(String cor, String corFocinho) {
  //   this.cor = cor;
  //   this.corFocinho = corFocinho;
  // }

  Gato(String cor, this.corFocinho) : super(cor);

  // Gato.corAmarelo() {
  //   this.cor = "Amarelo";
  // }

  Gato.corCompleto({String? cor = "Amarelo", String? focinho = "Branco"})
      : super(cor) {
    this.corFocinho = focinho;
  }

  void miar() {
    print("Miar!");
  }
}

class Passaro extends Animal {
  String? corBico;

  Passaro(cor, this.corBico) : super(cor);

  void piar() {
    print("Piar");
  }
}

void main() {
  // Gato gt1 = new Gato();
  // Gato gt2 = Gato();

  // gt1.cor = "Amarelo";
  // gt1.corFocinho = "Marron";

  // gt2.cor = "Preto";
  // gt2.corFocinho = "Branco";

  Gato gt1 = new Gato("Amarelo", "Marron");
  Gato gt2 = Gato("Preto", "Branco");

  print("Cor: ${gt1.cor}, Focinho: ${gt1.corFocinho}");
  print("Cor: ${gt2.cor}, Focinho: ${gt2.corFocinho}");

  // Gato gt3 = Gato.corAmarelo();
  // print("Cor: ${gt3.cor}, Focinho: ${gt3.corFocinho}");

  Gato gt4 = Gato.corCompleto();
  print("Cor: ${gt4.cor}, Focinho: ${gt4.corFocinho}");

  Gato gt5 = Gato.corCompleto(cor: "Cinza", focinho: "Preto");
  print("Cor: ${gt5.cor}, Focinho: ${gt5.corFocinho}");

  gt5.miar();
  gt5.correr();

  Passaro p1 = Passaro("Amarelo", "Preto");
  print("Cor: ${p1.cor}, Bico: ${p1.corBico}");

  p1.piar();
  p1.correr();
}
