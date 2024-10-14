package com.carlosribeiro.dao.impl;

import com.carlosribeiro.dao.ProdutoDAO;
import com.carlosribeiro.excecao.ProdutoNaoEncontradoException;
import com.carlosribeiro.modelo.Produto;
import com.carlosribeiro.util.FabricaDeEntityManager;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.LockModeType;
import java.util.List;

public class JPAProdutoDAO implements ProdutoDAO
{
	public JPAProdutoDAO() {

	}

	public long inclui(Produto umProduto)
	{
		EntityManager em = null;
		EntityTransaction tx = null;

		try
		{	// transiente - objeto novo: ainda não persistente
			// persistente - após ser persistido
			// destacado - objeto persistente não vinculado a um entity manager
			em = FabricaDeEntityManager.criarEntityManager();
			tx = em.getTransaction();
			tx.begin();;

			em.persist(umProduto);

			// umProduto.setNome("abc");

			tx.commit();

			return umProduto.getId();
		}
		catch(RuntimeException e)
		{	if (tx != null)
			{
				tx.rollback();
			}
			throw e;
		}
		finally
		{
			em.close();
		}
	}

	public Produto recuperaUmProduto(long numero) throws ProdutoNaoEncontradoException
	{
		EntityManager em = null;

		try
		{
			em = FabricaDeEntityManager.criarEntityManager();

			Produto umProduto = em.find(Produto.class, numero);
			// umProduto = em.find(Produto.class, numero);

			// Características no método find():
			// 1. É genérico: não requer um cast.
			// 2. Retorna null caso a linha não seja encontrada no banco.

			if(umProduto == null)
			{	throw new ProdutoNaoEncontradoException("Produto não encontrado");
			}
			return umProduto;
		}
		finally
		{   em.close();
		}
	}

	public void altera(Produto umProduto) throws ProdutoNaoEncontradoException
	{
		EntityManager em = null;
		EntityTransaction tx = null;
		Produto produto = null;
		try
		{
			em = FabricaDeEntityManager.criarEntityManager();
			tx = em.getTransaction();
			tx.begin();

			produto = em.find(Produto.class, umProduto.getId(), LockModeType.PESSIMISTIC_WRITE);
			if (produto == null) {
				tx.rollback();
				throw new ProdutoNaoEncontradoException("Produto não encontrado.");
			}
			// O merge entre nada e tudo é tudo. Ao tentar alterar um produto deletado ele será re-inserido
			// no banco de dados.
			em.merge(umProduto);
			tx.commit();
		}
		catch(RuntimeException e)
		{
			if (tx != null)
		    {   tx.rollback();
		    }
		    throw e;
		}
		finally
		{   em.close();
		}
	}

	public void exclui(long numero) throws ProdutoNaoEncontradoException 
	{
		EntityManager em = null;
		EntityTransaction tx = null;

		try
		{
			em = FabricaDeEntityManager.criarEntityManager();
			tx = em.getTransaction();
			tx.begin();

			Produto produto = em.find(Produto.class, numero);

			if(produto == null)
			{	tx.rollback();
				throw new ProdutoNaoEncontradoException("Produto não encontrado");
			}

			em.remove(produto);
			tx.commit();
		}
		catch(RuntimeException e)
		{
			if (tx != null)
		    {   tx.rollback();
		    }
		    throw e;
		}
		finally
		{   em.close();
		}
	}

	public List<Produto> recuperaProdutos()
	{
		EntityManager em = null;

		try
		{	em = FabricaDeEntityManager.criarEntityManager();

			List produtos = em
					.createQuery("select p from Produto p order by p.id")
					.getResultList();

			// Retorna um List vazio caso a tabela correspondente esteja vazia.

			return produtos;
		}
		finally
		{   em.close();
		}
	}
}