package com.isadoraverbicario.modelo;

import javax.persistence.*;

@Entity
@Table(name="produto")

public class Produto {
    private Long id;
    private String nome;
    private String descricao;
    private String categoria;
    private String condicao;
    private double valorEstimado;
    private String status;

    // ********* Construtores *********

    public Produto() {}

    public Produto(String nome, String descricao, String categoria, String condicao, double valorEstimado, String status) {
        this.nome = nome;
        this.descricao = descricao;
        this.categoria = categoria;
        this.condicao = condicao;
        this.valorEstimado = valorEstimado;
        this.status = status;
    }


// ********* Métodos do Tipo Get *********

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    public Long getId() {
        return id;
    }

    public String getNome() {
        return nome;
    }

    @Column(name="DESCRICAO")
    public String getDescricao() {
        return descricao;
    }

    @Column(name="CATEGORIA")
    public String getCategoria() {
        return categoria;
    }

    @Column(name="CONDICAO")
    public String getCondicao() {
        return condicao;
    }

    @Column(name="VALOR_ESTIMADO")
    public double getValorEstimado() {
        return valorEstimado;
    }

    @Column(name="STATUS")
    public String getStatus() {
        return status;
    }

    // ********* Métodos do Tipo Set *********

    public void setId(Long id) {this.id = id;}
    
    public void setNome(String nome) {this.nome = nome;}

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public void setCondicao(String condicao) {
        this.condicao = condicao;
    }

    public void setValorEstimado(double valorEstimado) {
        this.valorEstimado = valorEstimado;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}