package com.isadoraverbicario.apirestfull;

import java.math.BigDecimal;
import java.time.LocalDate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.isadoraverbicario.apirestfull.model.Produto;
import com.isadoraverbicario.apirestfull.repository.ProdutoRepository;

@SpringBootApplication
public class ApiRestFullV1Application implements CommandLineRunner{

	@Autowired
	private ProdutoRepository produtoRepository;

	public static void main(String[] args) {
		SpringApplication.run(ApiRestFullV1Application.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		Produto produto = new Produto(
			"abacate.png", 
			"Abacate", 
			"1 unidade aprox. 750g", 
			true, 
			100, 
			BigDecimal.valueOf(2.45), 
			LocalDate.of(2023, 4, 26));
		produtoRepository.save(produto);

		produto = new Produto(
			"abobrinha.jpg", 
			"Abobrinha",
			"1 unidade aprox. 250g", 
			false, 
			200, 
			BigDecimal.valueOf(1.1), 
			LocalDate.of(2023, 5, 22));
		produtoRepository.save(produto);
	}
}
