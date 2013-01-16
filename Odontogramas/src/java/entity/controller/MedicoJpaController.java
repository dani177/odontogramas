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
import entity.Paciente;
import java.util.ArrayList;
import java.util.List;
import entity.Docente;
import entity.Curso;
import entity.Consulta;
import entity.Medico;
import entity.controller.exceptions.IllegalOrphanException;
import entity.controller.exceptions.NonexistentEntityException;
import entity.controller.exceptions.PreexistingEntityException;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

/**
 *
 * @author jubarcos
 */
public class MedicoJpaController implements Serializable {

    public MedicoJpaController() {
    }

    public EntityManager getEntityManager() {
        return jpaConnection.getEntityManager();
    }

    public void create(Medico medico) throws PreexistingEntityException, Exception {
        if (medico.getPacienteList() == null) {
            medico.setPacienteList(new ArrayList<Paciente>());
        }
        if (medico.getDocenteList() == null) {
            medico.setDocenteList(new ArrayList<Docente>());
        }
        if (medico.getCursoList() == null) {
            medico.setCursoList(new ArrayList<Curso>());
        }
        if (medico.getConsultaList() == null) {
            medico.setConsultaList(new ArrayList<Consulta>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Paciente> attachedPacienteList = new ArrayList<Paciente>();
            for (Paciente pacienteListPacienteToAttach : medico.getPacienteList()) {
                pacienteListPacienteToAttach = em.getReference(pacienteListPacienteToAttach.getClass(), pacienteListPacienteToAttach.getIdpersona());
                attachedPacienteList.add(pacienteListPacienteToAttach);
            }
            medico.setPacienteList(attachedPacienteList);
            List<Docente> attachedDocenteList = new ArrayList<Docente>();
            for (Docente docenteListDocenteToAttach : medico.getDocenteList()) {
                docenteListDocenteToAttach = em.getReference(docenteListDocenteToAttach.getClass(), docenteListDocenteToAttach.getIddocente());
                attachedDocenteList.add(docenteListDocenteToAttach);
            }
            medico.setDocenteList(attachedDocenteList);
            List<Curso> attachedCursoList = new ArrayList<Curso>();
            for (Curso cursoListCursoToAttach : medico.getCursoList()) {
                cursoListCursoToAttach = em.getReference(cursoListCursoToAttach.getClass(), cursoListCursoToAttach.getIdcurso());
                attachedCursoList.add(cursoListCursoToAttach);
            }
            medico.setCursoList(attachedCursoList);
            List<Consulta> attachedConsultaList = new ArrayList<Consulta>();
            for (Consulta consultaListConsultaToAttach : medico.getConsultaList()) {
                consultaListConsultaToAttach = em.getReference(consultaListConsultaToAttach.getClass(), consultaListConsultaToAttach.getIddatosConsulta());
                attachedConsultaList.add(consultaListConsultaToAttach);
            }
            medico.setConsultaList(attachedConsultaList);
            em.persist(medico);
            for (Paciente pacienteListPaciente : medico.getPacienteList()) {
                pacienteListPaciente.getMedicoList().add(medico);
                pacienteListPaciente = em.merge(pacienteListPaciente);
            }
            for (Docente docenteListDocente : medico.getDocenteList()) {
                docenteListDocente.getMedicoList().add(medico);
                docenteListDocente = em.merge(docenteListDocente);
            }
            for (Curso cursoListCurso : medico.getCursoList()) {
                cursoListCurso.getMedicoList().add(medico);
                cursoListCurso = em.merge(cursoListCurso);
            }
            for (Consulta consultaListConsulta : medico.getConsultaList()) {
                Medico oldMedicoIdmedicoOfConsultaListConsulta = consultaListConsulta.getMedicoIdmedico();
                consultaListConsulta.setMedicoIdmedico(medico);
                consultaListConsulta = em.merge(consultaListConsulta);
                if (oldMedicoIdmedicoOfConsultaListConsulta != null) {
                    oldMedicoIdmedicoOfConsultaListConsulta.getConsultaList().remove(consultaListConsulta);
                    oldMedicoIdmedicoOfConsultaListConsulta = em.merge(oldMedicoIdmedicoOfConsultaListConsulta);
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findMedico(medico.getIdmedico()) != null) {
                throw new PreexistingEntityException("Medico " + medico + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Medico medico) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Medico persistentMedico = em.find(Medico.class, medico.getIdmedico());
            List<Paciente> pacienteListOld = persistentMedico.getPacienteList();
            List<Paciente> pacienteListNew = medico.getPacienteList();
            List<Docente> docenteListOld = persistentMedico.getDocenteList();
            List<Docente> docenteListNew = medico.getDocenteList();
            List<Curso> cursoListOld = persistentMedico.getCursoList();
            List<Curso> cursoListNew = medico.getCursoList();
            List<Consulta> consultaListOld = persistentMedico.getConsultaList();
            List<Consulta> consultaListNew = medico.getConsultaList();
            List<String> illegalOrphanMessages = null;
            for (Consulta consultaListOldConsulta : consultaListOld) {
                if (!consultaListNew.contains(consultaListOldConsulta)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Consulta " + consultaListOldConsulta + " since its medicoIdmedico field is not nullable.");
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
            medico.setPacienteList(pacienteListNew);
            List<Docente> attachedDocenteListNew = new ArrayList<Docente>();
            for (Docente docenteListNewDocenteToAttach : docenteListNew) {
                docenteListNewDocenteToAttach = em.getReference(docenteListNewDocenteToAttach.getClass(), docenteListNewDocenteToAttach.getIddocente());
                attachedDocenteListNew.add(docenteListNewDocenteToAttach);
            }
            docenteListNew = attachedDocenteListNew;
            medico.setDocenteList(docenteListNew);
            List<Curso> attachedCursoListNew = new ArrayList<Curso>();
            for (Curso cursoListNewCursoToAttach : cursoListNew) {
                cursoListNewCursoToAttach = em.getReference(cursoListNewCursoToAttach.getClass(), cursoListNewCursoToAttach.getIdcurso());
                attachedCursoListNew.add(cursoListNewCursoToAttach);
            }
            cursoListNew = attachedCursoListNew;
            medico.setCursoList(cursoListNew);
            List<Consulta> attachedConsultaListNew = new ArrayList<Consulta>();
            for (Consulta consultaListNewConsultaToAttach : consultaListNew) {
                consultaListNewConsultaToAttach = em.getReference(consultaListNewConsultaToAttach.getClass(), consultaListNewConsultaToAttach.getIddatosConsulta());
                attachedConsultaListNew.add(consultaListNewConsultaToAttach);
            }
            consultaListNew = attachedConsultaListNew;
            medico.setConsultaList(consultaListNew);
            medico = em.merge(medico);
            for (Paciente pacienteListOldPaciente : pacienteListOld) {
                if (!pacienteListNew.contains(pacienteListOldPaciente)) {
                    pacienteListOldPaciente.getMedicoList().remove(medico);
                    pacienteListOldPaciente = em.merge(pacienteListOldPaciente);
                }
            }
            for (Paciente pacienteListNewPaciente : pacienteListNew) {
                if (!pacienteListOld.contains(pacienteListNewPaciente)) {
                    pacienteListNewPaciente.getMedicoList().add(medico);
                    pacienteListNewPaciente = em.merge(pacienteListNewPaciente);
                }
            }
            for (Docente docenteListOldDocente : docenteListOld) {
                if (!docenteListNew.contains(docenteListOldDocente)) {
                    docenteListOldDocente.getMedicoList().remove(medico);
                    docenteListOldDocente = em.merge(docenteListOldDocente);
                }
            }
            for (Docente docenteListNewDocente : docenteListNew) {
                if (!docenteListOld.contains(docenteListNewDocente)) {
                    docenteListNewDocente.getMedicoList().add(medico);
                    docenteListNewDocente = em.merge(docenteListNewDocente);
                }
            }
            for (Curso cursoListOldCurso : cursoListOld) {
                if (!cursoListNew.contains(cursoListOldCurso)) {
                    cursoListOldCurso.getMedicoList().remove(medico);
                    cursoListOldCurso = em.merge(cursoListOldCurso);
                }
            }
            for (Curso cursoListNewCurso : cursoListNew) {
                if (!cursoListOld.contains(cursoListNewCurso)) {
                    cursoListNewCurso.getMedicoList().add(medico);
                    cursoListNewCurso = em.merge(cursoListNewCurso);
                }
            }
            for (Consulta consultaListNewConsulta : consultaListNew) {
                if (!consultaListOld.contains(consultaListNewConsulta)) {
                    Medico oldMedicoIdmedicoOfConsultaListNewConsulta = consultaListNewConsulta.getMedicoIdmedico();
                    consultaListNewConsulta.setMedicoIdmedico(medico);
                    consultaListNewConsulta = em.merge(consultaListNewConsulta);
                    if (oldMedicoIdmedicoOfConsultaListNewConsulta != null && !oldMedicoIdmedicoOfConsultaListNewConsulta.equals(medico)) {
                        oldMedicoIdmedicoOfConsultaListNewConsulta.getConsultaList().remove(consultaListNewConsulta);
                        oldMedicoIdmedicoOfConsultaListNewConsulta = em.merge(oldMedicoIdmedicoOfConsultaListNewConsulta);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = medico.getIdmedico();
                if (findMedico(id) == null) {
                    throw new NonexistentEntityException("The medico with id " + id + " no longer exists.");
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
            Medico medico;
            try {
                medico = em.getReference(Medico.class, id);
                medico.getIdmedico();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The medico with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<Consulta> consultaListOrphanCheck = medico.getConsultaList();
            for (Consulta consultaListOrphanCheckConsulta : consultaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Medico (" + medico + ") cannot be destroyed since the Consulta " + consultaListOrphanCheckConsulta + " in its consultaList field has a non-nullable medicoIdmedico field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<Paciente> pacienteList = medico.getPacienteList();
            for (Paciente pacienteListPaciente : pacienteList) {
                pacienteListPaciente.getMedicoList().remove(medico);
                pacienteListPaciente = em.merge(pacienteListPaciente);
            }
            List<Docente> docenteList = medico.getDocenteList();
            for (Docente docenteListDocente : docenteList) {
                docenteListDocente.getMedicoList().remove(medico);
                docenteListDocente = em.merge(docenteListDocente);
            }
            List<Curso> cursoList = medico.getCursoList();
            for (Curso cursoListCurso : cursoList) {
                cursoListCurso.getMedicoList().remove(medico);
                cursoListCurso = em.merge(cursoListCurso);
            }
            em.remove(medico);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Medico> findMedicoEntities() {
        return findMedicoEntities(true, -1, -1);
    }

    public List<Medico> findMedicoEntities(int maxResults, int firstResult) {
        return findMedicoEntities(false, maxResults, firstResult);
    }

    private List<Medico> findMedicoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Medico.class));
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

    public Medico findMedico(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Medico.class, id);
        } finally {
            em.close();
        }
    }

    public int getMedicoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Medico> rt = cq.from(Medico.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
