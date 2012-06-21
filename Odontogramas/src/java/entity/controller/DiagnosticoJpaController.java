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
import java.util.ArrayList;
import java.util.List;
import entity.Evolucion;
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
        if (diagnostico.getPacienteList() == null) {
            diagnostico.setPacienteList(new ArrayList<Paciente>());
        }
        if (diagnostico.getEvolucionList() == null) {
            diagnostico.setEvolucionList(new ArrayList<Evolucion>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Paciente> attachedPacienteList = new ArrayList<Paciente>();
            for (Paciente pacienteListPacienteToAttach : diagnostico.getPacienteList()) {
                pacienteListPacienteToAttach = em.getReference(pacienteListPacienteToAttach.getClass(), pacienteListPacienteToAttach.getIdpersona());
                attachedPacienteList.add(pacienteListPacienteToAttach);
            }
            diagnostico.setPacienteList(attachedPacienteList);
            List<Evolucion> attachedEvolucionList = new ArrayList<Evolucion>();
            for (Evolucion evolucionListEvolucionToAttach : diagnostico.getEvolucionList()) {
                evolucionListEvolucionToAttach = em.getReference(evolucionListEvolucionToAttach.getClass(), evolucionListEvolucionToAttach.getIdevolucion());
                attachedEvolucionList.add(evolucionListEvolucionToAttach);
            }
            diagnostico.setEvolucionList(attachedEvolucionList);
            em.persist(diagnostico);
            for (Paciente pacienteListPaciente : diagnostico.getPacienteList()) {
                pacienteListPaciente.getDiagnosticoList().add(diagnostico);
                pacienteListPaciente = em.merge(pacienteListPaciente);
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
            List<Paciente> pacienteListOld = persistentDiagnostico.getPacienteList();
            List<Paciente> pacienteListNew = diagnostico.getPacienteList();
            List<Evolucion> evolucionListOld = persistentDiagnostico.getEvolucionList();
            List<Evolucion> evolucionListNew = diagnostico.getEvolucionList();
            List<String> illegalOrphanMessages = null;
            for (Evolucion evolucionListOldEvolucion : evolucionListOld) {
                if (!evolucionListNew.contains(evolucionListOldEvolucion)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Evolucion " + evolucionListOldEvolucion + " since its diagnosticoIddiagnostico field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<Paciente> attachedPacienteListNew = new ArrayList<Paciente>();
            for (Paciente pacienteListNewPacienteToAttach : pacienteListNew) {
                pacienteListNewPacienteToAttach = em.getReference(pacienteListNewPacienteToAttach.getClass(), pacienteListNewPacienteToAttach.getIdpersona());
                attachedPacienteListNew.add(pacienteListNewPacienteToAttach);
            }
            pacienteListNew = attachedPacienteListNew;
            diagnostico.setPacienteList(pacienteListNew);
            List<Evolucion> attachedEvolucionListNew = new ArrayList<Evolucion>();
            for (Evolucion evolucionListNewEvolucionToAttach : evolucionListNew) {
                evolucionListNewEvolucionToAttach = em.getReference(evolucionListNewEvolucionToAttach.getClass(), evolucionListNewEvolucionToAttach.getIdevolucion());
                attachedEvolucionListNew.add(evolucionListNewEvolucionToAttach);
            }
            evolucionListNew = attachedEvolucionListNew;
            diagnostico.setEvolucionList(evolucionListNew);
            diagnostico = em.merge(diagnostico);
            for (Paciente pacienteListOldPaciente : pacienteListOld) {
                if (!pacienteListNew.contains(pacienteListOldPaciente)) {
                    pacienteListOldPaciente.getDiagnosticoList().remove(diagnostico);
                    pacienteListOldPaciente = em.merge(pacienteListOldPaciente);
                }
            }
            for (Paciente pacienteListNewPaciente : pacienteListNew) {
                if (!pacienteListOld.contains(pacienteListNewPaciente)) {
                    pacienteListNewPaciente.getDiagnosticoList().add(diagnostico);
                    pacienteListNewPaciente = em.merge(pacienteListNewPaciente);
                }
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
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<Paciente> pacienteList = diagnostico.getPacienteList();
            for (Paciente pacienteListPaciente : pacienteList) {
                pacienteListPaciente.getDiagnosticoList().remove(diagnostico);
                pacienteListPaciente = em.merge(pacienteListPaciente);
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
