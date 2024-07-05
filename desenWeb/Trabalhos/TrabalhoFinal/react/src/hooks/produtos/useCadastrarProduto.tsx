import { useMutation, useQueryClient } from "@tanstack/react-query";
import axios from "axios";
import Produto from "../../interfaces/produto";
import { URL_BASE, URL_PRODUTO } from "../../util/constants";
import CustomError from "../../util/CustomError";

const useCadastrarProduto = () => {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (produto: Produto) => {
      try {
        const response = await axios.post<Produto>(URL_BASE + URL_PRODUTO, produto);
        return response.data;
      } catch (error) {
        if (axios.isAxiosError(error)) {
          if (error.response) {
            if (error.response.status === 422) {
              throw new CustomError(
                error.response.data.message,
                error.response.data.errorCode,
                Object.values(error.response.data.map)
              );
            } else {
              throw new CustomError(
                error.response.data.message,
                error.response.data.errorCode
              );
            }
          } else if (error.request) {
            throw error;
          } else {
            throw error;
          }
        } else {
          throw error;
        }
      }
    },
    onSuccess: () =>
      queryClient.invalidateQueries({
        queryKey: ["produtos"],
      }),
  });
};

export default useCadastrarProduto;
