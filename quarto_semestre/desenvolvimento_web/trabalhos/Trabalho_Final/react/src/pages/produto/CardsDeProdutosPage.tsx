import "../../css/geral.css";
import { useParams } from "react-router-dom";
import Card from "../../components/Card";
import useProdutosPaginadosPorSlugDaCategoria from "../../hooks/produto/useProdutosPaginadosPorSlugDaCategoria";
import InfiniteScroll from "react-infinite-scroll-component";
import { useContext } from "react";
import { CarrinhoContext } from "../../context/carrinhoContext";

const CardsDeProdutosPage = () => {
  const { slug } = useParams();
  const tamanho = 12;
  const {
    data,
    isPending: carregandoProdutos,
    error: errorprodutos,
    hasNextPage,
    fetchNextPage,
  } = useProdutosPaginadosPorSlugDaCategoria({ tamanho, slug });

  const carrinhoContext = useContext(CarrinhoContext);

  if (carregandoProdutos) return <h6>Carregando...</h6>;
  if (errorprodutos) throw errorprodutos;

  return (
    <InfiniteScroll
      dataLength={data.pages.reduce(
        (total, page) => total + page.itens.length,
        0
      )}
      hasMore={hasNextPage}
      next={() => fetchNextPage()}
      loader={<h6>Carregando...</h6>}
    >
      <h5>
        {slug ? slug.charAt(0).toUpperCase() + slug.slice(1) : "Produtos"}
      </h5>
      <div className="row mb-3">
        {data.pages.map((page) =>
          page.itens.map((produto) => (
            <div
              key={produto.id}
              className="col-lg-2 col-md-3 col-sm-4 col-6 mb-3"
            >
              <Card
                id={produto.id}
                imagem={produto.imagem}
                titulo={produto.nome}
                descricao={produto.condicao}
                valorEstimado={produto.valorEstimado.toLocaleString("pt-BR", {
                  minimumFractionDigits: 2,
                  maximumFractionDigits: 2,
                  useGrouping: true,
                })}
                footer={
                  <input
                    type="button"
                    className="btn btn-success btn-sm w-100"
                    value="Adicionar"
                    onClick={() => carrinhoContext?.adicionarAoCarrinho(produto)}
                  />
                }
              />
            </div>
          ))
        )}
      </div>
    </InfiniteScroll>
  );
};
export default CardsDeProdutosPage;
