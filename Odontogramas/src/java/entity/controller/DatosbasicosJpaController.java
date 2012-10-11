/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity.controller;

import conexion.jpaConnection;
import entity.Datosbasicos;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import entity.DatosconsultaHasDatosbasicos;
import entity.controller.exceptions.IllegalOrphanException;
import entity.controller.exceptions.NonexistentEntityException;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;


public class DatosbasicosJpaController implements Serializable {

    public DatosbasicosJpaController() {
    }

    public EntityManager getEntityManager() {
        return jpaConnection.getEntityManager();
    }

    public void create(Datosbasicos datosbasicos) {
        if (datosbasicos.getDatosconsultaHasDatosbasicosList() == null) {
            datosbasicos.setDatosconsultaHasDatosbasicosList(new ArrayList<DatosconsultaHasDatosbasicos>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<DatosconsultaHasDatosbasicos> attachedDatosconsultaHasDatosbasicosList = new ArrayList<DatosconsultaHasDatosbasicos>();
            for (DatosconsultaHasDatosbasicos datosconsultaHasDatosbasicosListDatosconsultaHasDatosbasicosToAttach : datosbasicos.getDatosconsultaHasDatosbasicosList()) {
                datosconsultaHasDatosbasicosListDatosconsultaHasDatosbasicosToAttach = em.getReference(datosconsultaHasDatosbasicosListDatosconsultaHasDatosbasicosToAttach.getClass(), datosconsultaHasDatosbasicosListDatosconsultaHasDatosbasicosToAttach.getIdConsultadatosBasicos());
                attachedDatosconsultaHasDatosbasicosList.add(datosconsultaHasDatosbasicosListDatosconsultaHasDatosbasicosToAttach);
            }
            datosbasicos.setDatosconsultaHasDatosbasicosList(attachedDatosconsultaHasDatosbasicosList);
            em.persist(datosbasicos);
            for (DatosconsultaHasDatosbasicos datosconsultaHasDatosbasicosListDatosconsultaHasDatosbasicos : datosbasicos.getDatosconsultaHasDatosbasicosList()) {
                Datosbasicos oldDatosBasicosiddatosBasicosOfDatosconsultaHasDatosbasicosListDatosconsultaHasDatosbasicos = datosconsultaHasDatosbasicosListDatosconsultaHasDatosbasicos.getDatosBasicosiddatosBasicos();
                datosconsultaHasDatosbasicosListDatosconsultaHasDatosbasicos.setDatosBasicosiddatosBasicos(datosbasicos);
                datosconsultaHasDatosbasicosListDatosconsultaHasDatosbasicos = em.merge(datosconsultaHasDatosbasicosListDatosconsultaHasDatosbasicos);
                if (oldDatosBasicosiddatosBasicosOfDatosconsultaHasDatosbasicosListDatosconsultaHasDatosbasicos != null) {
                    oldDatosBasicosiddatosBasicosOfDatosconsultaHasDatosbasicosListDatosconsultaHasDatosbasicos.getDatosconsultaHasDatosbasicosList().remove(datosconsultaHasDatosbasicosListDatosconsultaHasDatosbasicos);
                    oldDatosBasicosiddatosBasicosOfDatosconsultaHasDatosbasicosListDatosconsultaHasDatosbasicos = em.merge(oldDatosBasicosiddatosBasicosOfDatosconsultaHasDatosbasicosListDatosconsultaHasDatosbasicos);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Datosbasicos datosbasicos) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Datosbasicos persistentDatosbasicos = em.find(Datosbasicos.class, datosbasicos.getIddatosBasicos());
            List<DatosconsultaHasDatosbasicos> datosconsultaHasDatosbasicosListOld = persistentDatosbasicos.getDatosconsultaHasDatosbasicosList();
            List<DatosconsultaHasDatosbasicos> datosconsultaHasDatosbasicosListNew = datosbasicos.getDatosconsultaHasDatosbasicosList();
            List<String> illegalOrphanMessages = null;
            for (DatosconsultaHasDatosbasicos datosconsultaHasDatosbasicosListOldDatosconsultaHasDatosbasicos : datosconsultaHasDatosbasicosListOld) {
                if (!datosconsultaHasDatosbasicosListNew.contains(datosconsultaHasDatosbasicosListOldDatosconsultaHasDatosbasicos)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain DatosconsultaHasDatosbasicos " + datosconsultaHasDatosbasicosListOldDatosconsultaHasDatosbasicos + " since its datosBasicosiddatosBasicos field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<DatosconsultaHasDatosbasicos> attachedDatosconsultaHasDatosbasicosListNew = new ArrayList<DatosconsultaHasDatosbasicos>();
            for (DatosconsultaHasDatosbasicos datosconsultaHasDatosbasicosListNewDatosconsultaHasDatosbasicosToAttach : datosconsultaHasDatosbasicosListNew) {
                datosconsultaHasDatosbasicosListNewDatosconsultaHasDatosbasicosToAttach = em.getReference(datosconsultaHasDatosbasicosListNewDatosconsultaHasDatosbasicosToAttach.getClass(), datosconsultaHasDatosbasicosListNewDatosconsultaHasDatosbasicosToAttach.getIdConsultadatosBasicos());
                attachedDatosconsultaHasDatosbasicosListNew.add(datosconsultaHasDatosbasicosListNewDatosconsultaHasDatosbasicosToAttach);
            }
            datosconsultaHasDatosbasicosListNew = attachedDatosconsultaHasDatosbasicosListNew;
            datosbasicos.setDatosconsultaHasDatosbasicosList(datosconsultaHasDatosbasicosListNew);
            datosbasicos = em.merge(datosbasicos);
            for (DatosconsultaHasDatosbasicos datosconsultaHasDatosbasicosListNewDatosconsultaHasDatosbasicos : datosconsultaHasDatosbasicosListNew) {
                if (!datosconsultaHasDatosbasicosListOld.contains(datosconsultaHasDatosbasicosListNewDatosconsultaHasDatosbasicos)) {
                    Datosbasicos oldDatosBasicosiddatosBasicosOfDatosconsultaHasDatosbasicosListNewDatosconsultaHasDatosbasicos = datosconsultaHasDatosbasicosListNewDatosconsultaHasDatosbasicos.getDatosBasicosiddatosBasicos();
                    datosconsultaHasDatosbasicosListNewDatosconsultaHasDatosbasicos.setDatosBasicosiddatosBasicos(datosbasicos);
                    datosconsultaHasDatosbasicosListNewDatosconsultaHasDatosbasicos = em.merge(datosconsultaHasDatosbasicosListNewDatosconsultaHasDatosbasicos);
                    if (oldDatosBasicosiddatosBasicosOfDatosconsultaHasDatosbasicosListNewDatosconsultaHasDatosbasicos != null && !oldDatosBasicosiddatosBasicosOfDatosconsultaHasDatosbasicosListNewDatosconsultaHasDatosbasicos.equals(datosbasicos)) {
                        oldDatosBasicosiddatosBasicosOfDatosconsultaHasDatosbasicosListNewDatosconsultaHasDatosbasicos.getDatosconsultaHasDatosbasicosList().remove(datosconsultaHasDatosbasicosListNewDatosconsultaHasDatosbasicos);
                        oldDatosBasicosiddatosBasicosOfDatosconsultaHasDatosbasicosListNewDatosconsultaHasDatosbasicos = em.merge(oldDatosBasicosiddatosBasicosOfDatosconsultaHasDatosbasicosListNewDatosconsultaHasDatosbasicos);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = datosbasicos.getIddatosBasicos();
                if (findDatosbasicos(id) == null) {
                    throw new NonexistentEntityException("The datosbasicos with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws IllegalOrphanException, NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Datosbasicos datosbasicos;
            try {
                datosbasicos = em.getReference(Datosbasicos.class, id);
                datosbasicos.getIddatosBasicos();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The datosbasicos with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<DatosconsultaHasDatosbasicos> datosconsultaHasDatosbasicosListOrphanCheck = datosbasicos.getDatosconsultaHasDatosbasicosList();
            for (DatosconsultaHasDatosbasicos datosconsultaHasDatosbasicosListOrphanCheckDatosconsultaHasDatosbasicos : datosconsultaHasDatosbasicosListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Datosbasicos (" + datosbasicos + ") cannot be destroyed since the DatosconsultaHasDatosbasicos " + datosconsultaHasDatosbasicosListOrphanCheckDatosconsultaHasDatosbasicos + " in its datosconsultaHasDatosbasicosList field has a non-nullable datosBasicosiddatosBasicos field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            em.remove(datosbasicos);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Datosbasicos> findDatosbasicosEntities() {
        return findDatosbasicosEntities(true, -1, -1);
    }

    public List<Datosbasicos> findDatosbasicosEntities(int maxResults, int firstResult) {
        return findDatosbasicosEntities(false, maxResults, firstResult);
    }

    private List<Datosbasicos> findDatosbasicosEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Datosbasicos.class));
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

    public Datosbasicos findDatosbasicos(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Datosbasicos.class, id);
        } finally {
            em.close();
        }
    }

    public int getDatosbasicosCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Datosbasicos> rt = cq.from(Datosbasicos.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

}
