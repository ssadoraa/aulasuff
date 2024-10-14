package com.isadoraverbicario.excecao;

public class ProdutoNaoEncontradoException extends Exception {
	public ProdutoNaoEncontradoException(String msg) {
		super(msg);
	}
}