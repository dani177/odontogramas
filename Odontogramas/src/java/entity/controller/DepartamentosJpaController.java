/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity.controller;

import conexion.jpaConnection;
import entity.Departamentos;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import entity.Municipios;
import entity.controller.exceptions.IllegalOrphanException;
import entity.controller.exceptions.NonexistentEntityException;
import entity.controller.exceptions.PreexistingEntityException;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;


public class DepartamentosJpaController implements Serializable {

     public DepartamentosJpaController() {
    }

    public EntityManager getEntityManager() {
        return jpaConnection.getEntityManager();
    }

    public void create(Departamentos departamentos) throws PreexistingEntityException, Exception {
        if (departamentos.getMunicipiosList() == null) {
            departamentos.setMunicipiosList(new ArrayList<Municipios>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Municipios> attachedMunicipiosList = new ArrayList<Municipios>();
            for (Municipios municipiosListMunicipiosToAttach : departamentos.getMunicipiosList()) {
                municipiosListMunicipiosToAttach = em.getReference(municipiosListMunicipiosToAttach.getClass(), municipiosListMunicipiosToAttach.getCodigo());
                attachedMunicipiosList.add(municipiosListMunicipiosToAttach);
            }
            departamentos.setMunicipiosList(attachedMunicipiosList);
            em.persist(departamentos);
            for (Municipios municipiosListMunicipios : departamentos.getMunicipiosList()) {
                Departamentos oldDepartamentosCodigo1OfMunicipiosListMunicipios = municipiosListMunicipios.getDepartamentosCodigo1();
                municipiosListMunicipios.setDepartamentosCodigo1(departamentos);
                municipiosListMunicipios = em.merge(municipiosListMunicipios);
                if (oldDepartamentosCodigo1OfMunicipiosListMunicipios != null) {
                    oldDepartamentosCodigo1OfMunicipiosListMunicipios.getMunicipiosList().remove(municipiosListMunicipios);
                    oldDepartamentosCodigo1OfMunicipiosListMunicipios = em.merge(oldDepartamentosCodigo1OfMunicipiosListMunicipios);
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findDepartamentos(departamentos.getCodigo()) != null) {
                throw new PreexistingEntityException("Departamentos " + departamentos + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Departamentos departamentos) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Departamentos persistentDepartamentos = em.find(Departamentos.class, departamentos.getCodigo());
            List<Municipios> municipiosListOld = persistentDepartamentos.getMunicipiosList();
            List<Municipios> municipiosListNew = departamentos.getMunicipiosList();
            List<String> illegalOrphanMessages = null;
            for (Municipios municipiosListOldMunicipios : municipiosListOld) {
                if (!municipiosListNew.contains(municipiosListOldMunicipios)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Municipios " + municipiosListOldMunicipios + " since its departamentosCodigo1 field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<Municipios> attachedMunicipiosListNew = new ArrayList<Municipios>();
            for (Municipios municipiosListNewMunicipiosToAttach : municipiosListNew) {
                municipiosListNewMunicipiosToAttach = em.getReference(municipiosListNewMunicipiosToAttach.getClass(), municipiosListNewMunicipiosToAttach.getCodigo());
                attachedMunicipiosListNew.add(municipiosListNewMunicipiosToAttach);
            }
            municipiosListNew = attachedMunicipiosListNew;
            departamentos.setMunicipiosList(municipiosListNew);
            departamentos = em.merge(departamentos);
            for (Municipios municipiosListNewMunicipios : municipiosListNew) {
                if (!municipiosListOld.contains(municipiosListNewMunicipios)) {
                    Departamentos oldDepartamentosCodigo1OfMunicipiosListNewMunicipios = municipiosListNewMunicipios.getDepartamentosCodigo1();
                    municipiosListNewMunicipios.setDepartamentosCodigo1(departamentos);
                    municipiosListNewMunicipios = em.merge(municipiosListNewMunicipios);
                    if (oldDepartamentosCodigo1OfMunicipiosListNewMunicipios != null && !oldDepartamentosCodigo1OfMunicipiosListNewMunicipios.equals(departamentos)) {
                        oldDepartamentosCodigo1OfMunicipiosListNewMunicipios.getMunicipiosList().remove(municipiosListNewMunicipios);
                        oldDepartamentosCodigo1OfMunicipiosListNewMunicipios = em.merge(oldDepartamentosCodigo1OfMunicipiosListNewMunicipios);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = departamentos.getCodigo();
                if (findDepartamentos(id) == null) {
                    throw new NonexistentEntityException("The departamentos with id " + id + " no longer exists.");
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
            Departamentos departamentos;
            try {
                departamentos = em.getReference(Departamentos.class, id);
                departamentos.getCodigo();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The departamentos with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<Municipios> municipiosListOrphanCheck = departamentos.getMunicipiosList();
            for (Municipios municipiosListOrphanCheckMunicipios : municipiosListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Departamentos (" + departamentos + ") cannot be destroyed since the Municipios " + municipiosListOrphanCheckMunicipios + " in its municipiosList field has a non-nullable departamentosCodigo1 field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            em.remove(departamentos);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Departamentos> findDepartamentosEntities() {
        return findDepartamentosEntities(true, -1, -1);
    }

    public List<Departamentos> findDepartamentosEntities(int maxResults, int firstResult) {
        return findDepartamentosEntities(false, maxResults, firstResult);
    }

    private List<Departamentos> findDepartamentosEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Departamentos.class));
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

    public Departamentos findDepartamentos(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Departamentos.class, id);
        } finally {
            em.close();
        }
    }

    public int getDepartamentosCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Departamentos> rt = cq.from(Departamentos.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
