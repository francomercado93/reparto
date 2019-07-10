package repos

import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence
import javax.persistence.PersistenceException

abstract class RepoDefault<T> {

	static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Reparto")

	def getEntityManager() {
		entityManagerFactory.createEntityManager
	}

	abstract def Class<T> getEntityType()

	def create(T t) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				persist(t)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager?.close
		}
	}

}
