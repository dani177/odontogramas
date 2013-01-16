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
import entity.Datosbasicos;
import entity.DatosconsultaHasDatosbasicos;
import entity.controller.exceptions.NonexistentEntityException;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

public class DatosconsultaHasDatosbasicosJpaController implements Serializable {

    public DatosconsultaHasDatosbasicosJpaController() {
    }

    public EntityManager getEntityManager() {
        return jpaConnection.getEntityManager();
    }

    public void create(DatosconsultaHasDatosbasicos datosconsultaHasDatosbasicos) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Consulta datosConsultaiddatosConsulta = datosconsultaHasDatosbasicos.getDatosConsultaiddatosConsulta();
            if (datosConsultaiddatosConsulta != null) {
                datosConsultaiddatosConsulta = em.getReference(datosConsultaiddatosConsulta.getClass(), datosConsultaiddatosConsulta.getIddatosConsulta());
                datosconsultaHasDatosbasicos.setDatosConsultaiddatosConsulta(datosConsultaiddatosConsulta);
            }
            Datosbasicos datosBasicosiddatosBasicos = datosconsultaHasDatosbasicos.getDatosBasicosiddatosBasicos();
            if (datosBasicosiddatosBasicos != null) {
                datosBasicosiddatosBasicos = em.getReference(datosBasicosiddatosBasicos.getClass(), datosBasicosiddatosBasicos.getIddatosBasicos());
                datosconsultaHasDatosbasicos.setDatosBasicosiddatosBasicos(datosBasicosiddatosBasicos);
            }
            em.persist(datosconsultaHasDatosbasicos);
            if (datosConsultaiddatosConsulta != null) {
                datosConsultaiddatosConsulta.getDatosconsultaHasDatosbasicosList().add(datosconsultaHasDatosbasicos);
                datosConsultaiddatosConsulta = em.merge(datosConsultaiddatosConsulta);
            }
            if (datosBasicosiddatosBasicos != null) {
                datosBasicosiddatosBasicos.getDatosconsultaHasDatosbasicosList().add(datosconsultaHasDatosbasicos);
                datosBasicosiddatosBasicos = em.merge(datosBasicosiddatosBasicos);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(DatosconsultaHasDatosbasicos datosconsultaHasDatosbasicos) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            DatosconsultaHasDatosbasicos persistentDatosconsultaHasDatosbasicos = em.find(DatosconsultaHasDatosbasicos.class, datosconsultaHasDatosbasicos.getIdConsultadatosBasicos());
            Consulta datosConsultaiddatosConsultaOld = persistentDatosconsultaHasDatosbasicos.getDatosConsultaiddatosConsulta();
            Consulta datosConsultaiddatosConsultaNew = datosconsultaHasDatosbasicos.getDatosConsultaiddatosConsulta();
            Datosbasicos datosBasicosiddatosBasicosOld = persistentDatosconsultaHasDatosbasicos.getDatosBasicosiddatosBasicos();
            Datosbasicos datosBasicosiddatosBasicosNew = datosconsultaHasDatosbasicos.getDatosBasicosiddatosBasicos();
            if (datosConsultaiddatosConsultaNew != null) {
                datosConsultaiddatosConsultaNew = em.getReference(datosConsultaiddatosConsultaNew.getClass(), datosConsultaiddatosConsultaNew.getIddatosConsulta());
                datosconsultaHasDatosbasicos.setDatosConsultaiddatosConsulta(datosConsultaiddatosConsultaNew);
            }
            if (datosBasicosiddatosBasicosNew != null) {
                datosBasicosiddatosBasicosNew = em.getReference(datosBasicosiddatosBasicosNew.getClass(), datosBasicosiddatosBasicosNew.getIddatosBasicos());
                datosconsultaHasDatosbasicos.setDatosBasicosiddatosBasicos(datosBasicosiddatosBasicosNew);
            }
            datosconsultaHasDatosbasicos = em.merge(datosconsultaHasDatosbasicos);
            if (datosConsultaiddatosConsultaOld != null && !datosConsultaiddatosConsultaOld.equals(datosConsultaiddatosConsultaNew)) {
                datosConsultaiddatosConsultaOld.getDatosconsultaHasDatosbasicosList().remove(datosconsultaHasDatosbasicos);
                datosConsultaiddatosConsultaOld = em.merge(datosConsultaiddatosConsultaOld);
            }
            if (datosConsultaiddatosConsultaNew != null && !datosConsultaiddatosConsultaNew.equals(datosConsultaiddatosConsultaOld)) {
                datosConsultaiddatosConsultaNew.getDatosconsultaHasDatosbasicosList().add(datosconsultaHasDatosbasicos);
                datosConsultaiddatosConsultaNew = em.merge(datosConsultaiddatosConsultaNew);
            }
            if (datosBasicosiddatosBasicosOld != null && !datosBasicosiddatosBasicosOld.equals(datosBasicosiddatosBasicosNew)) {
                datosBasicosiddatosBasicosOld.getDatosconsultaHasDatosbasicosList().remove(datosconsultaHasDatosbasicos);
                datosBasicosiddatosBasicosOld = em.merge(datosBasicosiddatosBasicosOld);
            }
            if (datosBasicosiddatosBasicosNew != null && !datosBasicosiddatosBasicosNew.equals(datosBasicosiddatosBasicosOld)) {
                datosBasicosiddatosBasicosNew.getDatosconsultaHasDatosbasicosList().add(datosconsultaHasDatosbasicos);
                datosBasicosiddatosBasicosNew = em.merge(datosBasicosiddatosBasicosNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = datosconsultaHasDatosbasicos.getIdConsultadatosBasicos();
                if (findDatosconsultaHasDatosbasicos(id) == null) {
                    throw new NonexistentEntityException("The datosconsultaHasDatosbasicos with id " + id + " no longer exists.");
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
            DatosconsultaHasDatosbasicos datosconsultaHasDatosbasicos;
            try {
                datosconsultaHasDatosbasicos = em.getReference(DatosconsultaHasDatosbasicos.class, id);
                datosconsultaHasDatosbasicos.getIdConsultadatosBasicos();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The datosconsultaHasDatosbasicos with id " + id + " no longer exists.", enfe);
            }
            Consulta datosConsultaiddatosConsulta = datosconsultaHasDatosbasicos.getDatosConsultaiddatosConsulta();
            if (datosConsultaiddatosConsulta != null) {
                datosConsultaiddatosConsulta.getDatosconsultaHasDatosbasicosList().remove(datosconsultaHasDatosbasicos);
                datosConsultaiddatosConsulta = em.merge(datosConsultaiddatosConsulta);
            }
            Datosbasicos datosBasicosiddatosBasicos = datosconsultaHasDatosbasicos.getDatosBasicosiddatosBasicos();
            if (datosBasicosiddatosBasicos != null) {
                datosBasicosiddatosBasicos.getDatosconsultaHasDatosbasicosList().remove(datosconsultaHasDatosbasicos);
                datosBasicosiddatosBasicos = em.merge(datosBasicosiddatosBasicos);
            }
            em.remove(datosconsultaHasDatosbasicos);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<DatosconsultaHasDatosbasicos> findDatosconsultaHasDatosbasicosEntities() {
        return findDatosconsultaHasDatosbasicosEntities(true, -1, -1);
    }

    public List<DatosconsultaHasDatosbasicos> findDatosconsultaHasDatosbasicosEntities(int maxResults, int firstResult) {
        return findDatosconsultaHasDatosbasicosEntities(false, maxResults, firstResult);
    }

    private List<DatosconsultaHasDatosbasicos> findDatosconsultaHasDatosbasicosEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(DatosconsultaHasDatosbasicos.class));
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

    public DatosconsultaHasDatosbasicos findDatosconsultaHasDatosbasicos(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(DatosconsultaHasDatosbasicos.class, id);
        } finally {
            em.close();
        }
    }

    public int getDatosconsultaHasDatosbasicosCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<DatosconsultaHasDatosbasicos> rt = cq.from(DatosconsultaHasDatosbasicos.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
