import { useQuery } from "@tanstack/react-query";
import Produto from "../../interfaces/produto";
import axios from "axios";

const useVerProduto = (id: number) =>
  useQuery({
    queryKey: ["produto", id],
    queryFn: () =>
      axios
        .get<Produto>(`http://localhost:8080/produtos/ver/${id}`)
        .then((response) => response.data),
    staleTime: 10_000,
  });

export default useVerProduto;
