package com.isadoraverbicario.apirestful;

import com.isadoraverbicario.apirestful.model.Categoria;
import com.isadoraverbicario.apirestful.model.Produto;
import com.isadoraverbicario.apirestful.repository.CategoriaRepository;
import com.isadoraverbicario.apirestful.repository.ProdutoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.math.BigDecimal;

@SpringBootApplication
public class ApiResTfulV1Application implements CommandLineRunner {

	@Autowired
	private CategoriaRepository categoriaRepository;

	@Autowired
	private ProdutoRepository produtoRepository;

	public static void main(String[] args) {
		SpringApplication.run(ApiResTfulV1Application.class, args);
	}

	@Override
	public void run(String... args) throws Exception {

		Categoria eletronico = new Categoria("Eletronico");
		categoriaRepository.save(eletronico);

		Categoria roupa = new Categoria("Roupa");
		categoriaRepository.save(roupa);
		

		Produto produto = new Produto(
				"Fone de Ouvido Bluetooth",
				"Fone de Ouvido sem fio, com cancelamento de ruído",
				eletronico,
				"Usado",
				BigDecimal.valueOf(150.00),
				"Disponível",
				"abobrinha.jpg");
		produtoRepository.save(produto);
		
		produto = new Produto(
				"Fone de Ouvido Bluetooth",
				"Fone de Ouvido sem fio, com cancelamento de ruído",
				eletronico,
				"Usado",
				BigDecimal.valueOf(150.00),
				"Disponível",
				"abobrinha.jpg");
		produtoRepository.save(produto);

		produto = new Produto(
				"Fone de Ouvido Bluetooth",
				"Fone de Ouvido sem fio, com cancelamento de ruído",
				eletronico,
				"Usado",
				BigDecimal.valueOf(150.00),
				"Disponível",
				"abobrinha.jpg");
		produtoRepository.save(produto);
		
		produto = new Produto(
				"Fone de Ouvido Bluetooth",
				"Fone de Ouvido sem fio, com cancelamento de ruído",
				eletronico,
				"Usado",
				BigDecimal.valueOf(150.00),
				"Disponível",
				"abobrinha.jpg");
		produtoRepository.save(produto);
		
		produto = new Produto(
				"Fone de Ouvido Bluetooth",
				"Fone de Ouvido sem fio, com cancelamento de ruído",
				eletronico,
				"Usado",
				BigDecimal.valueOf(150.00),
				"Disponível",
				"abobrinha.jpg");
		produtoRepository.save(produto);
		
		produto = new Produto(
				"Fone de Ouvido Bluetooth",
				"Fone de Ouvido sem fio, com cancelamento de ruído",
				eletronico,
				"Usado",
				BigDecimal.valueOf(150.00),
				"Disponível",
				"abobrinha.jpg");
		produtoRepository.save(produto);
		
		produto = new Produto(
				"Fone de Ouvido Bluetooth",
				"Fone de Ouvido sem fio, com cancelamento de ruído",
				eletronico,
				"Usado",
				BigDecimal.valueOf(150.00),
				"Disponível",
				"abobrinha.jpg");
		produtoRepository.save(produto);
	}
}
