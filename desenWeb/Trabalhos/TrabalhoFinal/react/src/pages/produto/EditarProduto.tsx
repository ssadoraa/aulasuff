import { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import "../../css/geral.css";
import useCategorias from "../../hooks/categorias/useBuscarCategorias";
import useEditarProduto from "../../hooks/produtos/useEditarProduto";
import Categoria from "../../interfaces/categoria";
import Produto from "../../interfaces/produto";
import useVerProduto from "../../hooks/produtos/useVerProduto";

const EditarProduto = () => {
  const { id } = useParams<{ id: string }>();

  if (!id) {
    return <div>ID do produto não fornecido</div>;
  }

  const { data: categorias, isLoading: isLoadingCategorias, isError: isErrorCategorias } = useCategorias();
  const { data: produto, isLoading: isLoadingProduto, isError: isErrorProduto } = useVerProduto(parseInt(id));
  const editarProduto = useEditarProduto();

  const [nome, setNome] = useState("");
  const [descricao, setDescricao] = useState("");
  const [categoria, setCategoria] = useState<Categoria | null>(null);
  const [condicao, setCondicao] = useState("");
  const [valorEstimado, setValorEstimado] = useState("");
  const [status, setStatus] = useState("");

  useEffect(() => {
    if (produto) {
      setNome(produto.nome);
      setDescricao(produto.descricao);
      setCategoria(produto.categoria);
      setCondicao(produto.condicao);
      setValorEstimado(produto.valorEstimado.toString());
      setStatus(produto.status);
    }
  }, [produto]);

  const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    
    if (!categoria) {
      alert("Por favor, selecione uma categoria.");
      return;
    }

    const produtoAtualizado: Produto = {
      id: produto?.id, 
      nome,
      descricao,
      categoria,
      condicao,
      valorEstimado: Number(valorEstimado),
      status,
    };

    console.log(produtoAtualizado);
    editarProduto.mutate(produtoAtualizado);
  };

  if (isLoadingCategorias || isLoadingProduto) return <div>Carregando...</div>;
  if (isErrorCategorias || isErrorProduto || categorias === undefined)
    return <div>Ocorreu um erro ao buscar os dados necessários</div>;

  return (
    <div className="container mt-5">
      <h2>Editar Produto</h2>
      <form onSubmit={handleSubmit}>
        <div className="mb-3">
          <label htmlFor="nome" className="form-label">
            Produto:
          </label>
          <input
            required
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
            required
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
            required
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
            Salvar
          </button>
        </div>
      </form>
    </div>
  );
};

export default EditarProduto;
