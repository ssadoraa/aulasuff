interface Props {
  pagina: number;
  totalDePaginas: number;
  tratarPaginacao: (pagina: number) => void;
}

const Paginacao = ({ pagina, totalDePaginas, tratarPaginacao }: Props) => {
  const arrayDePaginas = [];

  for (let i = 0; i < totalDePaginas; i++) {
    arrayDePaginas.push(
      <li className="page-item">
        <a
          onClick={() => tratarPaginacao(i)}
          className={pagina === i ? "page-link active" : "page-link"}
          href="#"
        >
          {i + 1}
        </a>
      </li>
    );
  }

  return (
    <nav aria-label="Paginação">
      <ul className="pagination">
        <li className={pagina === 0 ? "page-item disabled" : "page-item"}>
          <a onClick={() => tratarPaginacao(pagina - 1)} className="page-link">
            Anterior
          </a>
        </li>
        {arrayDePaginas}
        <li className={pagina === totalDePaginas - 1 ? "page-item disabled" : "page-item"}>
          <a onClick={() => tratarPaginacao(pagina + 1)} className="page-link">
            Próxima
          </a>
        </li>
      </ul>
    </nav>
  );
};
export default Paginacao;
