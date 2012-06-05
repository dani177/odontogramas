/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity.controller;

import conexion.jpaConnection;
import entity.*;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.Collection;
import entity.controller.exceptions.IllegalOrphanException;
import entity.controller.exceptions.NonexistentEntityException;
import entity.controller.exceptions.PreexistingEntityException;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;


public class PacienteJpaController implements Serializable {

    public PacienteJpaController() {
    }

    public EntityManager getEntityManager() {
        return jpaConnection.getEntityManager();
    }

    public void create(Paciente paciente) throws PreexistingEntityException, Exception {
        if (paciente.getMedicoCollection() == null) {
            paciente.setMedicoCollection(new ArrayList<Medico>());
        }
        if (paciente.getExamenfisicoestomatologicoCollection() == null) {
            paciente.setExamenfisicoestomatologicoCollection(new ArrayList<Examenfisicoestomatologico>());
        }
        if (paciente.getDiagnosticoCollection() == null) {
            paciente.setDiagnosticoCollection(new ArrayList<Diagnostico>());
        }
        if (paciente.getDatosconsultaCollection() == null) {
            paciente.setDatosconsultaCollection(new ArrayList<Datosconsulta>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Collection<Medico> attachedMedicoCollection = new ArrayList<Medico>();
            for (Medico medicoCollectionMedicoToAttach : paciente.getMedicoCollection()) {
                medicoCollectionMedicoToAttach = em.getReference(medicoCollectionMedicoToAttach.getClass(), medicoCollectionMedicoToAttach.getIdmedico());
                attachedMedicoCollection.add(medicoCollectionMedicoToAttach);
            }
            paciente.setMedicoCollection(attachedMedicoCollection);
            Collection<Examenfisicoestomatologico> attachedExamenfisicoestomatologicoCollection = new ArrayList<Examenfisicoestomatologico>();
            for (Examenfisicoestomatologico examenfisicoestomatologicoCollectionExamenfisicoestomatologicoToAttach : paciente.getExamenfisicoestomatologicoCollection()) {
                examenfisicoestomatologicoCollectionExamenfisicoestomatologicoToAttach = em.getReference(examenfisicoestomatologicoCollectionExamenfisicoestomatologicoToAttach.getClass(), examenfisicoestomatologicoCollectionExamenfisicoestomatologicoToAttach.getIdexamenFisicoEstomatologico());
                attachedExamenfisicoestomatologicoCollection.add(examenfisicoestomatologicoCollectionExamenfisicoestomatologicoToAttach);
            }
            paciente.setExamenfisicoestomatologicoCollection(attachedExamenfisicoestomatologicoCollection);
            Collection<Diagnostico> attachedDiagnosticoCollection = new ArrayList<Diagnostico>();
            for (Diagnostico diagnosticoCollectionDiagnosticoToAttach : paciente.getDiagnosticoCollection()) {
                diagnosticoCollectionDiagnosticoToAttach = em.getReference(diagnosticoCollectionDiagnosticoToAttach.getClass(), diagnosticoCollectionDiagnosticoToAttach.getIddiagnostico());
                attachedDiagnosticoCollection.add(diagnosticoCollectionDiagnosticoToAttach);
            }
            paciente.setDiagnosticoCollection(attachedDiagnosticoCollection);
            Collection<Datosconsulta> attachedDatosconsultaCollection = new ArrayList<Datosconsulta>();
            for (Datosconsulta datosconsultaCollectionDatosconsultaToAttach : paciente.getDatosconsultaCollection()) {
                datosconsultaCollectionDatosconsultaToAttach = em.getReference(datosconsultaCollectionDatosconsultaToAttach.getClass(), datosconsultaCollectionDatosconsultaToAttach.getIddatosConsulta());
                attachedDatosconsultaCollection.add(datosconsultaCollectionDatosconsultaToAttach);
            }
            paciente.setDatosconsultaCollection(attachedDatosconsultaCollection);
            em.persist(paciente);
            for (Medico medicoCollectionMedico : paciente.getMedicoCollection()) {
                medicoCollectionMedico.getPacienteCollection().add(paciente);
                medicoCollectionMedico = em.merge(medicoCollectionMedico);
            }
            for (Examenfisicoestomatologico examenfisicoestomatologicoCollectionExamenfisicoestomatologico : paciente.getExamenfisicoestomatologicoCollection()) {
                Paciente oldPacienteidpersonaOfExamenfisicoestomatologicoCollectionExamenfisicoestomatologico = examenfisicoestomatologicoCollectionExamenfisicoestomatologico.getPacienteidpersona();
                examenfisicoestomatologicoCollectionExamenfisicoestomatologico.setPacienteidpersona(paciente);
                examenfisicoestomatologicoCollectionExamenfisicoestomatologico = em.merge(examenfisicoestomatologicoCollectionExamenfisicoestomatologico);
                if (oldPacienteidpersonaOfExamenfisicoestomatologicoCollectionExamenfisicoestomatologico != null) {
                    oldPacienteidpersonaOfExamenfisicoestomatologicoCollectionExamenfisicoestomatologico.getExamenfisicoestomatologicoCollection().remove(examenfisicoestomatologicoCollectionExamenfisicoestomatologico);
                    oldPacienteidpersonaOfExamenfisicoestomatologicoCollectionExamenfisicoestomatologico = em.merge(oldPacienteidpersonaOfExamenfisicoestomatologicoCollectionExamenfisicoestomatologico);
                }
            }
            for (Diagnostico diagnosticoCollectionDiagnostico : paciente.getDiagnosticoCollection()) {
                Paciente oldPacienteIdpersonaOfDiagnosticoCollectionDiagnostico = diagnosticoCollectionDiagnostico.getPacienteIdpersona();
                diagnosticoCollectionDiagnostico.setPacienteIdpersona(paciente);
                diagnosticoCollectionDiagnostico = em.merge(diagnosticoCollectionDiagnostico);
                if (oldPacienteIdpersonaOfDiagnosticoCollectionDiagnostico != null) {
                    oldPacienteIdpersonaOfDiagnosticoCollectionDiagnostico.getDiagnosticoCollection().remove(diagnosticoCollectionDiagnostico);
                    oldPacienteIdpersonaOfDiagnosticoCollectionDiagnostico = em.merge(oldPacienteIdpersonaOfDiagnosticoCollectionDiagnostico);
                }
            }
            for (Datosconsulta datosconsultaCollectionDatosconsulta : paciente.getDatosconsultaCollection()) {
                Paciente oldPacienteIdpersonaOfDatosconsultaCollectionDatosconsulta = datosconsultaCollectionDatosconsulta.getPacienteIdpersona();
                datosconsultaCollectionDatosconsulta.setPacienteIdpersona(paciente);
                datosconsultaCollectionDatosconsulta = em.merge(datosconsultaCollectionDatosconsulta);
                if (oldPacienteIdpersonaOfDatosconsultaCollectionDatosconsulta != null) {
                    oldPacienteIdpersonaOfDatosconsultaCollectionDatosconsulta.getDatosconsultaCollection().remove(datosconsultaCollectionDatosconsulta);
                    oldPacienteIdpersonaOfDatosconsultaCollectionDatosconsulta = em.merge(oldPacienteIdpersonaOfDatosconsultaCollectionDatosconsulta);
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findPaciente(paciente.getIdpersona()) != null) {
                throw new PreexistingEntityException("Paciente " + paciente + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Paciente paciente) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Paciente persistentPaciente = em.find(Paciente.class, paciente.getIdpersona());
            Collection<Medico> medicoCollectionOld = persistentPaciente.getMedicoCollection();
            Collection<Medico> medicoCollectionNew = paciente.getMedicoCollection();
            Collection<Examenfisicoestomatologico> examenfisicoestomatologicoCollectionOld = persistentPaciente.getExamenfisicoestomatologicoCollection();
            Collection<Examenfisicoestomatologico> examenfisicoestomatologicoCollectionNew = paciente.getExamenfisicoestomatologicoCollection();
            Collection<Diagnostico> diagnosticoCollectionOld = persistentPaciente.getDiagnosticoCollection();
            Collection<Diagnostico> diagnosticoCollectionNew = paciente.getDiagnosticoCollection();
            Collection<Datosconsulta> datosconsultaCollectionOld = persistentPaciente.getDatosconsultaCollection();
            Collection<Datosconsulta> datosconsultaCollectionNew = paciente.getDatosconsultaCollection();
            List<String> illegalOrphanMessages = null;
            for (Examenfisicoestomatologico examenfisicoestomatologicoCollectionOldExamenfisicoestomatologico : examenfisicoestomatologicoCollectionOld) {
                if (!examenfisicoestomatologicoCollectionNew.contains(examenfisicoestomatologicoCollectionOldExamenfisicoestomatologico)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Examenfisicoestomatologico " + examenfisicoestomatologicoCollectionOldExamenfisicoestomatologico + " since its pacienteidpersona field is not nullable.");
                }
            }
            for (Diagnostico diagnosticoCollectionOldDiagnostico : diagnosticoCollectionOld) {
                if (!diagnosticoCollectionNew.contains(diagnosticoCollectionOldDiagnostico)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Diagnostico " + diagnosticoCollectionOldDiagnostico + " since its pacienteIdpersona field is not nullable.");
                }
            }
            for (Datosconsulta datosconsultaCollectionOldDatosconsulta : datosconsultaCollectionOld) {
                if (!datosconsultaCollectionNew.contains(datosconsultaCollectionOldDatosconsulta)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Datosconsulta " + datosconsultaCollectionOldDatosconsulta + " since its pacienteIdpersona field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Collection<Medico> attachedMedicoCollectionNew = new ArrayList<Medico>();
            for (Medico medicoCollectionNewMedicoToAttach : medicoCollectionNew) {
                medicoCollectionNewMedicoToAttach = em.getReference(medicoCollectionNewMedicoToAttach.getClass(), medicoCollectionNewMedicoToAttach.getIdmedico());
                attachedMedicoCollectionNew.add(medicoCollectionNewMedicoToAttach);
            }
            medicoCollectionNew = attachedMedicoCollectionNew;
            paciente.setMedicoCollection(medicoCollectionNew);
            Collection<Examenfisicoestomatologico> attachedExamenfisicoestomatologicoCollectionNew = new ArrayList<Examenfisicoestomatologico>();
            for (Examenfisicoestomatologico examenfisicoestomatologicoCollectionNewExamenfisicoestomatologicoToAttach : examenfisicoestomatologicoCollectionNew) {
                examenfisicoestomatologicoCollectionNewExamenfisicoestomatologicoToAttach = em.getReference(examenfisicoestomatologicoCollectionNewExamenfisicoestomatologicoToAttach.getClass(), examenfisicoestomatologicoCollectionNewExamenfisicoestomatologicoToAttach.getIdexamenFisicoEstomatologico());
                attachedExamenfisicoestomatologicoCollectionNew.add(examenfisicoestomatologicoCollectionNewExamenfisicoestomatologicoToAttach);
            }
            examenfisicoestomatologicoCollectionNew = attachedExamenfisicoestomatologicoCollectionNew;
            paciente.setExamenfisicoestomatologicoCollection(examenfisicoestomatologicoCollectionNew);
            Collection<Diagnostico> attachedDiagnosticoCollectionNew = new ArrayList<Diagnostico>();
            for (Diagnostico diagnosticoCollectionNewDiagnosticoToAttach : diagnosticoCollectionNew) {
                diagnosticoCollectionNewDiagnosticoToAttach = em.getReference(diagnosticoCollectionNewDiagnosticoToAttach.getClass(), diagnosticoCollectionNewDiagnosticoToAttach.getIddiagnostico());
                attachedDiagnosticoCollectionNew.add(diagnosticoCollectionNewDiagnosticoToAttach);
            }
            diagnosticoCollectionNew = attachedDiagnosticoCollectionNew;
            paciente.setDiagnosticoCollection(diagnosticoCollectionNew);
            Collection<Datosconsulta> attachedDatosconsultaCollectionNew = new ArrayList<Datosconsulta>();
            for (Datosconsulta datosconsultaCollectionNewDatosconsultaToAttach : datosconsultaCollectionNew) {
                datosconsultaCollectionNewDatosconsultaToAttach = em.getReference(datosconsultaCollectionNewDatosconsultaToAttach.getClass(), datosconsultaCollectionNewDatosconsultaToAttach.getIddatosConsulta());
                attachedDatosconsultaCollectionNew.add(datosconsultaCollectionNewDatosconsultaToAttach);
            }
            datosconsultaCollectionNew = attachedDatosconsultaCollectionNew;
            paciente.setDatosconsultaCollection(datosconsultaCollectionNew);
            paciente = em.merge(paciente);
            for (Medico medicoCollectionOldMedico : medicoCollectionOld) {
                if (!medicoCollectionNew.contains(medicoCollectionOldMedico)) {
                    medicoCollectionOldMedico.getPacienteCollection().remove(paciente);
                    medicoCollectionOldMedico = em.merge(medicoCollectionOldMedico);
                }
            }
            for (Medico medicoCollectionNewMedico : medicoCollectionNew) {
                if (!medicoCollectionOld.contains(medicoCollectionNewMedico)) {
                    medicoCollectionNewMedico.getPacienteCollection().add(paciente);
                    medicoCollectionNewMedico = em.merge(medicoCollectionNewMedico);
                }
            }
            for (Examenfisicoestomatologico examenfisicoestomatologicoCollectionNewExamenfisicoestomatologico : examenfisicoestomatologicoCollectionNew) {
                if (!examenfisicoestomatologicoCollectionOld.contains(examenfisicoestomatologicoCollectionNewExamenfisicoestomatologico)) {
                    Paciente oldPacienteidpersonaOfExamenfisicoestomatologicoCollectionNewExamenfisicoestomatologico = examenfisicoestomatologicoCollectionNewExamenfisicoestomatologico.getPacienteidpersona();
                    examenfisicoestomatologicoCollectionNewExamenfisicoestomatologico.setPacienteidpersona(paciente);
                    examenfisicoestomatologicoCollectionNewExamenfisicoestomatologico = em.merge(examenfisicoestomatologicoCollectionNewExamenfisicoestomatologico);
                    if (oldPacienteidpersonaOfExamenfisicoestomatologicoCollectionNewExamenfisicoestomatologico != null && !oldPacienteidpersonaOfExamenfisicoestomatologicoCollectionNewExamenfisicoestomatologico.equals(paciente)) {
                        oldPacienteidpersonaOfExamenfisicoestomatologicoCollectionNewExamenfisicoestomatologico.getExamenfisicoestomatologicoCollection().remove(examenfisicoestomatologicoCollectionNewExamenfisicoestomatologico);
                        oldPacienteidpersonaOfExamenfisicoestomatologicoCollectionNewExamenfisicoestomatologico = em.merge(oldPacienteidpersonaOfExamenfisicoestomatologicoCollectionNewExamenfisicoestomatologico);
                    }
                }
            }
            for (Diagnostico diagnosticoCollectionNewDiagnostico : diagnosticoCollectionNew) {
                if (!diagnosticoCollectionOld.contains(diagnosticoCollectionNewDiagnostico)) {
                    Paciente oldPacienteIdpersonaOfDiagnosticoCollectionNewDiagnostico = diagnosticoCollectionNewDiagnostico.getPacienteIdpersona();
                    diagnosticoCollectionNewDiagnostico.setPacienteIdpersona(paciente);
                    diagnosticoCollectionNewDiagnostico = em.merge(diagnosticoCollectionNewDiagnostico);
                    if (oldPacienteIdpersonaOfDiagnosticoCollectionNewDiagnostico != null && !oldPacienteIdpersonaOfDiagnosticoCollectionNewDiagnostico.equals(paciente)) {
                        oldPacienteIdpersonaOfDiagnosticoCollectionNewDiagnostico.getDiagnosticoCollection().remove(diagnosticoCollectionNewDiagnostico);
                        oldPacienteIdpersonaOfDiagnosticoCollectionNewDiagnostico = em.merge(oldPacienteIdpersonaOfDiagnosticoCollectionNewDiagnostico);
                    }
                }
            }
            for (Datosconsulta datosconsultaCollectionNewDatosconsulta : datosconsultaCollectionNew) {
                if (!datosconsultaCollectionOld.contains(datosconsultaCollectionNewDatosconsulta)) {
                    Paciente oldPacienteIdpersonaOfDatosconsultaCollectionNewDatosconsulta = datosconsultaCollectionNewDatosconsulta.getPacienteIdpersona();
                    datosconsultaCollectionNewDatosconsulta.setPacienteIdpersona(paciente);
                    datosconsultaCollectionNewDatosconsulta = em.merge(datosconsultaCollectionNewDatosconsulta);
                    if (oldPacienteIdpersonaOfDatosconsultaCollectionNewDatosconsulta != null && !oldPacienteIdpersonaOfDatosconsultaCollectionNewDatosconsulta.equals(paciente)) {
                        oldPacienteIdpersonaOfDatosconsultaCollectionNewDatosconsulta.getDatosconsultaCollection().remove(datosconsultaCollectionNewDatosconsulta);
                        oldPacienteIdpersonaOfDatosconsultaCollectionNewDatosconsulta = em.merge(oldPacienteIdpersonaOfDatosconsultaCollectionNewDatosconsulta);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                String id = paciente.getIdpersona();
                if (findPaciente(id) == null) {
                    throw new NonexistentEntityException("The paciente with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(String id) throws IllegalOrphanException, NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Paciente paciente;
            try {
                paciente = em.getReference(Paciente.class, id);
                paciente.getIdpersona();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The paciente with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            Collection<Examenfisicoestomatologico> examenfisicoestomatologicoCollectionOrphanCheck = paciente.getExamenfisicoestomatologicoCollection();
            for (Examenfisicoestomatologico examenfisicoestomatologicoCollectionOrphanCheckExamenfisicoestomatologico : examenfisicoestomatologicoCollectionOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Paciente (" + paciente + ") cannot be destroyed since the Examenfisicoestomatologico " + examenfisicoestomatologicoCollectionOrphanCheckExamenfisicoestomatologico + " in its examenfisicoestomatologicoCollection field has a non-nullable pacienteidpersona field.");
            }
            Collection<Diagnostico> diagnosticoCollectionOrphanCheck = paciente.getDiagnosticoCollection();
            for (Diagnostico diagnosticoCollectionOrphanCheckDiagnostico : diagnosticoCollectionOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Paciente (" + paciente + ") cannot be destroyed since the Diagnostico " + diagnosticoCollectionOrphanCheckDiagnostico + " in its diagnosticoCollection field has a non-nullable pacienteIdpersona field.");
            }
            Collection<Datosconsulta> datosconsultaCollectionOrphanCheck = paciente.getDatosconsultaCollection();
            for (Datosconsulta datosconsultaCollectionOrphanCheckDatosconsulta : datosconsultaCollectionOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Paciente (" + paciente + ") cannot be destroyed since the Datosconsulta " + datosconsultaCollectionOrphanCheckDatosconsulta + " in its datosconsultaCollection field has a non-nullable pacienteIdpersona field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Collection<Medico> medicoCollection = paciente.getMedicoCollection();
            for (Medico medicoCollectionMedico : medicoCollection) {
                medicoCollectionMedico.getPacienteCollection().remove(paciente);
                medicoCollectionMedico = em.merge(medicoCollectionMedico);
            }
            em.remove(paciente);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Paciente> findPacienteEntities() {
        return findPacienteEntities(true, -1, -1);
    }

    public List<Paciente> findPacienteEntities(int maxResults, int firstResult) {
        return findPacienteEntities(false, maxResults, firstResult);
    }

    private List<Paciente> findPacienteEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Paciente.class));
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

    public Paciente findPaciente(String id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Paciente.class, id);
        } finally {
            em.close();
        }
    }

    public int getPacienteCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Paciente> rt = cq.from(Paciente.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

}
