package com.carlosribeiro.apirestful.repository;

import com.carlosribeiro.apirestful.model.Produto;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ProdutoRepository extends JpaRepository<Produto, Long> {
    
    List<Produto> findByCategoriaId(Long categoriaId);

    @Query("select p from Produto p " +
           "left outer join fetch p.categoria order by p.id")
    List<Produto> recuperarProdutosComCategoria();

}
