import { useState } from "react";
import "../../css/geral.css";
import useCategorias from "../../hooks/categorias/useBuscarCategorias";
import useCadastrarProduto from "../../hooks/produtos/useCadastrarProduto";
import Categoria from "../../interfaces/categoria";
import Produto from "../../interfaces/produto";

const CadastrarProduto = () => {
  const { data: categorias, isLoading, isError } = useCategorias();
  const cadastrarProduto = useCadastrarProduto();

  const [nome, setNome] = useState("");
  const [descricao, setDescricao] = useState("");
  const [categoria, setCategoria] = useState<Categoria | null>(null);
  const [condicao, setCondicao] = useState("");
  const [valorEstimado, setValorEstimado] = useState("");
  const [status, setStatus] = useState("");

  const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    
    if (!categoria) {
      alert("Por favor, selecione uma categoria.");
      return;
    }

    const produto: Produto = {
      nome,
      descricao,
      categoria,
      condicao,
      valorEstimado: Number(valorEstimado),
      status,
    };
    cadastrarProduto.mutate(produto);
  };

  if (isLoading) return <div>Carregando...</div>;
  if (isError || categorias === undefined)
    return <div>Ocorreu um erro ao buscar as categorias</div>;

  return (
    <div className="container mt-5">
      <h2>Cadastre um produto</h2>
      <form onSubmit={handleSubmit}>
        <div className="mb-3">
          <label htmlFor="nome" className="form-label">
            Produto:
          </label>
          <input
            type="text"
            className="form-control"
            id="nome"
            placeholder="Nome do produto"
            value={nome}
            onChange={(e) => setNome(e.target.value)}
          />
        </div>
        <div className="mb-3">
          <label htmlFor="descricao" className="form-label">
            Descrição:
          </label>
          <textarea
            className="form-control"
            id="descricao"
            placeholder="Descrição"
            value={descricao}
            onChange={(e) => setDescricao(e.target.value)}
          ></textarea>
        </div>
        <div className="mb-3">
          <label htmlFor="categoria" className="form-label">
            Categoria:
          </label>
          <select
            className="form-select"
            id="categoria"
            value={categoria ? categoria.id : ""}
            onChange={(e) => {
              const selectedCategoria = categorias.find(cat => cat.id === parseInt(e.target.value, 10));
              setCategoria(selectedCategoria || null);
            }}
          >
            <option disabled value="">
              Selecione uma categoria...
            </option>
            {categorias.map((categoria: Categoria) => (
              <option key={categoria.id} value={categoria.id}>
                {categoria.nome}
              </option>
            ))}
          </select>
        </div>
        <div className="mb-3">
          <label htmlFor="condicao" className="form-label">
            Condição:
          </label>
          <div className="col-lg-8">
            <div className="form-check form-check-inline">
              <input
                className="form-check-input"
                type="radio"
                name="condicao"
                id="usado"
                value="usado"
                checked={condicao === "usado"}
                onChange={(e) => setCondicao(e.target.value)}
              />
              <span className="form-check-label">Usado</span>
            </div>
            <div className="form-check form-check-inline">
              <input
                className="form-check-input"
                type="radio"
                name="condicao"
                id="novo"
                value="novo"
                checked={condicao === "novo"}
                onChange={(e) => setCondicao(e.target.value)}
              />
              <span className="form-check-label">Novo</span>
            </div>
            <div className="form-check form-check-inline">
              <input
                className="form-check-input"
                type="radio"
                name="condicao"
                id="sem_funcionalidade"
                value="sem_funcionalidade"
                checked={condicao === "sem_funcionalidade"}
                onChange={(e) => setCondicao(e.target.value)}
              />
              <span className="form-check-label">Sem Funcionalidade</span>
            </div>
          </div>
        </div>
        <div className="mb-3">
          <label htmlFor="valorEstimado" className="form-label">
            Valor Estimado:
          </label>
          <input
            type="number"
            className="form-control"
            id="valorEstimado"
            placeholder="Valor Estimado"
            value={valorEstimado}
            onChange={(e) => setValorEstimado(e.target.value)}
          />
        </div>
        <div className="mb-3">
          <label htmlFor="status" className="form-label">
            Status:
          </label>
          <select
            className="form-select"
            id="status"
            value={status}
            onChange={(e) => setStatus(e.target.value)}
          >
            <option disabled value="">
              Selecione o status
            </option>
            <option value="ativo">Ativo</option>
            <option value="inativo">Inativo</option>
            <option value="negociacao">Em negociação</option>
          </select>
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

export default CadastrarProduto;
