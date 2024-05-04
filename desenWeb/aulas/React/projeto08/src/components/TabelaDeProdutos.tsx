import dayjs from "dayjs";
import Produto from "../interfaces/produto";

interface Props {
  produtos: Produto[];
}

const TabelaDeProdutos = ({ produtos }: Props) => {
  // console.log(produtos[0].nome);
  return (
    <table className="table table-responsive table-sm table-hover table-bordered">
      <thead>
        <tr>
          <th className="align-middle text-center">Id</th>
          <th className="align-middle text-center">Imagem</th>
          <th className="align-middle text-center">Categoria</th>
          <th className="align-middle text-center">Nome</th>
          <th className="align-middle text-center">Disponível</th>
          <th className="align-middle text-center">Data de Cadastro</th>
          <th className="align-middle text-center">Preço</th>
          <th className="align-middle text-center">Ação</th>
        </tr>
      </thead>
      <tbody>
        {produtos.map((produto) => (
          <tr key={produto.id}>
            <td width="8%" className="align-middle text-center">{produto.id}</td>
            <td width="12%" className="align-middle text-center"><img src={produto.imagem} width={45} /></td>
            <td width="12%" className="align-middle text-center">{produto.categoria.nome}</td>
            <td width="20%" className="align-middle">{produto.nome}</td>
            <td width="12%" className="align-middle text-center">{produto.disponivel ? "Sim" : "Não"}</td>
            <td width="12%" className="align-middle text-center">{dayjs(produto.dataCadastro).format("DD/MM/YYYY")}</td>
            <td width="12%" className="align-middle text-end pe-3">{produto.preco.toLocaleString("pt-BR", {
              minimumFractionDigits: 2,
              maximumFractionDigits: 2,
              useGrouping: true
            })}</td>
            <td width="12%" className="align-middle text-center"><button className="btn btn-danger btn-sm">Remover</button></td>
          </tr>
        ))}
      </tbody>
    </table>
  );
};
export default TabelaDeProdutos;
