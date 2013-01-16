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
import java.util.ArrayList;
import java.util.List;
import entity.Evolucion;
import entity.Tratamiento;
import entity.controller.exceptions.IllegalOrphanException;
import entity.controller.exceptions.NonexistentEntityException;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

/**
 *
 * @author jubarcos
 */
public class TratamientoJpaController implements Serializable {

    public TratamientoJpaController() {

    }
    public EntityManager getEntityManager() {
        return jpaConnection.getEntityManager();
    }

    public void create(Tratamiento tratamiento) {
        if (tratamiento.getConsultaList() == null) {
            tratamiento.setConsultaList(new ArrayList<Consulta>());
        }
        if (tratamiento.getEvolucionList() == null) {
            tratamiento.setEvolucionList(new ArrayList<Evolucion>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Consulta> attachedConsultaList = new ArrayList<Consulta>();
            for (Consulta consultaListConsultaToAttach : tratamiento.getConsultaList()) {
                consultaListConsultaToAttach = em.getReference(consultaListConsultaToAttach.getClass(), consultaListConsultaToAttach.getIddatosConsulta());
                attachedConsultaList.add(consultaListConsultaToAttach);
            }
            tratamiento.setConsultaList(attachedConsultaList);
            List<Evolucion> attachedEvolucionList = new ArrayList<Evolucion>();
            for (Evolucion evolucionListEvolucionToAttach : tratamiento.getEvolucionList()) {
                evolucionListEvolucionToAttach = em.getReference(evolucionListEvolucionToAttach.getClass(), evolucionListEvolucionToAttach.getIdevolucion());
                attachedEvolucionList.add(evolucionListEvolucionToAttach);
            }
            tratamiento.setEvolucionList(attachedEvolucionList);
            em.persist(tratamiento);
            for (Consulta consultaListConsulta : tratamiento.getConsultaList()) {
                consultaListConsulta.getTratamientoList().add(tratamiento);
                consultaListConsulta = em.merge(consultaListConsulta);
            }
            for (Evolucion evolucionListEvolucion : tratamiento.getEvolucionList()) {
                Tratamiento oldTratamientoIdtratamientoOfEvolucionListEvolucion = evolucionListEvolucion.getTratamientoIdtratamiento();
                evolucionListEvolucion.setTratamientoIdtratamiento(tratamiento);
                evolucionListEvolucion = em.merge(evolucionListEvolucion);
                if (oldTratamientoIdtratamientoOfEvolucionListEvolucion != null) {
                    oldTratamientoIdtratamientoOfEvolucionListEvolucion.getEvolucionList().remove(evolucionListEvolucion);
                    oldTratamientoIdtratamientoOfEvolucionListEvolucion = em.merge(oldTratamientoIdtratamientoOfEvolucionListEvolucion);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Tratamiento tratamiento) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Tratamiento persistentTratamiento = em.find(Tratamiento.class, tratamiento.getIdtratamiento());
            List<Consulta> consultaListOld = persistentTratamiento.getConsultaList();
            List<Consulta> consultaListNew = tratamiento.getConsultaList();
            List<Evolucion> evolucionListOld = persistentTratamiento.getEvolucionList();
            List<Evolucion> evolucionListNew = tratamiento.getEvolucionList();
            List<String> illegalOrphanMessages = null;
            for (Evolucion evolucionListOldEvolucion : evolucionListOld) {
                if (!evolucionListNew.contains(evolucionListOldEvolucion)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Evolucion " + evolucionListOldEvolucion + " since its tratamientoIdtratamiento field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<Consulta> attachedConsultaListNew = new ArrayList<Consulta>();
            for (Consulta consultaListNewConsultaToAttach : consultaListNew) {
                consultaListNewConsultaToAttach = em.getReference(consultaListNewConsultaToAttach.getClass(), consultaListNewConsultaToAttach.getIddatosConsulta());
                attachedConsultaListNew.add(consultaListNewConsultaToAttach);
            }
            consultaListNew = attachedConsultaListNew;
            tratamiento.setConsultaList(consultaListNew);
            List<Evolucion> attachedEvolucionListNew = new ArrayList<Evolucion>();
            for (Evolucion evolucionListNewEvolucionToAttach : evolucionListNew) {
                evolucionListNewEvolucionToAttach = em.getReference(evolucionListNewEvolucionToAttach.getClass(), evolucionListNewEvolucionToAttach.getIdevolucion());
                attachedEvolucionListNew.add(evolucionListNewEvolucionToAttach);
            }
            evolucionListNew = attachedEvolucionListNew;
            tratamiento.setEvolucionList(evolucionListNew);
            tratamiento = em.merge(tratamiento);
            for (Consulta consultaListOldConsulta : consultaListOld) {
                if (!consultaListNew.contains(consultaListOldConsulta)) {
                    consultaListOldConsulta.getTratamientoList().remove(tratamiento);
                    consultaListOldConsulta = em.merge(consultaListOldConsulta);
                }
            }
            for (Consulta consultaListNewConsulta : consultaListNew) {
                if (!consultaListOld.contains(consultaListNewConsulta)) {
                    consultaListNewConsulta.getTratamientoList().add(tratamiento);
                    consultaListNewConsulta = em.merge(consultaListNewConsulta);
                }
            }
            for (Evolucion evolucionListNewEvolucion : evolucionListNew) {
                if (!evolucionListOld.contains(evolucionListNewEvolucion)) {
                    Tratamiento oldTratamientoIdtratamientoOfEvolucionListNewEvolucion = evolucionListNewEvolucion.getTratamientoIdtratamiento();
                    evolucionListNewEvolucion.setTratamientoIdtratamiento(tratamiento);
                    evolucionListNewEvolucion = em.merge(evolucionListNewEvolucion);
                    if (oldTratamientoIdtratamientoOfEvolucionListNewEvolucion != null && !oldTratamientoIdtratamientoOfEvolucionListNewEvolucion.equals(tratamiento)) {
                        oldTratamientoIdtratamientoOfEvolucionListNewEvolucion.getEvolucionList().remove(evolucionListNewEvolucion);
                        oldTratamientoIdtratamientoOfEvolucionListNewEvolucion = em.merge(oldTratamientoIdtratamientoOfEvolucionListNewEvolucion);
                    }
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

    public void destroy(Integer id) throws IllegalOrphanException, NonexistentEntityException {
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
            List<String> illegalOrphanMessages = null;
            List<Evolucion> evolucionListOrphanCheck = tratamiento.getEvolucionList();
            for (Evolucion evolucionListOrphanCheckEvolucion : evolucionListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Tratamiento (" + tratamiento + ") cannot be destroyed since the Evolucion " + evolucionListOrphanCheckEvolucion + " in its evolucionList field has a non-nullable tratamientoIdtratamiento field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<Consulta> consultaList = tratamiento.getConsultaList();
            for (Consulta consultaListConsulta : consultaList) {
                consultaListConsulta.getTratamientoList().remove(tratamiento);
                consultaListConsulta = em.merge(consultaListConsulta);
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
