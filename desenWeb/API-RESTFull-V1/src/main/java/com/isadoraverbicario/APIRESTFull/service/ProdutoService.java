package com.isadoraverbicario.apirestfull.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.isadoraverbicario.apirestfull.model.Produto;
import com.isadoraverbicario.apirestfull.repository.ProdutoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;

@Service
public class ProdutoService {

    @Autowired
    private ProdutoRepository produtoRepository;
    
    public List<Produto> recuperarProdutos() {
        return produtoRepository.findAll(Sort.by("id"));
    }

    public Produto cadastrarProduto(Produto produto) {
        return produtoRepository.save(produto);        
    }
    
    public Produto alterarProduto(Produto produto) {
        return produtoRepository.save(produto);        
    }
    
    public void removerProduto(Long id) {
        produtoRepository.deleteById(id);        
    }
}
