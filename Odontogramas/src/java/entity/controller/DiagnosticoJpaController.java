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
import java.util.List;
import entity.Tratamiento;
import entity.controller.exceptions.IllegalOrphanException;
import entity.controller.exceptions.NonexistentEntityException;
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
        if (diagnostico.getEvolucionList() == null) {
            diagnostico.setEvolucionList(new ArrayList<Evolucion>());
        }
        if (diagnostico.getTratamientoList() == null) {
            diagnostico.setTratamientoList(new ArrayList<Tratamiento>());
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
            List<Evolucion> attachedEvolucionList = new ArrayList<Evolucion>();
            for (Evolucion evolucionListEvolucionToAttach : diagnostico.getEvolucionList()) {
                evolucionListEvolucionToAttach = em.getReference(evolucionListEvolucionToAttach.getClass(), evolucionListEvolucionToAttach.getIdevolucion());
                attachedEvolucionList.add(evolucionListEvolucionToAttach);
            }
            diagnostico.setEvolucionList(attachedEvolucionList);
            List<Tratamiento> attachedTratamientoList = new ArrayList<Tratamiento>();
            for (Tratamiento tratamientoListTratamientoToAttach : diagnostico.getTratamientoList()) {
                tratamientoListTratamientoToAttach = em.getReference(tratamientoListTratamientoToAttach.getClass(), tratamientoListTratamientoToAttach.getIdtratamiento());
                attachedTratamientoList.add(tratamientoListTratamientoToAttach);
            }
            diagnostico.setTratamientoList(attachedTratamientoList);
            em.persist(diagnostico);
            if (pacienteIdpersona != null) {
                pacienteIdpersona.getDiagnosticoList().add(diagnostico);
                pacienteIdpersona = em.merge(pacienteIdpersona);
            }
            for (Evolucion evolucionListEvolucion : diagnostico.getEvolucionList()) {
                Diagnostico oldDiagnosticoIddiagnosticoOfEvolucionListEvolucion = evolucionListEvolucion.getDiagnosticoIddiagnostico();
                evolucionListEvolucion.setDiagnosticoIddiagnostico(diagnostico);
                evolucionListEvolucion = em.merge(evolucionListEvolucion);
                if (oldDiagnosticoIddiagnosticoOfEvolucionListEvolucion != null) {
                    oldDiagnosticoIddiagnosticoOfEvolucionListEvolucion.getEvolucionList().remove(evolucionListEvolucion);
                    oldDiagnosticoIddiagnosticoOfEvolucionListEvolucion = em.merge(oldDiagnosticoIddiagnosticoOfEvolucionListEvolucion);
                }
            }
            for (Tratamiento tratamientoListTratamiento : diagnostico.getTratamientoList()) {
                Diagnostico oldDiagnosticoIddiagnosticoOfTratamientoListTratamiento = tratamientoListTratamiento.getDiagnosticoIddiagnostico();
                tratamientoListTratamiento.setDiagnosticoIddiagnostico(diagnostico);
                tratamientoListTratamiento = em.merge(tratamientoListTratamiento);
                if (oldDiagnosticoIddiagnosticoOfTratamientoListTratamiento != null) {
                    oldDiagnosticoIddiagnosticoOfTratamientoListTratamiento.getTratamientoList().remove(tratamientoListTratamiento);
                    oldDiagnosticoIddiagnosticoOfTratamientoListTratamiento = em.merge(oldDiagnosticoIddiagnosticoOfTratamientoListTratamiento);
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
            List<Evolucion> evolucionListOld = persistentDiagnostico.getEvolucionList();
            List<Evolucion> evolucionListNew = diagnostico.getEvolucionList();
            List<Tratamiento> tratamientoListOld = persistentDiagnostico.getTratamientoList();
            List<Tratamiento> tratamientoListNew = diagnostico.getTratamientoList();
            List<String> illegalOrphanMessages = null;
            for (Evolucion evolucionListOldEvolucion : evolucionListOld) {
                if (!evolucionListNew.contains(evolucionListOldEvolucion)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Evolucion " + evolucionListOldEvolucion + " since its diagnosticoIddiagnostico field is not nullable.");
                }
            }
            for (Tratamiento tratamientoListOldTratamiento : tratamientoListOld) {
                if (!tratamientoListNew.contains(tratamientoListOldTratamiento)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Tratamiento " + tratamientoListOldTratamiento + " since its diagnosticoIddiagnostico field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            if (pacienteIdpersonaNew != null) {
                pacienteIdpersonaNew = em.getReference(pacienteIdpersonaNew.getClass(), pacienteIdpersonaNew.getIdpersona());
                diagnostico.setPacienteIdpersona(pacienteIdpersonaNew);
            }
            List<Evolucion> attachedEvolucionListNew = new ArrayList<Evolucion>();
            for (Evolucion evolucionListNewEvolucionToAttach : evolucionListNew) {
                evolucionListNewEvolucionToAttach = em.getReference(evolucionListNewEvolucionToAttach.getClass(), evolucionListNewEvolucionToAttach.getIdevolucion());
                attachedEvolucionListNew.add(evolucionListNewEvolucionToAttach);
            }
            evolucionListNew = attachedEvolucionListNew;
            diagnostico.setEvolucionList(evolucionListNew);
            List<Tratamiento> attachedTratamientoListNew = new ArrayList<Tratamiento>();
            for (Tratamiento tratamientoListNewTratamientoToAttach : tratamientoListNew) {
                tratamientoListNewTratamientoToAttach = em.getReference(tratamientoListNewTratamientoToAttach.getClass(), tratamientoListNewTratamientoToAttach.getIdtratamiento());
                attachedTratamientoListNew.add(tratamientoListNewTratamientoToAttach);
            }
            tratamientoListNew = attachedTratamientoListNew;
            diagnostico.setTratamientoList(tratamientoListNew);
            diagnostico = em.merge(diagnostico);
            if (pacienteIdpersonaOld != null && !pacienteIdpersonaOld.equals(pacienteIdpersonaNew)) {
                pacienteIdpersonaOld.getDiagnosticoList().remove(diagnostico);
                pacienteIdpersonaOld = em.merge(pacienteIdpersonaOld);
            }
            if (pacienteIdpersonaNew != null && !pacienteIdpersonaNew.equals(pacienteIdpersonaOld)) {
                pacienteIdpersonaNew.getDiagnosticoList().add(diagnostico);
                pacienteIdpersonaNew = em.merge(pacienteIdpersonaNew);
            }
            for (Evolucion evolucionListNewEvolucion : evolucionListNew) {
                if (!evolucionListOld.contains(evolucionListNewEvolucion)) {
                    Diagnostico oldDiagnosticoIddiagnosticoOfEvolucionListNewEvolucion = evolucionListNewEvolucion.getDiagnosticoIddiagnostico();
                    evolucionListNewEvolucion.setDiagnosticoIddiagnostico(diagnostico);
                    evolucionListNewEvolucion = em.merge(evolucionListNewEvolucion);
                    if (oldDiagnosticoIddiagnosticoOfEvolucionListNewEvolucion != null && !oldDiagnosticoIddiagnosticoOfEvolucionListNewEvolucion.equals(diagnostico)) {
                        oldDiagnosticoIddiagnosticoOfEvolucionListNewEvolucion.getEvolucionList().remove(evolucionListNewEvolucion);
                        oldDiagnosticoIddiagnosticoOfEvolucionListNewEvolucion = em.merge(oldDiagnosticoIddiagnosticoOfEvolucionListNewEvolucion);
                    }
                }
            }
            for (Tratamiento tratamientoListNewTratamiento : tratamientoListNew) {
                if (!tratamientoListOld.contains(tratamientoListNewTratamiento)) {
                    Diagnostico oldDiagnosticoIddiagnosticoOfTratamientoListNewTratamiento = tratamientoListNewTratamiento.getDiagnosticoIddiagnostico();
                    tratamientoListNewTratamiento.setDiagnosticoIddiagnostico(diagnostico);
                    tratamientoListNewTratamiento = em.merge(tratamientoListNewTratamiento);
                    if (oldDiagnosticoIddiagnosticoOfTratamientoListNewTratamiento != null && !oldDiagnosticoIddiagnosticoOfTratamientoListNewTratamiento.equals(diagnostico)) {
                        oldDiagnosticoIddiagnosticoOfTratamientoListNewTratamiento.getTratamientoList().remove(tratamientoListNewTratamiento);
                        oldDiagnosticoIddiagnosticoOfTratamientoListNewTratamiento = em.merge(oldDiagnosticoIddiagnosticoOfTratamientoListNewTratamiento);
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
            List<Evolucion> evolucionListOrphanCheck = diagnostico.getEvolucionList();
            for (Evolucion evolucionListOrphanCheckEvolucion : evolucionListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Diagnostico (" + diagnostico + ") cannot be destroyed since the Evolucion " + evolucionListOrphanCheckEvolucion + " in its evolucionList field has a non-nullable diagnosticoIddiagnostico field.");
            }
            List<Tratamiento> tratamientoListOrphanCheck = diagnostico.getTratamientoList();
            for (Tratamiento tratamientoListOrphanCheckTratamiento : tratamientoListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Diagnostico (" + diagnostico + ") cannot be destroyed since the Tratamiento " + tratamientoListOrphanCheckTratamiento + " in its tratamientoList field has a non-nullable diagnosticoIddiagnostico field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Paciente pacienteIdpersona = diagnostico.getPacienteIdpersona();
            if (pacienteIdpersona != null) {
                pacienteIdpersona.getDiagnosticoList().remove(diagnostico);
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
