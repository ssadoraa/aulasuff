package com.isadoraverbicario.apirestfull.controller;

import org.springframework.web.bind.annotation.RestController;
import com.isadoraverbicario.apirestfull.model.Produto;
import com.isadoraverbicario.apirestfull.service.ProdutoService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PutMapping;

@RestController
@RequestMapping("produtos")
public class ProdutoController {

    @Autowired
    private ProdutoService produtoService;

    @GetMapping
    public List<Produto> list(){
        return produtoService.recuperarProdutos();
    }

    @PostMapping()
    public Produto cadastrarProduto(@RequestBody Produto produto) {
        return produtoService.cadastrarProduto(produto);
    }

    @PutMapping()
    public Produto alteraProduto(@RequestBody Produto produto) {
        return produtoService.alterarProduto(produto);
    }

    @DeleteMapping("/idProduto")
    public void removerProduto(@PathVariable("idProduto") Long id){
        produtoService.removerProduto(id);
    }
    
}
