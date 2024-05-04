package com.carlosribeiro.apirestful.controller;

import com.carlosribeiro.apirestful.exception.EntidadeNaoEncontradaException;
import com.carlosribeiro.apirestful.model.Categoria;
import com.carlosribeiro.apirestful.model.CategoriaDTO;
import com.carlosribeiro.apirestful.service.CategoriaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("categorias")
public class CategoriaController {

    @Autowired
    private CategoriaService categoriaService;

    @GetMapping("{idCategoria}")
    public Categoria recuperarCategoria(@PathVariable("idCategoria") Long idCategoria) {
        return categoriaService.recuperarCategoria(idCategoria)
                .orElseThrow(() -> new EntidadeNaoEncontradaException(
                        "Categoria número " + idCategoria + " não encontrada"));
    }

    @GetMapping("{idCategoria}/produtos")          // http://localhost:8080/categorias/1/produtos
    public CategoriaDTO recuperarCategoriaComProdutos(@PathVariable("idCategoria") Long idCategoria) {
        Categoria categoria = categoriaService.recuperarCategoriaComProdutos(idCategoria);
        return new CategoriaDTO(categoria.getId(), categoria.getNome(), categoria.getProdutos());
    }
}
