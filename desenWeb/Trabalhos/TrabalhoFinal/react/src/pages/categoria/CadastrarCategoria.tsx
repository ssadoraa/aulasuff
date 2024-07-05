import { useState } from "react";
import "../../css/geral.css";
import useCadastrarCategoria from "../../hooks/categorias/useCadastrarCategoria";
import Categoria from "../../interfaces/categoria";

const CadastrarCategoria = () => {
  const cadastrarCategoria = useCadastrarCategoria();

  const [nome, setNome] = useState("");

  const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();

    const categoria: Categoria = {
      nome
    };
    cadastrarCategoria.mutate(categoria);
  };

  return (
    <div className="container mt-5">
      <h2>Cadastre uma categoria</h2>
      <form onSubmit={handleSubmit}>
        <div className="mb-3">
          <label htmlFor="nome" className="form-label">
            Nome:
          </label>
          <input
            type="text"
            className="form-control"
            id="nome"
            placeholder="Nome da categoria"
            value={nome}
            onChange={(e) => setNome(e.target.value)}
          />
        </div>
        <div className="mt-5 mb-5">
          <button type="button" className="btn btn-light me-3">
            Cancelar
          </button>
          <button type="submit" className="btn btn-success">
            Cadastrar
          </button>
        </div>
      </form>
    </div>
  );
};

export default CadastrarCategoria;
