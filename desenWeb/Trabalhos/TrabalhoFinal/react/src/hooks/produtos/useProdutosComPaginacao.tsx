import { useQuery } from "@tanstack/react-query";
import Produto from "../../interfaces/produto";
import axios from "axios";

const useProdutosComPaginacao = (pagina: number, tamanho: number) =>
  useQuery({
    queryKey: ["produtos", "paginacao", pagina, tamanho],
    queryFn: () =>
      axios
        .get<ResultadoPaginado<Produto>>(
          "http://localhost:8080/produtos/paginacao?" +
            "pagina=" +
            pagina +
            "&tamanho=" +
            tamanho
        )
        .then((response) => response.data),
    staleTime: 10_000,
  });
export default useProdutosComPaginacao;
