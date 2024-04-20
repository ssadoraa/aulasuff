package com.carlosribeiro.apirestful.controller;

import com.carlosribeiro.apirestful.model.Produto;
import com.carlosribeiro.apirestful.service.ProdutoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("produtos")
public class ProdutoController {

    @Autowired
    private ProdutoService produtoService;

    @GetMapping   // http://localhost:8080/produtos
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

    @GetMapping("categoria/{idCategoria}")             // http://localhost:8080/produtos/categoria/1
    public List<Produto> recuperarProdutosPorIdDaCategoria(@PathVariable("idCategoria") Long idCategoria) {
        System.out.println(idCategoria);
        return produtoService.recuperarProdutosPorIdDaCategoria(idCategoria);
    }

    @GetMapping("categorias")    // http://localhost:8080/produtos/categorias
    public List<Produto> recuperarProdutosComCategoria() {
        return produtoService.recuperarProdutosComCategoria();
    }
}
