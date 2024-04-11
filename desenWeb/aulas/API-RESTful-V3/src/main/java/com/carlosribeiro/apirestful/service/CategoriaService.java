package com.carlosribeiro.apirestful.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.carlosribeiro.apirestful.model.Categoria;
import com.carlosribeiro.apirestful.repository.CategoriaRepository;

@Service
public class CategoriaService {

    @Autowired
    private CategoriaRepository categoriaRepository;

    public Optional<Categoria> recuperarCategoria(Long id){
        return categoriaRepository.findById(id);
    }
    
}
