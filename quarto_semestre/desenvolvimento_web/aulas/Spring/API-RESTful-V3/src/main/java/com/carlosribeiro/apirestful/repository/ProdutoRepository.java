package com.carlosribeiro.apirestful.repository;

import com.carlosribeiro.apirestful.model.Produto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ProdutoRepository extends JpaRepository<Produto, Long> {

    List<Produto> findByCategoriaId(Long idCategoria);

    @Query("select p from Produto p " +
           "left outer join fetch p.categoria " +
           "order by p.id")
    List<Produto> recuperarProdutosComCategoria();
}
