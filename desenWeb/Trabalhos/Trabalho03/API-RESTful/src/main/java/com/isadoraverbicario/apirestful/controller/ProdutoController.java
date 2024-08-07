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
    
    @GetMapping ("/ver/{idProduto}")     // http://localhost:8080/produtos/ver/1
    public Produto verProduto(@PathVariable("idProduto") Long id) {
        return produtoService.recuperarProdutoPeloId(id);
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

    // http://localhost:8080/produtos/paginacao?pagina=0&tamanho=5
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
