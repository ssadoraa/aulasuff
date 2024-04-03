package com.isadoraverbicario.apirestfull.controller;

import org.springframework.web.bind.annotation.RestController;
import com.isadoraverbicario.apirestfull.model.Produto;
import com.isadoraverbicario.apirestfull.service.ProdutoService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;

@RestController
@RequestMapping("produtos")
public class ProdutoController {

    @Autowired
    private ProdutoService produtoService;

    @GetMapping
    public List<Produto> list(){
        return produtoService.recuperarProdutos();
    } 
}
