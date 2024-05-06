import { createBrowserRouter } from 'react-router-dom';
import HomePage from '../pages/HomePage';
import Layout from './Layout';
import CadastroDeProdutosPage from '../pages/CadastroDeProdutosPage';
import ListaDeProdutosPage from '../pages/ListaDeProdutosPage';
import ErrorPage from '../pages/ErrorPage';
import SobrePage from '../pages/SobrePage';
import SuportePage from '../pages/SuportePage';
import VerProdutoPage from '../pages/VerProdutoPage';

const router = createBrowserRouter([
    {
        path: "/",
        element: <Layout />,
        errorElement: <ErrorPage />,
        children: [
            { path: "", element: <HomePage /> },
            { path: "listar-produtos", element: <ListaDeProdutosPage /> },
            { path: "cadastrar-produto", element: <CadastroDeProdutosPage /> },            
            { path: "sobre", element: <SobrePage /> },            
            { path: "suporte", element: <SuportePage /> },            
            { path: "ver/:id", element: <VerProdutoPage /> },            
        ]
    }
]);
export default router;
