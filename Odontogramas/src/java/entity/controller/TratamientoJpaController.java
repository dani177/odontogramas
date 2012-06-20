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
import entity.Tratamiento;
import entity.controller.exceptions.NonexistentEntityException;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;


public class TratamientoJpaController implements Serializable {

    public TratamientoJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Tratamiento tratamiento) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Diagnostico diagnosticoIddiagnostico = tratamiento.getDiagnosticoIddiagnostico();
            if (diagnosticoIddiagnostico != null) {
                diagnosticoIddiagnostico = em.getReference(diagnosticoIddiagnostico.getClass(), diagnosticoIddiagnostico.getIddiagnostico());
                tratamiento.setDiagnosticoIddiagnostico(diagnosticoIddiagnostico);
            }
            em.persist(tratamiento);
            if (diagnosticoIddiagnostico != null) {
                diagnosticoIddiagnostico.getTratamientoList().add(tratamiento);
                diagnosticoIddiagnostico = em.merge(diagnosticoIddiagnostico);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Tratamiento tratamiento) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Tratamiento persistentTratamiento = em.find(Tratamiento.class, tratamiento.getIdtratamiento());
            Diagnostico diagnosticoIddiagnosticoOld = persistentTratamiento.getDiagnosticoIddiagnostico();
            Diagnostico diagnosticoIddiagnosticoNew = tratamiento.getDiagnosticoIddiagnostico();
            if (diagnosticoIddiagnosticoNew != null) {
                diagnosticoIddiagnosticoNew = em.getReference(diagnosticoIddiagnosticoNew.getClass(), diagnosticoIddiagnosticoNew.getIddiagnostico());
                tratamiento.setDiagnosticoIddiagnostico(diagnosticoIddiagnosticoNew);
            }
            tratamiento = em.merge(tratamiento);
            if (diagnosticoIddiagnosticoOld != null && !diagnosticoIddiagnosticoOld.equals(diagnosticoIddiagnosticoNew)) {
                diagnosticoIddiagnosticoOld.getTratamientoList().remove(tratamiento);
                diagnosticoIddiagnosticoOld = em.merge(diagnosticoIddiagnosticoOld);
            }
            if (diagnosticoIddiagnosticoNew != null && !diagnosticoIddiagnosticoNew.equals(diagnosticoIddiagnosticoOld)) {
                diagnosticoIddiagnosticoNew.getTratamientoList().add(tratamiento);
                diagnosticoIddiagnosticoNew = em.merge(diagnosticoIddiagnosticoNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = tratamiento.getIdtratamiento();
                if (findTratamiento(id) == null) {
                    throw new NonexistentEntityException("The tratamiento with id " + id + " no longer exists.");
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
            Tratamiento tratamiento;
            try {
                tratamiento = em.getReference(Tratamiento.class, id);
                tratamiento.getIdtratamiento();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The tratamiento with id " + id + " no longer exists.", enfe);
            }
            Diagnostico diagnosticoIddiagnostico = tratamiento.getDiagnosticoIddiagnostico();
            if (diagnosticoIddiagnostico != null) {
                diagnosticoIddiagnostico.getTratamientoList().remove(tratamiento);
                diagnosticoIddiagnostico = em.merge(diagnosticoIddiagnostico);
            }
            em.remove(tratamiento);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Tratamiento> findTratamientoEntities() {
        return findTratamientoEntities(true, -1, -1);
    }

    public List<Tratamiento> findTratamientoEntities(int maxResults, int firstResult) {
        return findTratamientoEntities(false, maxResults, firstResult);
    }

    private List<Tratamiento> findTratamientoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Tratamiento.class));
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

    public Tratamiento findTratamiento(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Tratamiento.class, id);
        } finally {
            em.close();
        }
    }

    public int getTratamientoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Tratamiento> rt = cq.from(Tratamiento.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

}
