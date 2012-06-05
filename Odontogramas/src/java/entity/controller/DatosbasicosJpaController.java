/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity.controller;

import entity.Datosbasicos;
import entity.controller.exceptions.NonexistentEntityException;
import java.io.Serializable;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;


public class DatosbasicosJpaController implements Serializable {

    public DatosbasicosJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Datosbasicos datosbasicos) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(datosbasicos);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Datosbasicos datosbasicos) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            datosbasicos = em.merge(datosbasicos);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = datosbasicos.getIddatosBasicos();
                if (findDatosbasicos(id) == null) {
                    throw new NonexistentEntityException("The datosbasicos with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Datosbasicos datosbasicos;
            try {
                datosbasicos = em.getReference(Datosbasicos.class, id);
                datosbasicos.getIddatosBasicos();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The datosbasicos with id " + id + " no longer exists.", enfe);
            }
            em.remove(datosbasicos);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Datosbasicos> findDatosbasicosEntities() {
        return findDatosbasicosEntities(true, -1, -1);
    }

    public List<Datosbasicos> findDatosbasicosEntities(int maxResults, int firstResult) {
        return findDatosbasicosEntities(false, maxResults, firstResult);
    }

    private List<Datosbasicos> findDatosbasicosEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Datosbasicos.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Datosbasicos findDatosbasicos(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Datosbasicos.class, id);
        } finally {
            em.close();
        }
    }

    public int getDatosbasicosCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Datosbasicos> rt = cq.from(Datosbasicos.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

}
