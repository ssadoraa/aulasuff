package com.carlosribeiro.apirestful.controller;

import com.carlosribeiro.apirestful.model.Produto;
import com.carlosribeiro.apirestful.service.ProdutoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;


@RestController
@RequestMapping("produtos")
public class ProdutoController {

    @Autowired       // http://localhost:8080/produtos
    private ProdutoService produtoService;

    @GetMapping
    public List<Produto> recuperarProdutos() {
        return produtoService.recuperarProdutos();
    }

    @PostMapping
    public Produto cadastrarProduto(@RequestBody Produto produto) {
        return produtoService.cadastrarProduto(produto);
    }

    @PutMapping
    public ResponseEntity<Produto> alterarProduto(@RequestBody Produto produto) {
        Produto umProduto = produtoService.alterarProduto(produto);
        return new ResponseEntity<Produto>(umProduto,HttpStatus.OK);
    }

    @DeleteMapping ("{idProduto}")     // http://localhost:8080/produtos/1
    public void removerProduto(@PathVariable("idProduto") Long id) {
        produtoService.removerProduto(id);
    }

    @GetMapping("categoria/{id}")
    public List<Produto> recuperarProdutoPorIdCategoria(@PathVariable("id") Long categotiaId){
        return produtoService.recuperarProdutosPorIdCategoria(categotiaId);
    }

    @GetMapping("categoria")
    public List<Produto> recuperarProdutosComCategoria() {
        return produtoService.recuperarProdutosComCategoria();
    }
    
}
