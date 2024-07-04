import { Outlet } from "react-router-dom";
import NavBar from "../components/NavBar";
import Footer from "../components/Footer";
import '../css/footer.css';

function Layout() {
  return (
    <div className="layout-container">
      <NavBar />
      <div className="content-container">
        <Outlet />
      </div>
      <Footer />
    </div>
  );
}
export default Layout;
