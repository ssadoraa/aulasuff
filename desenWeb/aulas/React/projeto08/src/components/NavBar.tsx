import { Link } from "react-router-dom";
import hortifruti from '/hortifruti-icon.png';
import carrinho from '/carrinho.png';

function NavBar() {
  return (
    <>
      <div className="container mt-3 mb-2">
        <div className="row">
          <div className="col-3 d-flex align-items-center">
            <Link to="/" style={{ textDecoration: "none", fontSize: "16px" }}>
              <img className="d-none d-md-block" src={hortifruti} style={{ width: "70px" }} />
              Hortifruti
            </Link>
          </div>
          <div className="col-6">
            <ul style={{ listStyleType: "none" }}>
              <li className="mt-2 d-flex justify-content-center">
                Faça seu
                <Link className="ms-1" to="/login" style={{ textDecoration: "none" }}>
                  login!
                </Link>
              </li>
              <li className="d-flex justify-content-center">
                <Link to="/cadastrar-produto" style={{ textDecoration: "none" }}>
                  Cadastrar produto
                </Link>
              </li>
              <li className="d-flex justify-content-center">
                <Link to="/listar-produtos" style={{ textDecoration: "none" }}>
                  Listar produtos
                </Link>
              </li>
            </ul>
          </div>
          <div className="col-3 d-flex align-items-center justify-content-end">
            <Link to="/carrinho" style={{ textDecoration: "none" }}>
              <img className="d-none d-md-block" src={carrinho} style={{ width: "35px" }} />
              Carrinho
            </Link>
          </div>
        </div>
      </div>

      <div className="bg-danger" style={{ padding: "3px" }}></div>
    </>
  );
}
export default NavBar;
