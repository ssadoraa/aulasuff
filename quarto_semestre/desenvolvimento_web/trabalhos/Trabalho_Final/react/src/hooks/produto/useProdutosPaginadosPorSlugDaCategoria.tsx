import { useInfiniteQuery } from "@tanstack/react-query";
import Produto from "../../interfaces/produto";
import useAPIProduto from "./useAPIProduto";

interface QueryString {
  tamanho: number;
  slug?: string;
}

const useProdutosPaginadosPorSlugDaCategoria = (query: QueryString) => {
  const { recuperarProdutosPaginadosPorSluDaCategoria } = useAPIProduto();

  return useInfiniteQuery<ResultadoPaginado<Produto>>({
    queryKey: ["produtos", "categoria", "paginacao", query],
    queryFn: ({ pageParam }) =>
      recuperarProdutosPaginadosPorSluDaCategoria({
        params: {
          pagina: pageParam,
          ...query,
        },
      }),
    initialPageParam: 0,
    staleTime: 10_000,
    getNextPageParam: (lastPage) => {
      return lastPage.paginaCorrente < lastPage.totalDePaginas - 1
        ? lastPage.paginaCorrente + 1
        : undefined;
    },
  });
};
export default useProdutosPaginadosPorSlugDaCategoria;
