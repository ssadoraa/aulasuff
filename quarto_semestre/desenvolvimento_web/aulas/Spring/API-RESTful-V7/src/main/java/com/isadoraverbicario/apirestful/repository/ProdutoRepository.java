package com.isadoraverbicario.apirestful.repository;

import com.isadoraverbicario.apirestful.model.Produto;
import jakarta.persistence.LockModeType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface ProdutoRepository extends JpaRepository<Produto, Long> {

    List<Produto> findByCategoriaId(Long idCategoria);

    @Query("select p from Produto p " +
           "left outer join fetch p.categoria " +
           "order by p.id")
    List<Produto> recuperarProdutosComCategoria();

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("select p from Produto p where p.id = :id")
    Optional<Produto> recuperarPorIdComLock(Long id);

    @Query(
            value = "select p from Produto p " +
                    "left outer join fetch p.categoria " +
                    "order by p.id",
            countQuery = "select count(p) from Produto p"
    )
    Page<Produto> recuperarProdutosComPaginacao(Pageable pageable);
}
