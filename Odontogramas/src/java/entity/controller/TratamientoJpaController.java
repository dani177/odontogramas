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
import entity.Datosconsulta;
import entity.Tratamiento;
import entity.controller.exceptions.NonexistentEntityException;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;


public class TratamientoJpaController implements Serializable {

    public TratamientoJpaController() {

    }
    public EntityManager getEntityManager() {
        return jpaConnection.getEntityManager();
    }

    public void create(Tratamiento tratamiento) {
        if (tratamiento.getDatosconsultaList() == null) {
            tratamiento.setDatosconsultaList(new ArrayList<Datosconsulta>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Datosconsulta> attachedDatosconsultaList = new ArrayList<Datosconsulta>();
            for (Datosconsulta datosconsultaListDatosconsultaToAttach : tratamiento.getDatosconsultaList()) {
                datosconsultaListDatosconsultaToAttach = em.getReference(datosconsultaListDatosconsultaToAttach.getClass(), datosconsultaListDatosconsultaToAttach.getIddatosConsulta());
                attachedDatosconsultaList.add(datosconsultaListDatosconsultaToAttach);
            }
            tratamiento.setDatosconsultaList(attachedDatosconsultaList);
            em.persist(tratamiento);
            for (Datosconsulta datosconsultaListDatosconsulta : tratamiento.getDatosconsultaList()) {
                datosconsultaListDatosconsulta.getTratamientoList().add(tratamiento);
                datosconsultaListDatosconsulta = em.merge(datosconsultaListDatosconsulta);
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
            List<Datosconsulta> datosconsultaListOld = persistentTratamiento.getDatosconsultaList();
            List<Datosconsulta> datosconsultaListNew = tratamiento.getDatosconsultaList();
            List<Datosconsulta> attachedDatosconsultaListNew = new ArrayList<Datosconsulta>();
            for (Datosconsulta datosconsultaListNewDatosconsultaToAttach : datosconsultaListNew) {
                datosconsultaListNewDatosconsultaToAttach = em.getReference(datosconsultaListNewDatosconsultaToAttach.getClass(), datosconsultaListNewDatosconsultaToAttach.getIddatosConsulta());
                attachedDatosconsultaListNew.add(datosconsultaListNewDatosconsultaToAttach);
            }
            datosconsultaListNew = attachedDatosconsultaListNew;
            tratamiento.setDatosconsultaList(datosconsultaListNew);
            tratamiento = em.merge(tratamiento);
            for (Datosconsulta datosconsultaListOldDatosconsulta : datosconsultaListOld) {
                if (!datosconsultaListNew.contains(datosconsultaListOldDatosconsulta)) {
                    datosconsultaListOldDatosconsulta.getTratamientoList().remove(tratamiento);
                    datosconsultaListOldDatosconsulta = em.merge(datosconsultaListOldDatosconsulta);
                }
            }
            for (Datosconsulta datosconsultaListNewDatosconsulta : datosconsultaListNew) {
                if (!datosconsultaListOld.contains(datosconsultaListNewDatosconsulta)) {
                    datosconsultaListNewDatosconsulta.getTratamientoList().add(tratamiento);
                    datosconsultaListNewDatosconsulta = em.merge(datosconsultaListNewDatosconsulta);
                }
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
            List<Datosconsulta> datosconsultaList = tratamiento.getDatosconsultaList();
            for (Datosconsulta datosconsultaListDatosconsulta : datosconsultaList) {
                datosconsultaListDatosconsulta.getTratamientoList().remove(tratamiento);
                datosconsultaListDatosconsulta = em.merge(datosconsultaListDatosconsulta);
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
