package com.isadoraverbicario.apirestful.controller;

import com.isadoraverbicario.apirestful.model.Produto;
import com.isadoraverbicario.apirestful.model.ResultadoPaginado;
import com.isadoraverbicario.apirestful.service.ProdutoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin("http://localhost:5173")
@RestController
@RequestMapping("produtos")
public class ProdutoController {

    @Autowired
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

    @DeleteMapping ("{id}")
    public void removerProduto(@PathVariable("id") Long id) {
        produtoService.removerProduto(id);
    }
    
    @GetMapping ("/ver/{id}")
    public Produto verProduto(@PathVariable("id") Long id) {
        return produtoService.recuperarProdutoPeloId(id);
    }

    @GetMapping("categoria/{idCategoria}")
    public List<Produto> recuperarProdutosPorIdDaCategoria(@PathVariable("idCategoria") Long idCategoria) {
        return produtoService.recuperarProdutosPorIdDaCategoria(idCategoria);
    }

    @GetMapping("categorias")
    public List<Produto> recuperarProdutosComCategoria() {
        return produtoService.recuperarProdutosComCategoria();
    }

    @GetMapping("paginacao")
    public ResultadoPaginado<Produto> recuperarProdutosComPaginacao(
            @RequestParam(value = "pagina", defaultValue = "0") int pagina,
            @RequestParam(value = "tamanho", defaultValue = "3") int tamanho) {
        Pageable pageable = PageRequest.of(pagina, tamanho);
        Page<Produto> page = produtoService.recuperarProdutosComPaginacao(pageable);
        ResultadoPaginado<Produto> resultadoPaginado = new ResultadoPaginado<>(
                page.getTotalElements(),
                page.getTotalPages(),
                page.getNumber(),
                page.getContent());
        return resultadoPaginado;
    }
}