package com.isadoraverbicario.dao.impl;

import com.isadoraverbicario.dao.ProdutoDAO;
import com.isadoraverbicario.excecao.ProdutoNaoEncontradoException;
import com.isadoraverbicario.modelo.Produto;
import com.isadoraverbicario.util.FabricaDeEntityManager;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.LockModeType;
import java.util.List;

public class JPAProdutoDAO implements ProdutoDAO {
	public JPAProdutoDAO() {}

	public long inclui(Produto umProduto) {
		EntityManager em = null;
		EntityTransaction tx = null;

		try
		{
			em = FabricaDeEntityManager.criarEntityManager();
			tx = em.getTransaction();
			tx.begin();;

			em.persist(umProduto);
			tx.commit();

			return umProduto.getId();
		}
		catch(RuntimeException e)
		{	if (tx != null) {
				tx.rollback();
			}
			throw e;
		}

		finally {
			em.close();
		}
	}

	public Produto recuperaUmProduto(long numero) throws ProdutoNaoEncontradoException {
		EntityManager em = null;

		try
		{
			em = FabricaDeEntityManager.criarEntityManager();

			Produto umProduto = em.find(Produto.class, numero);

			if(umProduto == null) {
				throw new ProdutoNaoEncontradoException("Produto não encontrado");
			}
			return umProduto;
		}

		finally {
			em.close();
		}
	}

	public void altera(Produto umProduto) throws ProdutoNaoEncontradoException {
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

			em.merge(umProduto);
			tx.commit();
		}
		catch(RuntimeException e)
		{
			if (tx != null) {
				tx.rollback();
		    }
		    throw e;
		}

		finally {
			em.close();
		}
	}

	public void exclui(long numero) throws ProdutoNaoEncontradoException {
		EntityManager em = null;
		EntityTransaction tx = null;

		try
		{
			em = FabricaDeEntityManager.criarEntityManager();
			tx = em.getTransaction();
			tx.begin();

			Produto produto = em.find(Produto.class, numero);

			if(produto == null) {
				tx.rollback();
				throw new ProdutoNaoEncontradoException("Produto não encontrado");
			}

			em.remove(produto);
			tx.commit();
		}
		catch(RuntimeException e)
		{
			if (tx != null) {
				tx.rollback();
		    }
		    throw e;
		}

		finally {
			em.close();
		}
	}

	public List<Produto> recuperaProdutos() {
		EntityManager em = null;

		try
		{
			em = FabricaDeEntityManager.criarEntityManager();

			List produtos = em
					.createQuery("SELECT p FROM Produto p ORDER BY p.id")
					.getResultList();

			return produtos;
		}

		finally {
			em.close();
		}
	}
}