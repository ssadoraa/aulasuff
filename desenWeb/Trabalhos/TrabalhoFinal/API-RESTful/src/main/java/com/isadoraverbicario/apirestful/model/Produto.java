package com.isadoraverbicario.apirestful.model;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;

@ToString
@Getter
@Setter
@NoArgsConstructor
@Entity
public class Produto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String nome;
    private String descricao;
    @ManyToOne
    private Categoria categoria;
    private String condicao;
    private BigDecimal valorEstimado;
    private String status;
    private String imagem;

    public Produto(String nome, String descricao, Categoria categoria, String condicao,
            BigDecimal valorEstimado, String status, String imagem) {
        this.nome = nome;
        this.descricao = descricao;
        this.categoria = categoria;
        this.condicao = condicao;
        this.valorEstimado = valorEstimado;
        this.status = status;
        this.imagem = imagem;
    } 
}
