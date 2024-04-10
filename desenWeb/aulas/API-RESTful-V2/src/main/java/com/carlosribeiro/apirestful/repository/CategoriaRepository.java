package com.carlosribeiro.apirestful.repository;

import com.carlosribeiro.apirestful.model.Categoria;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;


public interface CategoriaRepository extends JpaRepository<Categoria, Long> {

    @Query("select c from Categoria c left outer join fetch c.produtos where c.id = 1")
    Categoria recuperarCategoriaComProdutosPorIdDaCategoria(long id);
}
