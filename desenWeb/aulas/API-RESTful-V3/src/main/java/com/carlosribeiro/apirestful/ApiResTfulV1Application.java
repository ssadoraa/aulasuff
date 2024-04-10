package com.carlosribeiro.apirestful;

import com.carlosribeiro.apirestful.model.Categoria;
import com.carlosribeiro.apirestful.model.Produto;
import com.carlosribeiro.apirestful.repository.CategoriaRepository;
import com.carlosribeiro.apirestful.repository.ProdutoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

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

		Categoria fruta = new Categoria("Fruta");
		categoriaRepository.save(fruta);

		Categoria legume = new Categoria("Legume");
		categoriaRepository.save(legume);

		Categoria verdura = new Categoria("Verdura");
		categoriaRepository.save(verdura);

		Produto produto = new Produto(
				"abacate.png",
				"Abacate",
				"1 unidade aprox. 750g",
				true,
				100,
				BigDecimal.valueOf(2.45),
				LocalDate.of(2023, 4, 26),
				fruta);
		produtoRepository.save(produto);

		produto = new Produto(
				"abobrinha.jpg",
				"Abobrinha",
				"1 unidade aprox. 250g",
				false,
				200,
				BigDecimal.valueOf(1.1),
				LocalDate.of(2023, 5, 22),
				legume);
		produtoRepository.save(produto);

		Categoria categoria = categoriaRepository.recuperarCategoriaComProdutosPorIdDaCategoria(1L);
		System.out.println(categoria.getNome());
		for (Produto prod : categoria.getProdutos()) {
			System.out.println(prod);
		}
	}

}
