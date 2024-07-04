import axios from "axios";
import { useQuery } from "@tanstack/react-query";
import CustomError from "../../util/CustomError";
import { URL_BASE, URL_PRODUTO } from "../../util/constants";
import Produto from "../../interfaces/produto";

const useAPIProduto = () => {
  const axiosInstance = axios.create({
    baseURL: URL_BASE,
  });

  const recuperarProdutosPorSlugDaCategoria = (slug?: string) =>
    axiosInstance
      .get<Produto[]>(URL_PRODUTO + (slug ? "/categoria/" + slug : ""))
      .then((response) => response.data)
      .catch((error) => {
        if (error.response) {
          throw new CustomError(
            error.response.data.message,
            error.response.data.errorCode
          );
          // significa servidor respondeu
        } else if (error.request) {
          throw error;
          // significa que o servidor não respondeu
        } else {
          throw error;
          // erro desconhecido
        }
      });

  return { recuperarProdutosPorSlugDaCategoria };
};

const useProdutosPorSlugDaCategoria = (slug?: string) => {
  const { recuperarProdutosPorSlugDaCategoria } = useAPIProduto();
  return useQuery({
    queryKey: slug ? ["produtos", "slugCategoria", slug] : ["produtos"],
    queryFn: () => recuperarProdutosPorSlugDaCategoria(slug),
    staleTime: 10_000,
  });
};

export default useProdutosPorSlugDaCategoria;
