import { useParams } from "react-router-dom";
import useProdutosPorSlugDaCategoria from "../../hooks/produtos/useProdutosPorSlugDaCategoria";
import Card from "../../components/Card";

const CardsDeProdutos = () => {
  const { slug } = useParams();
  console.log(slug);
  const {
    data: produtos,
    isPending: carregandoProdutos,
    error: errorprodutos,
  } = useProdutosPorSlugDaCategoria(slug);

  if (carregandoProdutos) return <h6>Carregando...</h6>;
  if (errorprodutos) throw errorprodutos;

  return (
    <>
      <h5 className="mb-4">{slug ? slug.charAt(0).toUpperCase() + slug.slice(1) : "Produtos"}</h5>
      <div className="row">
        {produtos?.map((produto) => (
          <div className="col-lg-2 col-md-3 col-sm-4 col-6 mb-4">
            <Card
              imagem={produto.imagem}
              titulo={produto.nome}
              descricao={produto.condicao}
              preco={produto.valorEstimado.toLocaleString("pt-BR", {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2,
                useGrouping: true
              })}
              footer={<input type="button" className="btn btn-primary btn-sm w-100" value="Adicionar" />}
            />
          </div>
        ))}
      </div>
    </>
  );
};
export default CardsDeProdutos;
