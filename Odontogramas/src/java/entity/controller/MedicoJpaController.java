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
import entity.Datosconsulta;
import entity.Medico;
import entity.controller.exceptions.IllegalOrphanException;
import entity.controller.exceptions.NonexistentEntityException;
import entity.controller.exceptions.PreexistingEntityException;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

/**
 *
 * @author Oscar
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
        if (medico.getDatosconsultaList() == null) {
            medico.setDatosconsultaList(new ArrayList<Datosconsulta>());
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
            List<Datosconsulta> attachedDatosconsultaList = new ArrayList<Datosconsulta>();
            for (Datosconsulta datosconsultaListDatosconsultaToAttach : medico.getDatosconsultaList()) {
                datosconsultaListDatosconsultaToAttach = em.getReference(datosconsultaListDatosconsultaToAttach.getClass(), datosconsultaListDatosconsultaToAttach.getIddatosConsulta());
                attachedDatosconsultaList.add(datosconsultaListDatosconsultaToAttach);
            }
            medico.setDatosconsultaList(attachedDatosconsultaList);
            em.persist(medico);
            for (Paciente pacienteListPaciente : medico.getPacienteList()) {
                pacienteListPaciente.getMedicoList().add(medico);
                pacienteListPaciente = em.merge(pacienteListPaciente);
            }
            for (Docente docenteListDocente : medico.getDocenteList()) {
                docenteListDocente.getMedicoList().add(medico);
                docenteListDocente = em.merge(docenteListDocente);
            }
            for (Datosconsulta datosconsultaListDatosconsulta : medico.getDatosconsultaList()) {
                Medico oldMedicoIdmedicoOfDatosconsultaListDatosconsulta = datosconsultaListDatosconsulta.getMedicoIdmedico();
                datosconsultaListDatosconsulta.setMedicoIdmedico(medico);
                datosconsultaListDatosconsulta = em.merge(datosconsultaListDatosconsulta);
                if (oldMedicoIdmedicoOfDatosconsultaListDatosconsulta != null) {
                    oldMedicoIdmedicoOfDatosconsultaListDatosconsulta.getDatosconsultaList().remove(datosconsultaListDatosconsulta);
                    oldMedicoIdmedicoOfDatosconsultaListDatosconsulta = em.merge(oldMedicoIdmedicoOfDatosconsultaListDatosconsulta);
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
            List<Datosconsulta> datosconsultaListOld = persistentMedico.getDatosconsultaList();
            List<Datosconsulta> datosconsultaListNew = medico.getDatosconsultaList();
            List<String> illegalOrphanMessages = null;
            for (Datosconsulta datosconsultaListOldDatosconsulta : datosconsultaListOld) {
                if (!datosconsultaListNew.contains(datosconsultaListOldDatosconsulta)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Datosconsulta " + datosconsultaListOldDatosconsulta + " since its medicoIdmedico field is not nullable.");
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
            List<Datosconsulta> attachedDatosconsultaListNew = new ArrayList<Datosconsulta>();
            for (Datosconsulta datosconsultaListNewDatosconsultaToAttach : datosconsultaListNew) {
                datosconsultaListNewDatosconsultaToAttach = em.getReference(datosconsultaListNewDatosconsultaToAttach.getClass(), datosconsultaListNewDatosconsultaToAttach.getIddatosConsulta());
                attachedDatosconsultaListNew.add(datosconsultaListNewDatosconsultaToAttach);
            }
            datosconsultaListNew = attachedDatosconsultaListNew;
            medico.setDatosconsultaList(datosconsultaListNew);
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
            for (Datosconsulta datosconsultaListNewDatosconsulta : datosconsultaListNew) {
                if (!datosconsultaListOld.contains(datosconsultaListNewDatosconsulta)) {
                    Medico oldMedicoIdmedicoOfDatosconsultaListNewDatosconsulta = datosconsultaListNewDatosconsulta.getMedicoIdmedico();
                    datosconsultaListNewDatosconsulta.setMedicoIdmedico(medico);
                    datosconsultaListNewDatosconsulta = em.merge(datosconsultaListNewDatosconsulta);
                    if (oldMedicoIdmedicoOfDatosconsultaListNewDatosconsulta != null && !oldMedicoIdmedicoOfDatosconsultaListNewDatosconsulta.equals(medico)) {
                        oldMedicoIdmedicoOfDatosconsultaListNewDatosconsulta.getDatosconsultaList().remove(datosconsultaListNewDatosconsulta);
                        oldMedicoIdmedicoOfDatosconsultaListNewDatosconsulta = em.merge(oldMedicoIdmedicoOfDatosconsultaListNewDatosconsulta);
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
            List<Datosconsulta> datosconsultaListOrphanCheck = medico.getDatosconsultaList();
            for (Datosconsulta datosconsultaListOrphanCheckDatosconsulta : datosconsultaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Medico (" + medico + ") cannot be destroyed since the Datosconsulta " + datosconsultaListOrphanCheckDatosconsulta + " in its datosconsultaList field has a non-nullable medicoIdmedico field.");
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
