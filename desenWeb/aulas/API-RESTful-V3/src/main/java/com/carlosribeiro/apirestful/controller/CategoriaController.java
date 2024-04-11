package com.carlosribeiro.apirestful.controller;

import org.springframework.web.bind.annotation.RestController;

import com.carlosribeiro.apirestful.exception.EntidadeNaoEncontradaException;
import com.carlosribeiro.apirestful.model.Categoria;
import com.carlosribeiro.apirestful.service.CategoriaService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;


@RestController
@RequestMapping("categorias")
public class CategoriaController {

    @Autowired
    private CategoriaService categoriaService;
    
    @GetMapping("{id}")
    public Categoria recuperarCategoria(@PathVariable Long id) {
        return categoriaService.recuperarCategoria(id)
                .orElseThrow(() -> new EntidadeNaoEncontradaException(
                    "Categoria número " + id + " não encontrada"));
    }
    
}
