import { NavLink, Outlet } from "react-router-dom";
import useCategorias from "../../hooks/categorias/useBuscarCategorias";

const ListaTodosProdutos = () => {
    const { data: categorias, isLoading, isError } = useCategorias();

    if (isLoading) return <div>Carregando...</div>;
    if (isError || !categorias) return <div>Ocorreu um erro ao buscar as categorias</div>;

    return (
        <div className="container mt-4">
            <div className="row">
                <div className="col-lg-2">
                    <h5>Categorias</h5>
                    <div className="nav flex-column nav-pills" style={{ maxHeight: "calc(100vh - 100px)", overflowY: "scroll", display: "block" }}>
                        <NavLink to="/" className="nav-link" style={{ width: "100%" }}>Todos</NavLink>
                        {categorias.map((categoria) => (
                            <NavLink
                                key={categoria.id}
                                to={`/${categoria.nome}`}
                                className="nav-link"
                                style={{ width: "100%" }}
                            >
                                {categoria.nome}
                            </NavLink>
                        ))}
                    </div>
                </div>
                <div className="col-lg-10">
                    <Outlet />
                </div>
            </div>
        </div>
    );
};

export default ListaTodosProdutos;
