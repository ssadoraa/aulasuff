package com.isadoraverbicario.apirestfull.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.isadoraverbicario.apirestfull.model.Produto;

public interface ProdutoRepository extends JpaRepository<Produto, Long>{
    
}
