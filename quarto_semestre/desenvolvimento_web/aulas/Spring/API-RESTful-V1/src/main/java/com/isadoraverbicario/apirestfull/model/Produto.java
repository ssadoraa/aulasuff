package com.isadoraverbicario.apirestfull.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Entity
public class Produto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String imagem;
    private String nome;
    private String descricao;
    private boolean disponivel;
    private int qtdEstoque;
    private BigDecimal preco;
    private LocalDate dataCadastro;

    public Produto(String imagem, String nome, String descricao, boolean disponivel, int qtdEstoque, BigDecimal preco, LocalDate dataCadastro) {
        this.imagem = imagem;
        this.nome = nome;
        this.descricao = descricao;
        this.disponivel = disponivel;
        this.qtdEstoque = qtdEstoque;
        this.preco = preco;
        this.dataCadastro = dataCadastro;
    }

}
