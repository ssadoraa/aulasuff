package com.carlosribeiro;

import com.carlosribeiro.dao.ProdutoDAO;
import com.carlosribeiro.dao.impl.JPAProdutoDAO;
import com.carlosribeiro.excecao.ProdutoNaoEncontradoException;
import com.carlosribeiro.modelo.Produto;
import com.carlosribeiro.util.FabricaDeDAOs;
import com.carlosribeiro.util.Util;
import corejava.Console;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.function.Consumer;

public class Principal
{	public static void main (String[] args) 
	{
//		Logger logger = LoggerFactory.getLogger(Principal.class);
//		logger.error("Mensagem de log emitida utilizando o LOG4J");
		// fatal - error - warning - info - debug

		String nome;
		double lanceMinimo;
		String dataCadastro;
		Produto umProduto;

		ProdutoDAO produtoDAO = FabricaDeDAOs.getDAO(ProdutoDAO.class);

		boolean continua = true;
		while (continua)
		{	System.out.println('\n' + "O que você deseja fazer?");
			System.out.println('\n' + "1. Cadastrar um produto");
			System.out.println("2. Alterar um produto");
			System.out.println("3. Remover um produto");
			System.out.println("4. Listar todos os produtos");
			System.out.println("5. Sair");
						
			int opcao = Console.readInt('\n' + 
							"Digite um número entre 1 e 5:");
					
			switch (opcao)
			{	case 1:
				{
					nome = Console.readLine('\n' + 
						"Informe o nome do produto: ");
					lanceMinimo = Console.readDouble(
						"Informe o valor do lance mínimo: ");
					dataCadastro = Console.readLine(
						"Informe a data de cadastramento do produto: ");
						
					umProduto = new Produto(nome, lanceMinimo, Util.strToLocalDate(dataCadastro));
					
					produtoDAO.inclui(umProduto);
					
					System.out.println('\n' + "Produto número " +
					    umProduto.getId() + " incluído com sucesso!");

					break;
				}

				case 2:
				{	int resposta = Console.readInt('\n' + 
						"Digite o número do produto que você deseja alterar: ");
										
					try
					{
						umProduto = produtoDAO.recuperaUmProduto(resposta);
					}
					catch(ProdutoNaoEncontradoException e)
					{	System.out.println('\n' + e.getMessage());
						break;
					}
										
					System.out.println('\n' + 
						"Número = " + umProduto.getId() +
						"    Nome = " + umProduto.getNome() +
						"    Lance mínimo = " + umProduto.getLanceMinimo());
												
					System.out.println('\n' + "O que você deseja alterar?");
					System.out.println('\n' + "1. Nome");
					System.out.println("2. Lance mínimo");

					int opcaoAlteracao = Console.readInt('\n' + 
											"Digite um número de 1 a 2:");

					switch (opcaoAlteracao)
					{	case 1:
							String novoNome = Console.
								readLine("Digite o novo nome: ");

							umProduto.setNome(novoNome);

							try
							{
								produtoDAO.altera(umProduto);

								System.out.println('\n' +
									"Alteração de nome efetuada com sucesso!");
							}
							catch(ProdutoNaoEncontradoException e)
							{	System.out.println('\n' + e.getMessage());
							}

							break;

						case 2:
							double novoLanceMinimo = Console.
									readDouble("Digite o novo lance mínimo: ");

							umProduto.setLanceMinimo(novoLanceMinimo);

							try
							{
								produtoDAO.altera(umProduto);

								System.out.println('\n' +
									"Alteração de lance mínimo efetuada " +
									"com sucesso!");
							}
							catch(ProdutoNaoEncontradoException e)
							{	System.out.println('\n' + e.getMessage());
							}

							break;

						default:
							System.out.println('\n' + "Opção inválida!");
					}

					break;
				}

				case 3:
				{	int resposta = Console.readInt('\n' + 
						"Digite o número do produto que você deseja remover: ");
									
					try
					{
						umProduto = produtoDAO.recuperaUmProduto(resposta);
					}
					catch(ProdutoNaoEncontradoException e)
					{	System.out.println('\n' + e.getMessage());
						break;
					}
										
					System.out.println('\n' + 
						"Número = " + umProduto.getId() +
						"    Nome = " + umProduto.getNome());
														
					String resp = Console.readLine('\n' + 
						"Confirma a remoção do produto?");

					if(resp.equals("s"))
					{	try
						{
							produtoDAO.exclui (umProduto.getId());
							System.out.println('\n' + 
								"Produto removido com sucesso!");
						}
						catch(ProdutoNaoEncontradoException e)
						{	System.out.println('\n' + e.getMessage());
						}
					}
					else
					{	System.out.println('\n' + "Produto não removido.");
					}
					
					break;
				}

				case 4:
				{
					List<Produto> produtos = produtoDAO.recuperaProdutos();

//                  Utilizando um consumer. Consumer é uma interface funcional. Ela recebe um
//                  argumento e não retorna nada. Para que um valor seja aceito pelo Consumer
//                  deve ser executado o método accept.


//                  Utilizando method reference. Method references são expressões que possuem
//                  o mesmo tratamento de expressões lambda, mas em vez de prover um corpo  à
//                  expressão lambda, eles (os method references) referenciam um método existente
//                  pelo nome.

					for (Produto produto : produtos)
					{
						System.out.println('\n' +
							"Id = " + produto.getId() +
							"  Nome = " + produto.getNome() +
							"  Lance mínimo = " + Util.doubleToStr(produto.getLanceMinimo()) +
							"  Data Cadastro = " + Util.dateToStr(produto.getDataCadastro()));
					}

					break;
				}

				case 5:
				{	continua = false;
					break;
				}

				default:
					System.out.println('\n' + "Opção inválida!");
			}
		}		
	}
}
