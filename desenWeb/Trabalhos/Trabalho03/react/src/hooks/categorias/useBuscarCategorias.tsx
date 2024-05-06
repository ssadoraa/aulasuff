import { useQuery } from "@tanstack/react-query";
import Categoria from "../../interfaces/categoria";
import axios from "axios";

const useCategorias = () =>
  useQuery({
    queryKey: ["categorias"],
    queryFn: () =>
      axios
        .get<Categoria[]>("http://localhost:8080/categorias")
        .then((response) => response.data),
    staleTime: 10_000,
  });
export default useCategorias;
