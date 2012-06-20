/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity.controller;

import entity.Datosconsulta;
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


public class DatosconsultaJpaController implements Serializable {

    public DatosconsultaJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Datosconsulta datosconsulta) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Paciente pacienteIdpersona = datosconsulta.getPacienteIdpersona();
            if (pacienteIdpersona != null) {
                pacienteIdpersona = em.getReference(pacienteIdpersona.getClass(), pacienteIdpersona.getIdpersona());
                datosconsulta.setPacienteIdpersona(pacienteIdpersona);
            }
            em.persist(datosconsulta);
            if (pacienteIdpersona != null) {
                pacienteIdpersona.getDatosconsultaList().add(datosconsulta);
                pacienteIdpersona = em.merge(pacienteIdpersona);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Datosconsulta datosconsulta) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Datosconsulta persistentDatosconsulta = em.find(Datosconsulta.class, datosconsulta.getIddatosConsulta());
            Paciente pacienteIdpersonaOld = persistentDatosconsulta.getPacienteIdpersona();
            Paciente pacienteIdpersonaNew = datosconsulta.getPacienteIdpersona();
            if (pacienteIdpersonaNew != null) {
                pacienteIdpersonaNew = em.getReference(pacienteIdpersonaNew.getClass(), pacienteIdpersonaNew.getIdpersona());
                datosconsulta.setPacienteIdpersona(pacienteIdpersonaNew);
            }
            datosconsulta = em.merge(datosconsulta);
            if (pacienteIdpersonaOld != null && !pacienteIdpersonaOld.equals(pacienteIdpersonaNew)) {
                pacienteIdpersonaOld.getDatosconsultaList().remove(datosconsulta);
                pacienteIdpersonaOld = em.merge(pacienteIdpersonaOld);
            }
            if (pacienteIdpersonaNew != null && !pacienteIdpersonaNew.equals(pacienteIdpersonaOld)) {
                pacienteIdpersonaNew.getDatosconsultaList().add(datosconsulta);
                pacienteIdpersonaNew = em.merge(pacienteIdpersonaNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = datosconsulta.getIddatosConsulta();
                if (findDatosconsulta(id) == null) {
                    throw new NonexistentEntityException("The datosconsulta with id " + id + " no longer exists.");
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
            Datosconsulta datosconsulta;
            try {
                datosconsulta = em.getReference(Datosconsulta.class, id);
                datosconsulta.getIddatosConsulta();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The datosconsulta with id " + id + " no longer exists.", enfe);
            }
            Paciente pacienteIdpersona = datosconsulta.getPacienteIdpersona();
            if (pacienteIdpersona != null) {
                pacienteIdpersona.getDatosconsultaList().remove(datosconsulta);
                pacienteIdpersona = em.merge(pacienteIdpersona);
            }
            em.remove(datosconsulta);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Datosconsulta> findDatosconsultaEntities() {
        return findDatosconsultaEntities(true, -1, -1);
    }

    public List<Datosconsulta> findDatosconsultaEntities(int maxResults, int firstResult) {
        return findDatosconsultaEntities(false, maxResults, firstResult);
    }

    private List<Datosconsulta> findDatosconsultaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Datosconsulta.class));
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

    public Datosconsulta findDatosconsulta(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Datosconsulta.class, id);
        } finally {
            em.close();
        }
    }

    public int getDatosconsultaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Datosconsulta> rt = cq.from(Datosconsulta.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

}
