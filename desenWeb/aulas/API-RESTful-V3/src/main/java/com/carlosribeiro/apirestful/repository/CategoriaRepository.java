package com.carlosribeiro.apirestful.repository;

import com.carlosribeiro.apirestful.model.Categoria;
import com.carlosribeiro.apirestful.model.Produto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CategoriaRepository extends JpaRepository<Categoria, Long> {

    @Query("select c from Categoria c left outer join fetch c.produtos where c.id = 1")
    Categoria recuperarCategoriaComProdutosPorIdDaCategoria(long id);
}
