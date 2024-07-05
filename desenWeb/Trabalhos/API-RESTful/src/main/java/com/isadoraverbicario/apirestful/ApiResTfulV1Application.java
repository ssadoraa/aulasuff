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

		Categoria roupa = new Categoria("Roupa");
		Categoria eletronico = new Categoria("Eletrônicos");
		Categoria livros = new Categoria("Livros");
		Categoria alimentos = new Categoria("Alimentos");
		Categoria brinquedos = new Categoria("Brinquedos");
		Categoria móveis = new Categoria("Móveis");
		Categoria cosméticos = new Categoria("Cosméticos");
		Categoria esportes = new Categoria("Esportes");
		Categoria automóveis = new Categoria("Automóveis");
		Categoria música = new Categoria("Música");
		Categoria animais = new Categoria("Animais");

		categoriaRepository.save(roupa);
		categoriaRepository.save(eletronico);
		categoriaRepository.save(livros);
		categoriaRepository.save(alimentos);
		categoriaRepository.save(brinquedos);
		categoriaRepository.save(móveis);
		categoriaRepository.save(cosméticos);
		categoriaRepository.save(esportes);
		categoriaRepository.save(automóveis);
		categoriaRepository.save(música);
		categoriaRepository.save(animais);

		Categoria roupa2 = new Categoria("Roupa2");
		Categoria eletronico2 = new Categoria("Eletrônicos");
		Categoria livros2 = new Categoria("Livros2");
		Categoria alimentos2 = new Categoria("Alimentos2");
		Categoria brinquedos2 = new Categoria("Brinquedos2");
		Categoria móveis2 = new Categoria("Móveis2");
		Categoria cosméticos2 = new Categoria("Cosméticos2");
		Categoria esportes2 = new Categoria("Esportes2");
		Categoria automóveis2 = new Categoria("Automóveis2");
		Categoria música2 = new Categoria("Música2");
		Categoria animais2 = new Categoria("Animais2");

		categoriaRepository.save(roupa2);
		categoriaRepository.save(eletronico2);
		categoriaRepository.save(livros2);
		categoriaRepository.save(alimentos2);
		categoriaRepository.save(brinquedos2);
		categoriaRepository.save(móveis2);
		categoriaRepository.save(cosméticos2);
		categoriaRepository.save(esportes2);
		categoriaRepository.save(automóveis2);
		categoriaRepository.save(música2);
		categoriaRepository.save(animais2);

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
