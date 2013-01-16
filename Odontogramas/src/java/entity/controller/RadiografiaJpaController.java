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
import entity.Consulta;
import entity.Radiografia;
import entity.controller.exceptions.NonexistentEntityException;
import entity.controller.exceptions.PreexistingEntityException;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

/**
 *
 * @author Oscar Ballesteros
 */
public class RadiografiaJpaController implements Serializable {

    public RadiografiaJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Radiografia radiografia) throws PreexistingEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Consulta datosConsultaiddatosConsulta = radiografia.getDatosConsultaiddatosConsulta();
            if (datosConsultaiddatosConsulta != null) {
                datosConsultaiddatosConsulta = em.getReference(datosConsultaiddatosConsulta.getClass(), datosConsultaiddatosConsulta.getIddatosConsulta());
                radiografia.setDatosConsultaiddatosConsulta(datosConsultaiddatosConsulta);
            }
            em.persist(radiografia);
            if (datosConsultaiddatosConsulta != null) {
                datosConsultaiddatosConsulta.getRadiografiaList().add(radiografia);
                datosConsultaiddatosConsulta = em.merge(datosConsultaiddatosConsulta);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findRadiografia(radiografia.getIdradiografia()) != null) {
                throw new PreexistingEntityException("Radiografia " + radiografia + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Radiografia radiografia) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Radiografia persistentRadiografia = em.find(Radiografia.class, radiografia.getIdradiografia());
            Consulta datosConsultaiddatosConsultaOld = persistentRadiografia.getDatosConsultaiddatosConsulta();
            Consulta datosConsultaiddatosConsultaNew = radiografia.getDatosConsultaiddatosConsulta();
            if (datosConsultaiddatosConsultaNew != null) {
                datosConsultaiddatosConsultaNew = em.getReference(datosConsultaiddatosConsultaNew.getClass(), datosConsultaiddatosConsultaNew.getIddatosConsulta());
                radiografia.setDatosConsultaiddatosConsulta(datosConsultaiddatosConsultaNew);
            }
            radiografia = em.merge(radiografia);
            if (datosConsultaiddatosConsultaOld != null && !datosConsultaiddatosConsultaOld.equals(datosConsultaiddatosConsultaNew)) {
                datosConsultaiddatosConsultaOld.getRadiografiaList().remove(radiografia);
                datosConsultaiddatosConsultaOld = em.merge(datosConsultaiddatosConsultaOld);
            }
            if (datosConsultaiddatosConsultaNew != null && !datosConsultaiddatosConsultaNew.equals(datosConsultaiddatosConsultaOld)) {
                datosConsultaiddatosConsultaNew.getRadiografiaList().add(radiografia);
                datosConsultaiddatosConsultaNew = em.merge(datosConsultaiddatosConsultaNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = radiografia.getIdradiografia();
                if (findRadiografia(id) == null) {
                    throw new NonexistentEntityException("The radiografia with id " + id + " no longer exists.");
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
            Radiografia radiografia;
            try {
                radiografia = em.getReference(Radiografia.class, id);
                radiografia.getIdradiografia();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The radiografia with id " + id + " no longer exists.", enfe);
            }
            Consulta datosConsultaiddatosConsulta = radiografia.getDatosConsultaiddatosConsulta();
            if (datosConsultaiddatosConsulta != null) {
                datosConsultaiddatosConsulta.getRadiografiaList().remove(radiografia);
                datosConsultaiddatosConsulta = em.merge(datosConsultaiddatosConsulta);
            }
            em.remove(radiografia);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Radiografia> findRadiografiaEntities() {
        return findRadiografiaEntities(true, -1, -1);
    }

    public List<Radiografia> findRadiografiaEntities(int maxResults, int firstResult) {
        return findRadiografiaEntities(false, maxResults, firstResult);
    }

    private List<Radiografia> findRadiografiaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Radiografia.class));
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

    public Radiografia findRadiografia(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Radiografia.class, id);
        } finally {
            em.close();
        }
    }

    public int getRadiografiaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Radiografia> rt = cq.from(Radiografia.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
