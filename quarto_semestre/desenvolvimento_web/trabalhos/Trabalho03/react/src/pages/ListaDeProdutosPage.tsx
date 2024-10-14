import { useState } from "react";
import TabelaDeProdutos from "../components/TabelaDeProdutos";
import useProdutosComPaginacao from "../hooks/produtos/useProdutosComPaginacao";
import Paginacao from "../components/Paginacao";

const ListaDeProdutosPage = () => {
  const [pagina, setPagina] = useState(0);
  const tamanho = 5;

  const tratarPaginacao = (pagina: number) => {
    setPagina(pagina);
  };

  const {
    data: resultadoPaginado,
    isPending: carregandoProdutos,
    error: errorProdutos,
  } = useProdutosComPaginacao(pagina, tamanho);

  if (carregandoProdutos) return <h6>Carregando...</h6>;
  if (errorProdutos) throw errorProdutos;

  const produtos = resultadoPaginado.itens;
  const totalDePaginas = resultadoPaginado.totalDePaginas;

  return (
    <div className="container mt-5">
      <h4>Lista de Produtos</h4>
      <hr className="mt-1" />
      <TabelaDeProdutos produtos={produtos} />
      <Paginacao
        pagina={pagina}
        totalDePaginas={totalDePaginas}
        tratarPaginacao={tratarPaginacao}
      />
    </div>
  );
};
export default ListaDeProdutosPage;
