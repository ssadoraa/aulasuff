import Produto from "../interfaces/produto";
import { Link } from "react-router-dom";
import '../css/geral.css';

interface Props {
  produtos: Produto[];
}

const TabelaDeProdutos = ({ produtos }: Props) => {
  return (
    <table className="table table-responsive table-sm table-hover table-bordered">
      <thead>
        <tr>
          <th className="align-middle text-center">Id</th>
          <th className="align-middle text-center">Imagem</th>
          <th className="align-middle text-center">Categoria</th>
          <th className="align-middle text-center">Nome</th>
          <th className="align-middle text-center">Condição</th>
          <th className="align-middle text-center">Status</th>
          <th className="align-middle text-center">Ação</th>
        </tr>
      </thead>
      <tbody>
        {produtos.map((produto) => (
          <tr key={produto.id}>
            <td width="8%" className="align-middle text-center">{produto.id}</td>
            <td width="12%" className="align-middle text-center"><img src={produto.imagem} width={45} /></td>
            <td width="12%" className="align-middle text-center">{produto.categoria.nome}</td>
            <td width="28%" className="align-middle text-center">{produto.nome}</td>
            <td width="8%" className="align-middle text-center">{produto.condicao}</td>
            <td width="12%" className="align-middle text-center">{produto.status}</td>
            <td width="8%" className="align-middle text-center">
              <Link className="btn btn-danger btn-sm" to={`/ver/${produto.id}`}>Ver</Link>
            </td>
          </tr>
        ))}
      </tbody>
    </table>
  );
};
export default TabelaDeProdutos;
