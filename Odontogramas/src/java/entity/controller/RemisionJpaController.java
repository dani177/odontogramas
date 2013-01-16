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
import entity.Remision;
import entity.controller.exceptions.NonexistentEntityException;
import entity.controller.exceptions.PreexistingEntityException;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;


public class RemisionJpaController implements Serializable {

    public RemisionJpaController() {
        
    }

    public EntityManager getEntityManager() {
    return jpaConnection.getEntityManager();
    }

    public void create(Remision remision) throws PreexistingEntityException, Exception {
        if (remision.getConsultaList() == null) {
            remision.setConsultaList(new ArrayList<Consulta>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Consulta> attachedConsultaList = new ArrayList<Consulta>();
            for (Consulta consultaListConsultaToAttach : remision.getConsultaList()) {
                consultaListConsultaToAttach = em.getReference(consultaListConsultaToAttach.getClass(), consultaListConsultaToAttach.getIddatosConsulta());
                attachedConsultaList.add(consultaListConsultaToAttach);
            }
            remision.setConsultaList(attachedConsultaList);
            em.persist(remision);
            for (Consulta consultaListConsulta : remision.getConsultaList()) {
                consultaListConsulta.getRemisionList().add(remision);
                consultaListConsulta = em.merge(consultaListConsulta);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findRemision(remision.getIdremision()) != null) {
                throw new PreexistingEntityException("Remision " + remision + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Remision remision) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Remision persistentRemision = em.find(Remision.class, remision.getIdremision());
            List<Consulta> consultaListOld = persistentRemision.getConsultaList();
            List<Consulta> consultaListNew = remision.getConsultaList();
            List<Consulta> attachedConsultaListNew = new ArrayList<Consulta>();
            for (Consulta consultaListNewConsultaToAttach : consultaListNew) {
                consultaListNewConsultaToAttach = em.getReference(consultaListNewConsultaToAttach.getClass(), consultaListNewConsultaToAttach.getIddatosConsulta());
                attachedConsultaListNew.add(consultaListNewConsultaToAttach);
            }
            consultaListNew = attachedConsultaListNew;
            remision.setConsultaList(consultaListNew);
            remision = em.merge(remision);
            for (Consulta consultaListOldConsulta : consultaListOld) {
                if (!consultaListNew.contains(consultaListOldConsulta)) {
                    consultaListOldConsulta.getRemisionList().remove(remision);
                    consultaListOldConsulta = em.merge(consultaListOldConsulta);
                }
            }
            for (Consulta consultaListNewConsulta : consultaListNew) {
                if (!consultaListOld.contains(consultaListNewConsulta)) {
                    consultaListNewConsulta.getRemisionList().add(remision);
                    consultaListNewConsulta = em.merge(consultaListNewConsulta);
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = remision.getIdremision();
                if (findRemision(id) == null) {
                    throw new NonexistentEntityException("The remision with id " + id + " no longer exists.");
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
            Remision remision;
            try {
                remision = em.getReference(Remision.class, id);
                remision.getIdremision();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The remision with id " + id + " no longer exists.", enfe);
            }
            List<Consulta> consultaList = remision.getConsultaList();
            for (Consulta consultaListConsulta : consultaList) {
                consultaListConsulta.getRemisionList().remove(remision);
                consultaListConsulta = em.merge(consultaListConsulta);
            }
            em.remove(remision);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Remision> findRemisionEntities() {
        return findRemisionEntities(true, -1, -1);
    }

    public List<Remision> findRemisionEntities(int maxResults, int firstResult) {
        return findRemisionEntities(false, maxResults, firstResult);
    }

    private List<Remision> findRemisionEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Remision.class));
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

    public Remision findRemision(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Remision.class, id);
        } finally {
            em.close();
        }
    }

    public int getRemisionCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Remision> rt = cq.from(Remision.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
