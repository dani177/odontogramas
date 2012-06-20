/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity.controller;

import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import entity.Diagnostico;
import entity.Evolucion;
import entity.controller.exceptions.NonexistentEntityException;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;


public class EvolucionJpaController implements Serializable {

    public EvolucionJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Evolucion evolucion) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Diagnostico diagnosticoIddiagnostico = evolucion.getDiagnosticoIddiagnostico();
            if (diagnosticoIddiagnostico != null) {
                diagnosticoIddiagnostico = em.getReference(diagnosticoIddiagnostico.getClass(), diagnosticoIddiagnostico.getIddiagnostico());
                evolucion.setDiagnosticoIddiagnostico(diagnosticoIddiagnostico);
            }
            em.persist(evolucion);
            if (diagnosticoIddiagnostico != null) {
                diagnosticoIddiagnostico.getEvolucionList().add(evolucion);
                diagnosticoIddiagnostico = em.merge(diagnosticoIddiagnostico);
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
            Diagnostico diagnosticoIddiagnosticoOld = persistentEvolucion.getDiagnosticoIddiagnostico();
            Diagnostico diagnosticoIddiagnosticoNew = evolucion.getDiagnosticoIddiagnostico();
            if (diagnosticoIddiagnosticoNew != null) {
                diagnosticoIddiagnosticoNew = em.getReference(diagnosticoIddiagnosticoNew.getClass(), diagnosticoIddiagnosticoNew.getIddiagnostico());
                evolucion.setDiagnosticoIddiagnostico(diagnosticoIddiagnosticoNew);
            }
            evolucion = em.merge(evolucion);
            if (diagnosticoIddiagnosticoOld != null && !diagnosticoIddiagnosticoOld.equals(diagnosticoIddiagnosticoNew)) {
                diagnosticoIddiagnosticoOld.getEvolucionList().remove(evolucion);
                diagnosticoIddiagnosticoOld = em.merge(diagnosticoIddiagnosticoOld);
            }
            if (diagnosticoIddiagnosticoNew != null && !diagnosticoIddiagnosticoNew.equals(diagnosticoIddiagnosticoOld)) {
                diagnosticoIddiagnosticoNew.getEvolucionList().add(evolucion);
                diagnosticoIddiagnosticoNew = em.merge(diagnosticoIddiagnosticoNew);
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
            Diagnostico diagnosticoIddiagnostico = evolucion.getDiagnosticoIddiagnostico();
            if (diagnosticoIddiagnostico != null) {
                diagnosticoIddiagnostico.getEvolucionList().remove(evolucion);
                diagnosticoIddiagnostico = em.merge(diagnosticoIddiagnostico);
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
