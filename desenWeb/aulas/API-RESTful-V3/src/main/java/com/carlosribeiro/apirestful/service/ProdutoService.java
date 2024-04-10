package com.carlosribeiro.apirestful.service;

import com.carlosribeiro.apirestful.exception.EntidadeDestacadaException;
import com.carlosribeiro.apirestful.exception.EntidadeNaoEncontradaException;
import com.carlosribeiro.apirestful.exception.EntidadeTransienteException;
import com.carlosribeiro.apirestful.model.Produto;
import com.carlosribeiro.apirestful.repository.ProdutoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProdutoService {

    @Autowired
    private ProdutoRepository produtoRepository;

    public List<Produto> recuperarProdutos() {
        return produtoRepository.findAll(Sort.by("id"));
    }

    public Produto cadastrarProduto(Produto produto) {
        if (produto.getId() == null) {
            return produtoRepository.save(produto);
        }
        else {
            throw new EntidadeDestacadaException(
                "Tentando cadastrar um objeto destacado.");
        }
    }

//    public Produto alterarProduto(Produto produto) {
//        if (produto.getId() == null) {
//            throw new EntidadeTransienteException("Tentando alterar um objeto transiente.");
//        }
//        else {
//            if (produtoRepository.findById(produto.getId()).isPresent()) {
//                return produtoRepository.save(produto);
//            }
//            else {
//                throw new EntidadeNaoEncontradaException(
//                        "Produto número " + produto.getId() + " não encontrado.");
//            }
//        }
//    }

    public Produto alterarProduto(Produto produto) {
        if (produto.getId() == null) {
            throw new EntidadeTransienteException("Tentando alterar um objeto transiente.");
        }
        else {
            produtoRepository.findById(produto.getId())
                .orElseThrow(() -> new EntidadeNaoEncontradaException(
                      "Produto número " + produto.getId() + " não encontrado."));
            return produtoRepository.save(produto);
        }
    }

    public void removerProduto(Long id) {
        Produto p = produtoRepository.findById(id)
            .orElseThrow(() -> new EntidadeNaoEncontradaException(
                "Produto número " + id + " não encontrado."));
        produtoRepository.delete(p);
    }
}
