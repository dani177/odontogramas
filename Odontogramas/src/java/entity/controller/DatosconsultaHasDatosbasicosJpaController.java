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
import entity.Datosbasicos;
import entity.Consulta;
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
            Datosbasicos datosBasicosiddatosBasicos = datosconsultaHasDatosbasicos.getDatosBasicosiddatosBasicos();
            if (datosBasicosiddatosBasicos != null) {
                datosBasicosiddatosBasicos = em.getReference(datosBasicosiddatosBasicos.getClass(), datosBasicosiddatosBasicos.getIddatosBasicos());
                datosconsultaHasDatosbasicos.setDatosBasicosiddatosBasicos(datosBasicosiddatosBasicos);
            }
            Consulta datosConsultaiddatosConsulta = datosconsultaHasDatosbasicos.getDatosConsultaiddatosConsulta();
            if (datosConsultaiddatosConsulta != null) {
                datosConsultaiddatosConsulta = em.getReference(datosConsultaiddatosConsulta.getClass(), datosConsultaiddatosConsulta.getIddatosConsulta());
                datosconsultaHasDatosbasicos.setDatosConsultaiddatosConsulta(datosConsultaiddatosConsulta);
            }
            em.persist(datosconsultaHasDatosbasicos);
            if (datosBasicosiddatosBasicos != null) {
                datosBasicosiddatosBasicos.getDatosconsultaHasDatosbasicosList().add(datosconsultaHasDatosbasicos);
                datosBasicosiddatosBasicos = em.merge(datosBasicosiddatosBasicos);
            }
            if (datosConsultaiddatosConsulta != null) {
                datosConsultaiddatosConsulta.getDatosconsultaHasDatosbasicosList().add(datosconsultaHasDatosbasicos);
                datosConsultaiddatosConsulta = em.merge(datosConsultaiddatosConsulta);
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
            Datosbasicos datosBasicosiddatosBasicosOld = persistentDatosconsultaHasDatosbasicos.getDatosBasicosiddatosBasicos();
            Datosbasicos datosBasicosiddatosBasicosNew = datosconsultaHasDatosbasicos.getDatosBasicosiddatosBasicos();
            Consulta datosConsultaiddatosConsultaOld = persistentDatosconsultaHasDatosbasicos.getDatosConsultaiddatosConsulta();
            Consulta datosConsultaiddatosConsultaNew = datosconsultaHasDatosbasicos.getDatosConsultaiddatosConsulta();
            if (datosBasicosiddatosBasicosNew != null) {
                datosBasicosiddatosBasicosNew = em.getReference(datosBasicosiddatosBasicosNew.getClass(), datosBasicosiddatosBasicosNew.getIddatosBasicos());
                datosconsultaHasDatosbasicos.setDatosBasicosiddatosBasicos(datosBasicosiddatosBasicosNew);
            }
            if (datosConsultaiddatosConsultaNew != null) {
                datosConsultaiddatosConsultaNew = em.getReference(datosConsultaiddatosConsultaNew.getClass(), datosConsultaiddatosConsultaNew.getIddatosConsulta());
                datosconsultaHasDatosbasicos.setDatosConsultaiddatosConsulta(datosConsultaiddatosConsultaNew);
            }
            datosconsultaHasDatosbasicos = em.merge(datosconsultaHasDatosbasicos);
            if (datosBasicosiddatosBasicosOld != null && !datosBasicosiddatosBasicosOld.equals(datosBasicosiddatosBasicosNew)) {
                datosBasicosiddatosBasicosOld.getDatosconsultaHasDatosbasicosList().remove(datosconsultaHasDatosbasicos);
                datosBasicosiddatosBasicosOld = em.merge(datosBasicosiddatosBasicosOld);
            }
            if (datosBasicosiddatosBasicosNew != null && !datosBasicosiddatosBasicosNew.equals(datosBasicosiddatosBasicosOld)) {
                datosBasicosiddatosBasicosNew.getDatosconsultaHasDatosbasicosList().add(datosconsultaHasDatosbasicos);
                datosBasicosiddatosBasicosNew = em.merge(datosBasicosiddatosBasicosNew);
            }
            if (datosConsultaiddatosConsultaOld != null && !datosConsultaiddatosConsultaOld.equals(datosConsultaiddatosConsultaNew)) {
                datosConsultaiddatosConsultaOld.getDatosconsultaHasDatosbasicosList().remove(datosconsultaHasDatosbasicos);
                datosConsultaiddatosConsultaOld = em.merge(datosConsultaiddatosConsultaOld);
            }
            if (datosConsultaiddatosConsultaNew != null && !datosConsultaiddatosConsultaNew.equals(datosConsultaiddatosConsultaOld)) {
                datosConsultaiddatosConsultaNew.getDatosconsultaHasDatosbasicosList().add(datosconsultaHasDatosbasicos);
                datosConsultaiddatosConsultaNew = em.merge(datosConsultaiddatosConsultaNew);
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
            Datosbasicos datosBasicosiddatosBasicos = datosconsultaHasDatosbasicos.getDatosBasicosiddatosBasicos();
            if (datosBasicosiddatosBasicos != null) {
                datosBasicosiddatosBasicos.getDatosconsultaHasDatosbasicosList().remove(datosconsultaHasDatosbasicos);
                datosBasicosiddatosBasicos = em.merge(datosBasicosiddatosBasicos);
            }
            Consulta datosConsultaiddatosConsulta = datosconsultaHasDatosbasicos.getDatosConsultaiddatosConsulta();
            if (datosConsultaiddatosConsulta != null) {
                datosConsultaiddatosConsulta.getDatosconsultaHasDatosbasicosList().remove(datosconsultaHasDatosbasicos);
                datosConsultaiddatosConsulta = em.merge(datosConsultaiddatosConsulta);
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
