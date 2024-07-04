package com.isadoraverbicario.apirestful.controller;

import com.isadoraverbicario.apirestful.exception.EntidadeNaoEncontradaException;
import com.isadoraverbicario.apirestful.model.Categoria;
import com.isadoraverbicario.apirestful.model.CategoriaDTO;
import com.isadoraverbicario.apirestful.service.CategoriaService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin("http://localhost:5173")
@RestController
@RequestMapping("categorias")
public class CategoriaController {

    @Autowired
    private CategoriaService categoriaService;

    @GetMapping("{id}")
    public Categoria recuperarCategoria(@PathVariable("id") Long id) {
        return categoriaService.recuperarCategoria(id)
                .orElseThrow(() -> new EntidadeNaoEncontradaException(
                        "Categoria número " + id + " não encontrada"));
    }

    @GetMapping("{id}/produtos")
    public CategoriaDTO recuperarCategoriaComProdutos(@PathVariable("id") Long id) {
        Categoria categoria = categoriaService.recuperarCategoriaComProdutos(id);
        return new CategoriaDTO(categoria.getId(), categoria.getNome(), categoria.getProdutos());
    }

    @GetMapping
    public List<Categoria> getCategorias() {
        return categoriaService.getCategorias();
    }
    
}
