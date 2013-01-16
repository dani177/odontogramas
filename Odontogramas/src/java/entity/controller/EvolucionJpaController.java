/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity.controller;

import conexion.jpaConnection;
import entity.Evolucion;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import entity.Tratamiento;
import entity.controller.exceptions.NonexistentEntityException;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

/**
 *
 * @author jubarcos
 */
public class EvolucionJpaController implements Serializable {

    public EvolucionJpaController() {
        
    }

    public EntityManager getEntityManager() {
        return jpaConnection.getEntityManager();
    }

    public void create(Evolucion evolucion) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Tratamiento tratamientoIdtratamiento = evolucion.getTratamientoIdtratamiento();
            if (tratamientoIdtratamiento != null) {
                tratamientoIdtratamiento = em.getReference(tratamientoIdtratamiento.getClass(), tratamientoIdtratamiento.getIdtratamiento());
                evolucion.setTratamientoIdtratamiento(tratamientoIdtratamiento);
            }
            em.persist(evolucion);
            if (tratamientoIdtratamiento != null) {
                tratamientoIdtratamiento.getEvolucionList().add(evolucion);
                tratamientoIdtratamiento = em.merge(tratamientoIdtratamiento);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Evolucion evolucion) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Evolucion persistentEvolucion = em.find(Evolucion.class, evolucion.getIdevolucion());
            Tratamiento tratamientoIdtratamientoOld = persistentEvolucion.getTratamientoIdtratamiento();
            Tratamiento tratamientoIdtratamientoNew = evolucion.getTratamientoIdtratamiento();
            if (tratamientoIdtratamientoNew != null) {
                tratamientoIdtratamientoNew = em.getReference(tratamientoIdtratamientoNew.getClass(), tratamientoIdtratamientoNew.getIdtratamiento());
                evolucion.setTratamientoIdtratamiento(tratamientoIdtratamientoNew);
            }
            evolucion = em.merge(evolucion);
            if (tratamientoIdtratamientoOld != null && !tratamientoIdtratamientoOld.equals(tratamientoIdtratamientoNew)) {
                tratamientoIdtratamientoOld.getEvolucionList().remove(evolucion);
                tratamientoIdtratamientoOld = em.merge(tratamientoIdtratamientoOld);
            }
            if (tratamientoIdtratamientoNew != null && !tratamientoIdtratamientoNew.equals(tratamientoIdtratamientoOld)) {
                tratamientoIdtratamientoNew.getEvolucionList().add(evolucion);
                tratamientoIdtratamientoNew = em.merge(tratamientoIdtratamientoNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = evolucion.getIdevolucion();
                if (findEvolucion(id) == null) {
                    throw new NonexistentEntityException("The evolucion with id " + id + " no longer exists.");
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
            Evolucion evolucion;
            try {
                evolucion = em.getReference(Evolucion.class, id);
                evolucion.getIdevolucion();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The evolucion with id " + id + " no longer exists.", enfe);
            }
            Tratamiento tratamientoIdtratamiento = evolucion.getTratamientoIdtratamiento();
            if (tratamientoIdtratamiento != null) {
                tratamientoIdtratamiento.getEvolucionList().remove(evolucion);
                tratamientoIdtratamiento = em.merge(tratamientoIdtratamiento);
            }
            em.remove(evolucion);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Evolucion> findEvolucionEntities() {
        return findEvolucionEntities(true, -1, -1);
    }

    public List<Evolucion> findEvolucionEntities(int maxResults, int firstResult) {
        return findEvolucionEntities(false, maxResults, firstResult);
    }

    private List<Evolucion> findEvolucionEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Evolucion.class));
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

    public Evolucion findEvolucion(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Evolucion.class, id);
        } finally {
            em.close();
        }
    }

    public int getEvolucionCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Evolucion> rt = cq.from(Evolucion.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
