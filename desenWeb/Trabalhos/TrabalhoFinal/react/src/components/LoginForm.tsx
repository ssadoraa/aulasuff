import { z } from "zod";
import useUsuarioStore from "../store/usuarioStore";
import { useLocation, useNavigate } from "react-router-dom";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { useEffect } from "react";
import Usuario from "../interfaces/usuario";
import TokenResponse from "../interfaces/tokenResponse";
import useEfetuarLogin from "../hooks/usuario/useEfetuarLogin";
import TokenClass from "../util/TokenClass";

const schema = z.object({
  username: z.string().min(1, { message: "A conta deve ser informada." }),
  password: z.string().min(1, { message: "A senha deve ser informada." }),
});

type FormLogin = z.infer<typeof schema>;

const LoginForm = () => {
  const setUsuarioLogado = useUsuarioStore((s) => s.setUsuarioLogado);
  const setTentouLogar = useUsuarioStore((s) => s.setTentouLogar);
  const tentouLogar = useUsuarioStore((s) => s.tentouLogar);

  const location = useLocation();
  const navigate = useNavigate();

  const { mutate: efetuarLogin } = useEfetuarLogin();

  const {
    register,
    handleSubmit,
    setFocus,
    formState: { errors },
  } = useForm<FormLogin>({ resolver: zodResolver(schema) });

  useEffect(() => {
    setFocus("username");
    setTentouLogar(false);
    setUsuarioLogado("");
    TokenClass.resetToken();      // <===================================
  }, []);

  const onSubmit = ({ username, password }: FormLogin) => {
    const usuario: Usuario = { username, password };

    efetuarLogin(usuario, {
      onSuccess: (tokenResponse: TokenResponse) => {
        setUsuarioLogado(username);
        TokenClass.criarToken(tokenResponse.token); // <===============================
        
        console.log(tokenResponse);

        if (location.state && location.state.from) {
          navigate(location.state.from);
        } else {
          navigate("/"); // <== exibe a home page
        }
      },
      onError: () => {
        console.log("********** Deu erro **********");
        setUsuarioLogado("");
        setTentouLogar(true);
      },
    });
  };

  return (
    <>
      {tentouLogar && (
        <div className="alert alert-danger fw-bold" role="alert">
          Login inválido!
        </div>
      )}
      <form autoComplete="off" onSubmit={handleSubmit(onSubmit)}>
        <div className="row mb-2">
          <label htmlFor="username" className="col-lg-1 fw-bold mb-2">
            Conta
          </label>
          <div className="col-lg-5">
            <input
              {...register("username")}
              type="text"
              id="username"
              className={
                errors.username
                  ? "form-control form-control-sm is-invalid"
                  : "form-control form-control-sm"
              }
            />
            <div className="invalid-feedback">{errors.username?.message}</div>
          </div>
        </div>

        <div className="row mb-3">
          <label htmlFor="password" className="col-lg-1 fw-bold mb-2">
            Senha
          </label>
          <div className="col-lg-5">
            <input
              {...register("password")}
              type="password"
              id="password"
              className={
                errors.password
                  ? "form-control form-control-sm is-invalid"
                  : "form-control form-control-sm"
              }
            />
            <div className="invalid-feedback">{errors.password?.message}</div>
          </div>
        </div>

        <div className="row">
          <div className="offset-lg-1 col-lg-5">
            <button type="submit" className="btn btn-outline-primary">Entrar</button>
          </div>
        </div>
      </form>
    </>
  );
};

export default LoginForm;
