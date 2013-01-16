/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity.controller;

import conexion.jpaConnection;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import entity.Consulta;
import entity.Interconsulta;
import entity.controller.exceptions.NonexistentEntityException;
import entity.controller.exceptions.PreexistingEntityException;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;


public class InterconsultaJpaController implements Serializable {

    public InterconsultaJpaController() {
        
    }

    public EntityManager getEntityManager() {
        return jpaConnection.getEntityManager();
    }

    public void create(Interconsulta interconsulta) throws PreexistingEntityException, Exception {
        if (interconsulta.getConsultaList() == null) {
            interconsulta.setConsultaList(new ArrayList<Consulta>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Consulta> attachedConsultaList = new ArrayList<Consulta>();
            for (Consulta consultaListConsultaToAttach : interconsulta.getConsultaList()) {
                consultaListConsultaToAttach = em.getReference(consultaListConsultaToAttach.getClass(), consultaListConsultaToAttach.getIddatosConsulta());
                attachedConsultaList.add(consultaListConsultaToAttach);
            }
            interconsulta.setConsultaList(attachedConsultaList);
            em.persist(interconsulta);
            for (Consulta consultaListConsulta : interconsulta.getConsultaList()) {
                consultaListConsulta.getInterconsultaList().add(interconsulta);
                consultaListConsulta = em.merge(consultaListConsulta);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findInterconsulta(interconsulta.getIdinterconsulta()) != null) {
                throw new PreexistingEntityException("Interconsulta " + interconsulta + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Interconsulta interconsulta) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Interconsulta persistentInterconsulta = em.find(Interconsulta.class, interconsulta.getIdinterconsulta());
            List<Consulta> consultaListOld = persistentInterconsulta.getConsultaList();
            List<Consulta> consultaListNew = interconsulta.getConsultaList();
            List<Consulta> attachedConsultaListNew = new ArrayList<Consulta>();
            for (Consulta consultaListNewConsultaToAttach : consultaListNew) {
                consultaListNewConsultaToAttach = em.getReference(consultaListNewConsultaToAttach.getClass(), consultaListNewConsultaToAttach.getIddatosConsulta());
                attachedConsultaListNew.add(consultaListNewConsultaToAttach);
            }
            consultaListNew = attachedConsultaListNew;
            interconsulta.setConsultaList(consultaListNew);
            interconsulta = em.merge(interconsulta);
            for (Consulta consultaListOldConsulta : consultaListOld) {
                if (!consultaListNew.contains(consultaListOldConsulta)) {
                    consultaListOldConsulta.getInterconsultaList().remove(interconsulta);
                    consultaListOldConsulta = em.merge(consultaListOldConsulta);
                }
            }
            for (Consulta consultaListNewConsulta : consultaListNew) {
                if (!consultaListOld.contains(consultaListNewConsulta)) {
                    consultaListNewConsulta.getInterconsultaList().add(interconsulta);
                    consultaListNewConsulta = em.merge(consultaListNewConsulta);
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = interconsulta.getIdinterconsulta();
                if (findInterconsulta(id) == null) {
                    throw new NonexistentEntityException("The interconsulta with id " + id + " no longer exists.");
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
            Interconsulta interconsulta;
            try {
                interconsulta = em.getReference(Interconsulta.class, id);
                interconsulta.getIdinterconsulta();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The interconsulta with id " + id + " no longer exists.", enfe);
            }
            List<Consulta> consultaList = interconsulta.getConsultaList();
            for (Consulta consultaListConsulta : consultaList) {
                consultaListConsulta.getInterconsultaList().remove(interconsulta);
                consultaListConsulta = em.merge(consultaListConsulta);
            }
            em.remove(interconsulta);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Interconsulta> findInterconsultaEntities() {
        return findInterconsultaEntities(true, -1, -1);
    }

    public List<Interconsulta> findInterconsultaEntities(int maxResults, int firstResult) {
        return findInterconsultaEntities(false, maxResults, firstResult);
    }

    private List<Interconsulta> findInterconsultaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Interconsulta.class));
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

    public Interconsulta findInterconsulta(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Interconsulta.class, id);
        } finally {
            em.close();
        }
    }

    public int getInterconsultaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Interconsulta> rt = cq.from(Interconsulta.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
