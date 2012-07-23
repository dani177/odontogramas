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
import entity.DatosconsultaHasDiente;
import entity.Diente;
import entity.controller.exceptions.IllegalOrphanException;
import entity.controller.exceptions.NonexistentEntityException;
import entity.controller.exceptions.PreexistingEntityException;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;


public class DienteJpaController implements Serializable {

    public DienteJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Diente diente) throws PreexistingEntityException, Exception {
        if (diente.getDatosconsultaHasDienteList() == null) {
            diente.setDatosconsultaHasDienteList(new ArrayList<DatosconsultaHasDiente>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<DatosconsultaHasDiente> attachedDatosconsultaHasDienteList = new ArrayList<DatosconsultaHasDiente>();
            for (DatosconsultaHasDiente datosconsultaHasDienteListDatosconsultaHasDienteToAttach : diente.getDatosconsultaHasDienteList()) {
                datosconsultaHasDienteListDatosconsultaHasDienteToAttach = em.getReference(datosconsultaHasDienteListDatosconsultaHasDienteToAttach.getClass(), datosconsultaHasDienteListDatosconsultaHasDienteToAttach.getDatosconsultaHasDientePK());
                attachedDatosconsultaHasDienteList.add(datosconsultaHasDienteListDatosconsultaHasDienteToAttach);
            }
            diente.setDatosconsultaHasDienteList(attachedDatosconsultaHasDienteList);
            em.persist(diente);
            for (DatosconsultaHasDiente datosconsultaHasDienteListDatosconsultaHasDiente : diente.getDatosconsultaHasDienteList()) {
                Diente oldDienteOfDatosconsultaHasDienteListDatosconsultaHasDiente = datosconsultaHasDienteListDatosconsultaHasDiente.getDiente();
                datosconsultaHasDienteListDatosconsultaHasDiente.setDiente(diente);
                datosconsultaHasDienteListDatosconsultaHasDiente = em.merge(datosconsultaHasDienteListDatosconsultaHasDiente);
                if (oldDienteOfDatosconsultaHasDienteListDatosconsultaHasDiente != null) {
                    oldDienteOfDatosconsultaHasDienteListDatosconsultaHasDiente.getDatosconsultaHasDienteList().remove(datosconsultaHasDienteListDatosconsultaHasDiente);
                    oldDienteOfDatosconsultaHasDienteListDatosconsultaHasDiente = em.merge(oldDienteOfDatosconsultaHasDienteListDatosconsultaHasDiente);
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findDiente(diente.getIddiente()) != null) {
                throw new PreexistingEntityException("Diente " + diente + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Diente diente) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Diente persistentDiente = em.find(Diente.class, diente.getIddiente());
            List<DatosconsultaHasDiente> datosconsultaHasDienteListOld = persistentDiente.getDatosconsultaHasDienteList();
            List<DatosconsultaHasDiente> datosconsultaHasDienteListNew = diente.getDatosconsultaHasDienteList();
            List<String> illegalOrphanMessages = null;
            for (DatosconsultaHasDiente datosconsultaHasDienteListOldDatosconsultaHasDiente : datosconsultaHasDienteListOld) {
                if (!datosconsultaHasDienteListNew.contains(datosconsultaHasDienteListOldDatosconsultaHasDiente)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain DatosconsultaHasDiente " + datosconsultaHasDienteListOldDatosconsultaHasDiente + " since its diente field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<DatosconsultaHasDiente> attachedDatosconsultaHasDienteListNew = new ArrayList<DatosconsultaHasDiente>();
            for (DatosconsultaHasDiente datosconsultaHasDienteListNewDatosconsultaHasDienteToAttach : datosconsultaHasDienteListNew) {
                datosconsultaHasDienteListNewDatosconsultaHasDienteToAttach = em.getReference(datosconsultaHasDienteListNewDatosconsultaHasDienteToAttach.getClass(), datosconsultaHasDienteListNewDatosconsultaHasDienteToAttach.getDatosconsultaHasDientePK());
                attachedDatosconsultaHasDienteListNew.add(datosconsultaHasDienteListNewDatosconsultaHasDienteToAttach);
            }
            datosconsultaHasDienteListNew = attachedDatosconsultaHasDienteListNew;
            diente.setDatosconsultaHasDienteList(datosconsultaHasDienteListNew);
            diente = em.merge(diente);
            for (DatosconsultaHasDiente datosconsultaHasDienteListNewDatosconsultaHasDiente : datosconsultaHasDienteListNew) {
                if (!datosconsultaHasDienteListOld.contains(datosconsultaHasDienteListNewDatosconsultaHasDiente)) {
                    Diente oldDienteOfDatosconsultaHasDienteListNewDatosconsultaHasDiente = datosconsultaHasDienteListNewDatosconsultaHasDiente.getDiente();
                    datosconsultaHasDienteListNewDatosconsultaHasDiente.setDiente(diente);
                    datosconsultaHasDienteListNewDatosconsultaHasDiente = em.merge(datosconsultaHasDienteListNewDatosconsultaHasDiente);
                    if (oldDienteOfDatosconsultaHasDienteListNewDatosconsultaHasDiente != null && !oldDienteOfDatosconsultaHasDienteListNewDatosconsultaHasDiente.equals(diente)) {
                        oldDienteOfDatosconsultaHasDienteListNewDatosconsultaHasDiente.getDatosconsultaHasDienteList().remove(datosconsultaHasDienteListNewDatosconsultaHasDiente);
                        oldDienteOfDatosconsultaHasDienteListNewDatosconsultaHasDiente = em.merge(oldDienteOfDatosconsultaHasDienteListNewDatosconsultaHasDiente);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = diente.getIddiente();
                if (findDiente(id) == null) {
                    throw new NonexistentEntityException("The diente with id " + id + " no longer exists.");
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
            Diente diente;
            try {
                diente = em.getReference(Diente.class, id);
                diente.getIddiente();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The diente with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<DatosconsultaHasDiente> datosconsultaHasDienteListOrphanCheck = diente.getDatosconsultaHasDienteList();
            for (DatosconsultaHasDiente datosconsultaHasDienteListOrphanCheckDatosconsultaHasDiente : datosconsultaHasDienteListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Diente (" + diente + ") cannot be destroyed since the DatosconsultaHasDiente " + datosconsultaHasDienteListOrphanCheckDatosconsultaHasDiente + " in its datosconsultaHasDienteList field has a non-nullable diente field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            em.remove(diente);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Diente> findDienteEntities() {
        return findDienteEntities(true, -1, -1);
    }

    public List<Diente> findDienteEntities(int maxResults, int firstResult) {
        return findDienteEntities(false, maxResults, firstResult);
    }

    private List<Diente> findDienteEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Diente.class));
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

    public Diente findDiente(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Diente.class, id);
        } finally {
            em.close();
        }
    }

    public int getDienteCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Diente> rt = cq.from(Diente.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

}  
