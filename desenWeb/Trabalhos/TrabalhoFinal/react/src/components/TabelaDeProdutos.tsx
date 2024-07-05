import Produto from "../interfaces/produto";
import { Link } from "react-router-dom";
import '../css/geral.css';
import useRemoverProduto from "../hooks/produtos/useRemoverProduto";

interface Props {
  produtos: Produto[];
}

const TabelaDeProdutos = ({ produtos }: Props) => {
  const { mutate: excluirProduto } = useRemoverProduto();

  const handleExcluirProduto = (id?: number) => {
    if (id && window.confirm("Tem certeza que deseja excluir este produto?")) {
      excluirProduto(id);
    }
  };

  return (
    <table className="table table-responsive table-sm table-hover table-bordered">
      <thead>
        <tr>
          <th className="align-middle text-center">Id</th>
          <th className="align-middle text-center">Categoria</th>
          <th className="align-middle text-center">Nome</th>
          <th className="align-middle text-center">Status</th>
          <th className="align-middle text-center">Ação</th>
        </tr>
      </thead>
      <tbody>
        {produtos.map((produto) => (
          <tr key={produto.id}>
            <td width="8%" className="align-middle text-center">{produto.id}</td>
            <td width="12%" className="align-middle text-center">{produto.categoria.nome}</td>
            <td width="28%" className="align-middle text-center">{produto.nome}</td>
            <td width="12%" className="align-middle text-center">{produto.status}</td>
            <td width="8%" className="align-middle text-center">
              <div className="dropdown">
                <button className="btn btn-info btn-sm text-white dropdown-toggle" type="button" id={`dropdownMenuButton${produto.id}`} data-bs-toggle="dropdown" aria-expanded="false">
                  Ações
                </button>
                <ul className="dropdown-menu" aria-labelledby={`dropdownMenuButton${produto.id}`}>
                  <li><Link className="dropdown-item" to={`/ver/${produto.id}`}>Ver</Link></li>
                  <li><Link className="dropdown-item" to={`/editar/${produto.id}`}>Editar</Link></li>
                  <li><button className="dropdown-item" onClick={() => handleExcluirProduto(produto.id)}>Excluir</button></li>
                </ul>
              </div>
            </td>
          </tr>
        ))}
      </tbody>
    </table>
  );
};

export default TabelaDeProdutos;
