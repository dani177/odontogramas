/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity.controller;

import entity.Examenfisicoestomatologico;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import entity.Paciente;
import entity.controller.exceptions.NonexistentEntityException;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;


public class ExamenfisicoestomatologicoJpaController implements Serializable {

    public ExamenfisicoestomatologicoJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Examenfisicoestomatologico examenfisicoestomatologico) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Paciente pacienteidpersona = examenfisicoestomatologico.getPacienteidpersona();
            if (pacienteidpersona != null) {
                pacienteidpersona = em.getReference(pacienteidpersona.getClass(), pacienteidpersona.getIdpersona());
                examenfisicoestomatologico.setPacienteidpersona(pacienteidpersona);
            }
            em.persist(examenfisicoestomatologico);
            if (pacienteidpersona != null) {
                pacienteidpersona.getExamenfisicoestomatologicoCollection().add(examenfisicoestomatologico);
                pacienteidpersona = em.merge(pacienteidpersona);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Examenfisicoestomatologico examenfisicoestomatologico) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Examenfisicoestomatologico persistentExamenfisicoestomatologico = em.find(Examenfisicoestomatologico.class, examenfisicoestomatologico.getIdexamenFisicoEstomatologico());
            Paciente pacienteidpersonaOld = persistentExamenfisicoestomatologico.getPacienteidpersona();
            Paciente pacienteidpersonaNew = examenfisicoestomatologico.getPacienteidpersona();
            if (pacienteidpersonaNew != null) {
                pacienteidpersonaNew = em.getReference(pacienteidpersonaNew.getClass(), pacienteidpersonaNew.getIdpersona());
                examenfisicoestomatologico.setPacienteidpersona(pacienteidpersonaNew);
            }
            examenfisicoestomatologico = em.merge(examenfisicoestomatologico);
            if (pacienteidpersonaOld != null && !pacienteidpersonaOld.equals(pacienteidpersonaNew)) {
                pacienteidpersonaOld.getExamenfisicoestomatologicoCollection().remove(examenfisicoestomatologico);
                pacienteidpersonaOld = em.merge(pacienteidpersonaOld);
            }
            if (pacienteidpersonaNew != null && !pacienteidpersonaNew.equals(pacienteidpersonaOld)) {
                pacienteidpersonaNew.getExamenfisicoestomatologicoCollection().add(examenfisicoestomatologico);
                pacienteidpersonaNew = em.merge(pacienteidpersonaNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = examenfisicoestomatologico.getIdexamenFisicoEstomatologico();
                if (findExamenfisicoestomatologico(id) == null) {
                    throw new NonexistentEntityException("The examenfisicoestomatologico with id " + id + " no longer exists.");
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
            Examenfisicoestomatologico examenfisicoestomatologico;
            try {
                examenfisicoestomatologico = em.getReference(Examenfisicoestomatologico.class, id);
                examenfisicoestomatologico.getIdexamenFisicoEstomatologico();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The examenfisicoestomatologico with id " + id + " no longer exists.", enfe);
            }
            Paciente pacienteidpersona = examenfisicoestomatologico.getPacienteidpersona();
            if (pacienteidpersona != null) {
                pacienteidpersona.getExamenfisicoestomatologicoCollection().remove(examenfisicoestomatologico);
                pacienteidpersona = em.merge(pacienteidpersona);
            }
            em.remove(examenfisicoestomatologico);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Examenfisicoestomatologico> findExamenfisicoestomatologicoEntities() {
        return findExamenfisicoestomatologicoEntities(true, -1, -1);
    }

    public List<Examenfisicoestomatologico> findExamenfisicoestomatologicoEntities(int maxResults, int firstResult) {
        return findExamenfisicoestomatologicoEntities(false, maxResults, firstResult);
    }

    private List<Examenfisicoestomatologico> findExamenfisicoestomatologicoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Examenfisicoestomatologico.class));
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

    public Examenfisicoestomatologico findExamenfisicoestomatologico(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Examenfisicoestomatologico.class, id);
        } finally {
            em.close();
        }
    }

    public int getExamenfisicoestomatologicoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Examenfisicoestomatologico> rt = cq.from(Examenfisicoestomatologico.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

}
