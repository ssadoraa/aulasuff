import { useMutation, useQueryClient } from "@tanstack/react-query";
import axios from "axios";
import { URL_BASE, URL_PRODUTO } from "../../util/constants";
import CustomError from "../../util/CustomError";

const useRemoverProduto = () => {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (id: number) => {
      try {
        await axios.delete(`${URL_BASE}${URL_PRODUTO}/${id}`);
      } catch (error) {
        if (axios.isAxiosError(error)) {
          if (error.response) {
            throw new CustomError(
              error.response.data.message,
              error.response.data.errorCode
            );
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

export default useRemoverProduto;
