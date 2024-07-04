import { useQuery } from "@tanstack/react-query";
import Produto from "../../interfaces/produto";
import axios from "axios";
import { URL_BASE, URL_PRODUTO } from "../../util/constants";

const useVerProduto = (id: number) =>
  useQuery({
    queryKey: ["produto", id],
    queryFn: () =>
      axios
        .get<Produto>(URL_BASE + URL_PRODUTO + `/ver/${id}`)
        .then((response) => response.data),
    staleTime: 10_000,
  });

export default useVerProduto;
