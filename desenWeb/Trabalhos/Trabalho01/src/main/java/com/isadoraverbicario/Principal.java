package com.isadoraverbicario;

import com.isadoraverbicario.dao.ProdutoDAO;
import com.isadoraverbicario.excecao.ProdutoNaoEncontradoException;
import com.isadoraverbicario.modelo.Produto;
import com.isadoraverbicario.util.FabricaDeDAOs;
import corejava.Console;
import java.util.List;

public class Principal {
	public static void main (String[] args) {

		String nome;
		String descricao;
		String categoria;
		String condicao;
		double valorEstimado;
		String status;
		Produto umProduto;

		ProdutoDAO produtoDAO = FabricaDeDAOs.getDAO(ProdutoDAO.class);

		boolean continua = true;
		while (continua) {
			System.out.println('\n' + "O que você deseja fazer?");
			System.out.println('\n' + "1. Cadastrar um produto");
			System.out.println("2. Alterar um produto");
			System.out.println("3. Remover um produto");
			System.out.println("4. Listar todos os produtos");
			System.out.println("5. Sair");

			int opcao = Console.readInt('\n' + "Digite um número entre 1 e 5:");

			switch (opcao) {
				case 1: {
					nome = Console.readLine('\n' + "Informe o nome do produto: ");
					descricao = Console.readLine("Escreva uma descrição para o produto: ");
					categoria = Console.readLine("Informe a categoria do produto: ");
					condicao = Console.readLine("Informe a condição (Novo ou Usado) do produto: ");
					valorEstimado = Console.readDouble("Informe o valor estimado do produto: R$");
					status = Console.readLine("Informe o status da troca (Disponível, Em negociação, Trocado) do produto: ");

					umProduto = new Produto(nome, descricao, categoria, condicao, valorEstimado, status);
					produtoDAO.inclui(umProduto);

					System.out.println('\n' + "Produto com identificação [" + umProduto.getId() + "] incluído com sucesso!");
					break;
				}

				case 2: {
					int resposta = Console.readInt('\n' + "Digite a identificação do produto que deseja alterar: ");

					try	{
						umProduto = produtoDAO.recuperaUmProduto(resposta);
					}
					catch(ProdutoNaoEncontradoException e) {
						System.out.println('\n' + e.getMessage());
						break;
					}

					System.out.println('\n' +
							"Id = " + umProduto.getId() +
						"    Nome = " + umProduto.getNome() +
						"    Valor Estimado = " + umProduto.getValorEstimado() +
						"    Status = " + umProduto.getStatus());

					System.out.println('\n' + "O que deseja alterar?");
					System.out.println('\n' + "1. Nome");
					System.out.println("2. Valor Estimado");
					System.out.println("3. Status");

					int opcaoAlteracao = Console.readInt('\n' + "Digite a opção entre 1 e 3:");

					switch (opcaoAlteracao) {
						case 1:
							String novoNome = Console.readLine("Digite o novo nome: ");
							umProduto.setNome(novoNome);

							try {
								produtoDAO.altera(umProduto);
								System.out.println('\n' + "Alteração de nome efetuada com sucesso!");
							}
							catch(ProdutoNaoEncontradoException e) {
								System.out.println('\n' + e.getMessage());
							}
							break;

						case 2:
							double novoValorEstimado = Console.readDouble("Digite o novo valor estimado: R$");
							umProduto.setValorEstimado(novoValorEstimado);

							try {
								produtoDAO.altera(umProduto);
								System.out.println('\n' + "Alteração de valor estimado efetuada com sucesso!");
							}
							catch(ProdutoNaoEncontradoException e) {
								System.out.println('\n' + e.getMessage());
							}
							break;

						case 3:
							String novoStatus = Console.readLine("Digite o novo status (Disponível, Em negociação, Trocado): ");
							umProduto.setStatus(novoStatus);

							try {
								produtoDAO.altera(umProduto);
								System.out.println('\n' + "Alteração de status efetuada com sucesso!");
							}
							catch(ProdutoNaoEncontradoException e) {
								System.out.println('\n' + e.getMessage());
							}
							break;

						default:
							System.out.println('\n' + "Opção inválida!");
					}
					break;
				}

				case 3: {
					int resposta = Console.readInt('\n' + "Digite a identificação do produto que deseja remover: ");

					try {
						umProduto = produtoDAO.recuperaUmProduto(resposta);
					}
					catch(ProdutoNaoEncontradoException e) {
						System.out.println('\n' + e.getMessage());
						break;
					}

					System.out.println('\n' + "Identificação = " + umProduto.getId() + "    Nome = " + umProduto.getNome());

					String resp = Console.readLine('\n' + "Confirma a remoção do produto? (S-s : sim * N-n : não) ");

					if (resp.equals("s") || resp.equals("S")) {
						try {
							produtoDAO.exclui (umProduto.getId());
							System.out.println('\n' + "Produto removido com sucesso!");
						}
						catch(ProdutoNaoEncontradoException e) {
							System.out.println('\n' + e.getMessage());
						}
					}
					else {
						System.out.println('\n' + "Remoção cancelada. Produto não removido.");
					}
					break;
				}

				case 4: {
					List<Produto> produtos = produtoDAO.recuperaProdutos();

					for (Produto produto : produtos) {
						System.out.println('\n' +
							"Id = " + produto.getId() +
							"  Nome = " + produto.getNome() +
							"  Descrição = " + produto.getDescricao() +
							"  Categoria = " + produto.getCategoria() +
							"  Condição = " + produto.getCondicao() +
							"  Valor Estimado = R$" + produto.getValorEstimado() +
							"  Status = " + produto.getStatus());
					}
					break;
				}

				case 5: {
					continua = false;
					break;
				}

				default:
					System.out.println('\n' + "Opção inválida!");
			}
		}
	}
}