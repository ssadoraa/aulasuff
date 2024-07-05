import { createBrowserRouter } from "react-router-dom";
import HomePage from "../pages/geral/HomePage";
import Layout from "./Layout";
import CadastrarProduto from "../pages/produto/CadastrarProduto";
import ErrorPage from "../pages/erro/ErrorPage";
import SobrePage from "../pages/geral/SobrePage";
import SuportePage from "../pages/geral/SuportePage";
import VerProdutoPage from "../pages/produto/VerProduto";
import ListaTodosProdutos from "../pages/produto/ListaTodosProtudos";
import CardsDeProdutos from "../pages/produto/CardsDeProdutos";
import ListaMeusDeProdutosPage from "../pages/produto/ListaMeusProdutos";
import ProdutosSelecionados from "../pages/produto/ProdutosSelecionados";
import EditarProduto from "../pages/produto/EditarProduto";

const router = createBrowserRouter([
  {
    path: "/",
    element: <Layout />,
    errorElement: <ErrorPage />,
    children: [
      { path: "", element: <HomePage /> },
      {
        path: "listar-produtos",
        element: <ListaTodosProdutos />,
        children: [
          {
            path: ":slug?",
            element: <CardsDeProdutos />,
          },
        ],
      },
      { path: "listar-meus-produtos", element: <ListaMeusDeProdutosPage /> },
      { path: "cadastrar-produto", element: <CadastrarProduto /> },
      { path: "sobre", element: <SobrePage /> },
      { path: "suporte", element: <SuportePage /> },
      { path: "ver/:id", element: <VerProdutoPage /> },
      { path: "editar/:id", element: <EditarProduto /> },
      { path: "produtos-selecionados", element: <ProdutosSelecionados /> },
    ],
  },
]);

export default router;
