package com.isadoraverbicario.apirestful.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDate;

@ToString
@Getter
@Setter
@NoArgsConstructor
@Entity
public class Produto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String imagem;

    @NotEmpty(message = "O 'Nome' deve ser informado.")
    private String nome;

    @NotEmpty(message = "A 'Descrição' deve ser informada.")
    private String descricao;
    
    @NotEmpty(message = "A 'Condição' deve ser informada.")
    private String condicao;
    
    @NotEmpty(message = "O 'Status' deve ser informado.")
    private String status;

    @NotNull(message = "O 'Preço' deve ser informado.")
    @DecimalMin(inclusive = true, value="0.1", message = "O 'Preço' deve ser maior ou igual a 0.1.")
    private BigDecimal valorEstimado;

    @NotNull(message = "A 'Data de Cadastro' deve ser informada.")
    private LocalDate dataCadastro;

    @ManyToOne
    private Categoria categoria;

    public Produto(String imagem,
                   String nome,
                   String descricao,
                   String condicao,
                   String status,
                   BigDecimal valorEstimado,
                   LocalDate dataCadastro,
                   Categoria categoria) {
        this.imagem = imagem;
        this.nome = nome;
        this.descricao = descricao;
        this.condicao = condicao;
        this.status = status;
        this.valorEstimado = valorEstimado;
        this.dataCadastro = dataCadastro;
        this.categoria = categoria;
    }
}
