/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity.controller;

import entity.Diagnostico;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import entity.Paciente;
import entity.Evolucion;
import java.util.ArrayList;
import java.util.Collection;
import entity.Tratamiento;
import entity.controller.exceptions.IllegalOrphanException;
import entity.controller.exceptions.NonexistentEntityException;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;


public class DiagnosticoJpaController implements Serializable {

    public DiagnosticoJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Diagnostico diagnostico) {
        if (diagnostico.getEvolucionCollection() == null) {
            diagnostico.setEvolucionCollection(new ArrayList<Evolucion>());
        }
        if (diagnostico.getTratamientoCollection() == null) {
            diagnostico.setTratamientoCollection(new ArrayList<Tratamiento>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Paciente pacienteIdpersona = diagnostico.getPacienteIdpersona();
            if (pacienteIdpersona != null) {
                pacienteIdpersona = em.getReference(pacienteIdpersona.getClass(), pacienteIdpersona.getIdpersona());
                diagnostico.setPacienteIdpersona(pacienteIdpersona);
            }
            Collection<Evolucion> attachedEvolucionCollection = new ArrayList<Evolucion>();
            for (Evolucion evolucionCollectionEvolucionToAttach : diagnostico.getEvolucionCollection()) {
                evolucionCollectionEvolucionToAttach = em.getReference(evolucionCollectionEvolucionToAttach.getClass(), evolucionCollectionEvolucionToAttach.getIdevolucion());
                attachedEvolucionCollection.add(evolucionCollectionEvolucionToAttach);
            }
            diagnostico.setEvolucionCollection(attachedEvolucionCollection);
            Collection<Tratamiento> attachedTratamientoCollection = new ArrayList<Tratamiento>();
            for (Tratamiento tratamientoCollectionTratamientoToAttach : diagnostico.getTratamientoCollection()) {
                tratamientoCollectionTratamientoToAttach = em.getReference(tratamientoCollectionTratamientoToAttach.getClass(), tratamientoCollectionTratamientoToAttach.getIdtratamiento());
                attachedTratamientoCollection.add(tratamientoCollectionTratamientoToAttach);
            }
            diagnostico.setTratamientoCollection(attachedTratamientoCollection);
            em.persist(diagnostico);
            if (pacienteIdpersona != null) {
                pacienteIdpersona.getDiagnosticoCollection().add(diagnostico);
                pacienteIdpersona = em.merge(pacienteIdpersona);
            }
            for (Evolucion evolucionCollectionEvolucion : diagnostico.getEvolucionCollection()) {
                Diagnostico oldDiagnosticoIddiagnosticoOfEvolucionCollectionEvolucion = evolucionCollectionEvolucion.getDiagnosticoIddiagnostico();
                evolucionCollectionEvolucion.setDiagnosticoIddiagnostico(diagnostico);
                evolucionCollectionEvolucion = em.merge(evolucionCollectionEvolucion);
                if (oldDiagnosticoIddiagnosticoOfEvolucionCollectionEvolucion != null) {
                    oldDiagnosticoIddiagnosticoOfEvolucionCollectionEvolucion.getEvolucionCollection().remove(evolucionCollectionEvolucion);
                    oldDiagnosticoIddiagnosticoOfEvolucionCollectionEvolucion = em.merge(oldDiagnosticoIddiagnosticoOfEvolucionCollectionEvolucion);
                }
            }
            for (Tratamiento tratamientoCollectionTratamiento : diagnostico.getTratamientoCollection()) {
                Diagnostico oldDiagnosticoIddiagnosticoOfTratamientoCollectionTratamiento = tratamientoCollectionTratamiento.getDiagnosticoIddiagnostico();
                tratamientoCollectionTratamiento.setDiagnosticoIddiagnostico(diagnostico);
                tratamientoCollectionTratamiento = em.merge(tratamientoCollectionTratamiento);
                if (oldDiagnosticoIddiagnosticoOfTratamientoCollectionTratamiento != null) {
                    oldDiagnosticoIddiagnosticoOfTratamientoCollectionTratamiento.getTratamientoCollection().remove(tratamientoCollectionTratamiento);
                    oldDiagnosticoIddiagnosticoOfTratamientoCollectionTratamiento = em.merge(oldDiagnosticoIddiagnosticoOfTratamientoCollectionTratamiento);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Diagnostico diagnostico) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Diagnostico persistentDiagnostico = em.find(Diagnostico.class, diagnostico.getIddiagnostico());
            Paciente pacienteIdpersonaOld = persistentDiagnostico.getPacienteIdpersona();
            Paciente pacienteIdpersonaNew = diagnostico.getPacienteIdpersona();
            Collection<Evolucion> evolucionCollectionOld = persistentDiagnostico.getEvolucionCollection();
            Collection<Evolucion> evolucionCollectionNew = diagnostico.getEvolucionCollection();
            Collection<Tratamiento> tratamientoCollectionOld = persistentDiagnostico.getTratamientoCollection();
            Collection<Tratamiento> tratamientoCollectionNew = diagnostico.getTratamientoCollection();
            List<String> illegalOrphanMessages = null;
            for (Evolucion evolucionCollectionOldEvolucion : evolucionCollectionOld) {
                if (!evolucionCollectionNew.contains(evolucionCollectionOldEvolucion)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Evolucion " + evolucionCollectionOldEvolucion + " since its diagnosticoIddiagnostico field is not nullable.");
                }
            }
            for (Tratamiento tratamientoCollectionOldTratamiento : tratamientoCollectionOld) {
                if (!tratamientoCollectionNew.contains(tratamientoCollectionOldTratamiento)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Tratamiento " + tratamientoCollectionOldTratamiento + " since its diagnosticoIddiagnostico field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            if (pacienteIdpersonaNew != null) {
                pacienteIdpersonaNew = em.getReference(pacienteIdpersonaNew.getClass(), pacienteIdpersonaNew.getIdpersona());
                diagnostico.setPacienteIdpersona(pacienteIdpersonaNew);
            }
            Collection<Evolucion> attachedEvolucionCollectionNew = new ArrayList<Evolucion>();
            for (Evolucion evolucionCollectionNewEvolucionToAttach : evolucionCollectionNew) {
                evolucionCollectionNewEvolucionToAttach = em.getReference(evolucionCollectionNewEvolucionToAttach.getClass(), evolucionCollectionNewEvolucionToAttach.getIdevolucion());
                attachedEvolucionCollectionNew.add(evolucionCollectionNewEvolucionToAttach);
            }
            evolucionCollectionNew = attachedEvolucionCollectionNew;
            diagnostico.setEvolucionCollection(evolucionCollectionNew);
            Collection<Tratamiento> attachedTratamientoCollectionNew = new ArrayList<Tratamiento>();
            for (Tratamiento tratamientoCollectionNewTratamientoToAttach : tratamientoCollectionNew) {
                tratamientoCollectionNewTratamientoToAttach = em.getReference(tratamientoCollectionNewTratamientoToAttach.getClass(), tratamientoCollectionNewTratamientoToAttach.getIdtratamiento());
                attachedTratamientoCollectionNew.add(tratamientoCollectionNewTratamientoToAttach);
            }
            tratamientoCollectionNew = attachedTratamientoCollectionNew;
            diagnostico.setTratamientoCollection(tratamientoCollectionNew);
            diagnostico = em.merge(diagnostico);
            if (pacienteIdpersonaOld != null && !pacienteIdpersonaOld.equals(pacienteIdpersonaNew)) {
                pacienteIdpersonaOld.getDiagnosticoCollection().remove(diagnostico);
                pacienteIdpersonaOld = em.merge(pacienteIdpersonaOld);
            }
            if (pacienteIdpersonaNew != null && !pacienteIdpersonaNew.equals(pacienteIdpersonaOld)) {
                pacienteIdpersonaNew.getDiagnosticoCollection().add(diagnostico);
                pacienteIdpersonaNew = em.merge(pacienteIdpersonaNew);
            }
            for (Evolucion evolucionCollectionNewEvolucion : evolucionCollectionNew) {
                if (!evolucionCollectionOld.contains(evolucionCollectionNewEvolucion)) {
                    Diagnostico oldDiagnosticoIddiagnosticoOfEvolucionCollectionNewEvolucion = evolucionCollectionNewEvolucion.getDiagnosticoIddiagnostico();
                    evolucionCollectionNewEvolucion.setDiagnosticoIddiagnostico(diagnostico);
                    evolucionCollectionNewEvolucion = em.merge(evolucionCollectionNewEvolucion);
                    if (oldDiagnosticoIddiagnosticoOfEvolucionCollectionNewEvolucion != null && !oldDiagnosticoIddiagnosticoOfEvolucionCollectionNewEvolucion.equals(diagnostico)) {
                        oldDiagnosticoIddiagnosticoOfEvolucionCollectionNewEvolucion.getEvolucionCollection().remove(evolucionCollectionNewEvolucion);
                        oldDiagnosticoIddiagnosticoOfEvolucionCollectionNewEvolucion = em.merge(oldDiagnosticoIddiagnosticoOfEvolucionCollectionNewEvolucion);
                    }
                }
            }
            for (Tratamiento tratamientoCollectionNewTratamiento : tratamientoCollectionNew) {
                if (!tratamientoCollectionOld.contains(tratamientoCollectionNewTratamiento)) {
                    Diagnostico oldDiagnosticoIddiagnosticoOfTratamientoCollectionNewTratamiento = tratamientoCollectionNewTratamiento.getDiagnosticoIddiagnostico();
                    tratamientoCollectionNewTratamiento.setDiagnosticoIddiagnostico(diagnostico);
                    tratamientoCollectionNewTratamiento = em.merge(tratamientoCollectionNewTratamiento);
                    if (oldDiagnosticoIddiagnosticoOfTratamientoCollectionNewTratamiento != null && !oldDiagnosticoIddiagnosticoOfTratamientoCollectionNewTratamiento.equals(diagnostico)) {
                        oldDiagnosticoIddiagnosticoOfTratamientoCollectionNewTratamiento.getTratamientoCollection().remove(tratamientoCollectionNewTratamiento);
                        oldDiagnosticoIddiagnosticoOfTratamientoCollectionNewTratamiento = em.merge(oldDiagnosticoIddiagnosticoOfTratamientoCollectionNewTratamiento);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = diagnostico.getIddiagnostico();
                if (findDiagnostico(id) == null) {
                    throw new NonexistentEntityException("The diagnostico with id " + id + " no longer exists.");
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
            Diagnostico diagnostico;
            try {
                diagnostico = em.getReference(Diagnostico.class, id);
                diagnostico.getIddiagnostico();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The diagnostico with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            Collection<Evolucion> evolucionCollectionOrphanCheck = diagnostico.getEvolucionCollection();
            for (Evolucion evolucionCollectionOrphanCheckEvolucion : evolucionCollectionOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Diagnostico (" + diagnostico + ") cannot be destroyed since the Evolucion " + evolucionCollectionOrphanCheckEvolucion + " in its evolucionCollection field has a non-nullable diagnosticoIddiagnostico field.");
            }
            Collection<Tratamiento> tratamientoCollectionOrphanCheck = diagnostico.getTratamientoCollection();
            for (Tratamiento tratamientoCollectionOrphanCheckTratamiento : tratamientoCollectionOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Diagnostico (" + diagnostico + ") cannot be destroyed since the Tratamiento " + tratamientoCollectionOrphanCheckTratamiento + " in its tratamientoCollection field has a non-nullable diagnosticoIddiagnostico field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Paciente pacienteIdpersona = diagnostico.getPacienteIdpersona();
            if (pacienteIdpersona != null) {
                pacienteIdpersona.getDiagnosticoCollection().remove(diagnostico);
                pacienteIdpersona = em.merge(pacienteIdpersona);
            }
            em.remove(diagnostico);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Diagnostico> findDiagnosticoEntities() {
        return findDiagnosticoEntities(true, -1, -1);
    }

    public List<Diagnostico> findDiagnosticoEntities(int maxResults, int firstResult) {
        return findDiagnosticoEntities(false, maxResults, firstResult);
    }

    private List<Diagnostico> findDiagnosticoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Diagnostico.class));
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

    public Diagnostico findDiagnostico(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Diagnostico.class, id);
        } finally {
            em.close();
        }
    }

    public int getDiagnosticoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Diagnostico> rt = cq.from(Diagnostico.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

}
