import { useMutation, useQueryClient } from "@tanstack/react-query";
import axios from "axios";
import { URL_BASE, URL_CATEGORIA } from "../../util/constants";
import CustomError from "../../util/CustomError";
import Categoria from "../../interfaces/categoria";

const useCadastrarCategoria = () => {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (categoria: Categoria) => {
      try {
        const response = await axios.post<Categoria>(URL_BASE + URL_CATEGORIA, categoria);
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
        queryKey: ["categorias"],
      }),
  });
};

export default useCadastrarCategoria;
