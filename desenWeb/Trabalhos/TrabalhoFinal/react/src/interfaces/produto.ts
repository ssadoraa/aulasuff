import Categoria from "./categoria";

interface Produto {
  id: number;
  nome: string;
  descricao: string;
  categoria: Categoria;
  condicao: string;
  valorEstimado: number;
  status: string;
  imagem: string;
}
export default Produto;
